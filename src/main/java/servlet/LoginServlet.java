package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.EmployeeDAO;
import dao.UserDAO;
import model.Employee;
import model.User;

@WebServlet("/user/login")
public class LoginServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
				
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		
		UserDAO userDAO = new UserDAO();
		EmployeeDAO empDAO = new EmployeeDAO();
		
		boolean isValid = userDAO.checkLogin(user);
		
		if (isValid) {
			HttpSession session = request.getSession();
			
			if (user.getRole().equals("Customer")) {
				session.setAttribute("user", user);
				
				try {
					response.sendRedirect("../customer/CustomerHome.jsp");
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			} else if (user.getRole().equals("Employee")) {
				Employee employee = new Employee();
                employee.setId(user.getId());
                employee.setFullName(user.getFullName());
                employee.setDob(user.getDob());
                employee.setAddress(user.getAddress());
                employee.setEmail(user.getEmail());
                employee.setPhone(user.getPhone());
                employee.setRole(user.getRole());
                
                String position = empDAO.getPositionById(user.getId());
                employee.setPosition(position);
                
                session.setAttribute("user", employee);
                
                try {
                	switch (position) {
                	case "Manager":
                		response.sendRedirect("../manager/ManagerHome.jsp");
                		break;
                	case "Seller":
                		response.sendRedirect("../seller/SellerHome.jsp");
                		break;
                	case "WarehouseStaff":
                		response.sendRedirect("../warehousestaff/WarehouseStaffHome.jsp");
                		break;
                	default:
                		response.sendRedirect("EmployeeHome.jsp");
                	}
                	
                } catch (IOException e) {
                	e.printStackTrace();
                }
            }
		} else {
			request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
			
            try {
				request.getRequestDispatcher("Login.jsp").forward(request, response);
				
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
		
	}
}
