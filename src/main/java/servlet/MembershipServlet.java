package servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MembershipDAO;
import model.Membership;
import model.User;

@WebServlet("/customer/membership-register")
public class MembershipServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }

        String type = request.getParameter("type");
        String startDateStr = request.getParameter("startDate");

        if (type == null || type.isEmpty() || startDateStr == null || startDateStr.isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("/customer/MembershipRegister.jsp").forward(request, response);
            return;
        }

        try {
            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate today = LocalDate.now();
            Date startSql = Date.valueOf(startDate);
            Date endSql = Date.valueOf(startDate.plusDays(30));
            User user = (User) session.getAttribute("user");
            
            if (startDate.isBefore(today)) {
                request.setAttribute("error", "Ngày bắt đầu không được nhỏ hơn hôm nay!");
                request.getRequestDispatcher("/customer/MembershipRegister.jsp").forward(request, response);
                return;
            }

            Membership membership = new Membership(user.getId(), type, startSql);
            MembershipDAO dao = new MembershipDAO();
            
            Membership existing = dao.getActiveMembershipByCustomerId(user.getId());
            if (existing != null) {
                request.setAttribute("error", "Bạn đã là thành viên " + existing.getType() + " đến " + existing.getEndDate());
                request.getRequestDispatcher("/customer/MembershipRegister.jsp").forward(request, response);
                return;
            }

            if (dao.registerMembership(membership)) {
                request.setAttribute("message", "Đăng ký thành công! Hiệu lực đến: " + endSql);
                
            } else {
                request.setAttribute("error", "Đã xảy ra lỗi khi lưu dữ liệu.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

    	request.getRequestDispatcher("/customer/MembershipRegister.jsp").forward(request, response);
    	
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }

        request.getRequestDispatcher("/customer/MembershipRegister.jsp").forward(request, response);
	}

}
