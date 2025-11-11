package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDAO;
import model.Employee;
import model.ImportDetails;
import model.Product;

@WebServlet("/warehousestaff/product")
public class ProductServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
	    Employee emp = (Employee) session.getAttribute("user");
	    if (emp == null || !"Employee".equals(emp.getRole())) {
	        response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
	        return;
	    }

	    List<ImportDetails> tempDetails = (List<ImportDetails>) session.getAttribute("tempImportDetails");
	    if (tempDetails == null) {
	        tempDetails = new ArrayList<>();
	        session.setAttribute("tempImportDetails", tempDetails);
	    }

	    String action = request.getParameter("action");
	    ProductDAO productDAO = new ProductDAO();

	    if ("searchProduct".equals(action)) {
	        String productName = request.getParameter("productName");
	        if (productName == null || productName.trim().isEmpty()) {
	            productName = "";
	        }
	        List<Product> products = productDAO.searchProduct(productName);
	        request.setAttribute("products", products);
	        request.setAttribute("searchKeyword", productName);
	    }

	    request.getRequestDispatcher("/warehousestaff/SearchProduct.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        Employee emp = (Employee) session.getAttribute("user");
        if (emp == null || !"Employee".equals(emp.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        ProductDAO productDAO = new ProductDAO();

        // Lấy danh sách tạm từ session
        List<ImportDetails> tempDetails = (List<ImportDetails>) session.getAttribute("tempImportDetails");
        if (tempDetails == null) {
            tempDetails = new ArrayList<>();
            session.setAttribute("tempImportDetails", tempDetails);
        }

        if ("selectProduct".equals(action)) {
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    Product product = productDAO.getProductById(productId);
                    if (product != null) {
                    	// Tìm xem đã có trong danh sách chưa?
                        boolean found = false;
                        for (ImportDetails d : tempDetails) {
                            if (d.getProductId() == productId) {
                                d.setQuantity(d.getQuantity() + 1); // Cộng dồn số lượng
                                found = true;
                                break;
                            }
                        }
                        // Nếu chưa có thì thêm mới
                        if (!found) {
                            ImportDetails detail = new ImportDetails(1, product.getPrice(), product);
                            tempDetails.add(detail);
                        }
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            // Giữ lại từ khóa tìm kiếm
            String productName = request.getParameter("productName");
            if (productName == null) productName = "";
            List<Product> products = productDAO.searchProduct(productName);
            request.setAttribute("products", products);
            request.setAttribute("searchKeyword", productName);

            request.getRequestDispatcher("/warehousestaff/SearchProduct.jsp").forward(request, response);
            return;
        }
        
        if ("updateDetails".equals(action)) {
            // Cập nhật số lượng và giá
            for (int i = 0; i < tempDetails.size(); i++) {
                String qtyParam = request.getParameter("qty_" + i);
                String priceParam = request.getParameter("price_" + i);

                if (qtyParam != null && priceParam != null) {
                    try {
                        int qty = Integer.parseInt(qtyParam);
                        float price = Float.parseFloat(priceParam);
                        if (qty > 0 && price >= 0) {
                            tempDetails.get(i).setQuantity(qty);
                            tempDetails.get(i).setPrice(price);
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
            }

            // Xử lý xóa
            String removeIndex = request.getParameter("removeIndex");
            if (removeIndex != null) {
                try {
                    int idx = Integer.parseInt(removeIndex);
                    if (idx >= 0 && idx < tempDetails.size()) {
                        tempDetails.remove(idx);
                    }
                } catch (NumberFormatException e) {
                    // Bỏ qua
                }
            }

         // LẤY LẠI KẾT QUẢ TÌM KIẾM
            String productName = request.getParameter("productName");
            if (productName == null) productName = "";
            List<Product> products = productDAO.searchProduct(productName);
            request.setAttribute("products", products);
            request.setAttribute("searchKeyword", productName);

            request.getRequestDispatcher("/warehousestaff/SearchProduct.jsp").forward(request, response);
            return;
        }

        if ("confirmProducts".equals(action)) {
            // Lưu danh sách vào session để ImportProduct.jsp đọc
            if (!tempDetails.isEmpty()) {
                session.setAttribute("importDetails", new ArrayList<>(tempDetails));
            }
            // Xóa tạm
            session.removeAttribute("tempImportDetails");

            // CHUYỂN VỀ IMPORTPRODUCT.JSP
            response.sendRedirect(request.getContextPath() + "/warehousestaff/ImportProduct.jsp");
            return;
        }
	}

}
