package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SupplierDAO;
import model.Employee;
import model.Supplier;

@WebServlet("/warehousestaff/supplier")
public class SupplierServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        Employee emp = (Employee) session.getAttribute("user");
        if (emp == null || !"Employee".equals(emp.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        SupplierDAO supplierDAO = new SupplierDAO();

        if ("searchSupplier".equals(action)) {
            String supplierName = request.getParameter("supplierName");
            if (supplierName == null || supplierName.trim().isEmpty()) {
                supplierName = "";
            }

            List<Supplier> suppliers = supplierDAO.searchSupplier(supplierName);
            request.setAttribute("suppliers", suppliers);
            request.setAttribute("searchKeyword", supplierName);

            request.getRequestDispatcher("/warehousestaff/SearchSupplier.jsp")
                   .forward(request, response);

        } else {
            request.getRequestDispatcher("/warehousestaff/SearchSupplier.jsp")
                   .forward(request, response);
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        Employee emp = (Employee) session.getAttribute("user");
        if (emp == null || !"Employee".equals(emp.getRole())) {
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        SupplierDAO supplierDAO = new SupplierDAO();

        if ("selectSupplier".equals(action)) {
            String supplierIdStr = request.getParameter("supplierId");
            if (supplierIdStr != null && !supplierIdStr.isEmpty()) {
                int supplierId = Integer.parseInt(supplierIdStr);
                Supplier selected = supplierDAO.getSupplierById(supplierId);

                if (selected != null) {
                    session.setAttribute("selectedSupplier", selected);
                }
            }

            response.sendRedirect(request.getContextPath() + "/warehousestaff/ImportProduct.jsp");
        }
	}

}
