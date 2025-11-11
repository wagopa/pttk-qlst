package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ImportSlipDAO;
import dao.ProductDAO;
import model.Employee;
import model.ImportDetails;
import model.ImportSlip;
import model.Supplier;

@WebServlet("/warehousestaff/import")
public class ImportServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Employee emp = (Employee) session.getAttribute("user");
        if (emp == null || !"Employee".equals(emp.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("saveImport".equals(action)) {
            // Lấy dữ liệu từ session
            Supplier supplier = (Supplier) session.getAttribute("selectedSupplier");
            List<ImportDetails> details = (List<ImportDetails>) session.getAttribute("importDetails");

            if (supplier == null || details == null || details.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/warehousestaff/ImportProduct.jsp");
                return;
            }
            // COPY DỮ LIỆU TRƯỚC KHI XÓA
            List<ImportDetails> detailsToSave = new ArrayList<>(details);

            // Tạo ImportSlip
            ImportSlip slip = new ImportSlip();
            slip.setDate(Date.valueOf(LocalDate.now()));
            slip.setSupplierId(supplier.getId());
            slip.setWarehouseStaffId(emp.getId());
            slip.setImportDetailsList(detailsToSave);
            
            ImportSlipDAO importSlipDAO = new ImportSlipDAO();

            // Lưu vào DB
            boolean success = importSlipDAO.addImportSlip(slip);
            
            ProductDAO productDAO = new ProductDAO();
            
            try {
                for (ImportDetails d : detailsToSave) {
                    productDAO.updateQuantity(d.getProductId(), d.getQuantity());
                }
            } catch (SQLException e) {
            	e.printStackTrace();
                request.setAttribute("errorMessage", "Cập nhật kho thất bại: " + e.getMessage());
                request.getRequestDispatcher("/warehousestaff/ImportProduct.jsp").forward(request, response);
                return;
            }

            if (success) {
                // Xóa dữ liệu tạm
                session.removeAttribute("selectedSupplier");
                session.removeAttribute("importDetails");
                session.removeAttribute("tempImportDetails");

                // Chuyển sang xem hóa đơn
                session.setAttribute("currentImportSlip", slip);
                session.setAttribute("currentImportDetails", detailsToSave);
                session.setAttribute("currentSupplier", supplier);

                response.sendRedirect(request.getContextPath() + "/warehousestaff/ImportSlip.jsp");
            } else {
//                request.setAttribute("error", "Lưu hóa đơn thất bại!");
                request.setAttribute("errorMessage", "Lưu phiếu nhập thất bại! Vui lòng thử lại.");
                request.getRequestDispatcher("/warehousestaff/ImportProduct.jsp").forward(request, response);
            }
        }
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
