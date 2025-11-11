<%@page import="model.Membership"%>
<%@page import="dao.MembershipDAO"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ Khách Hàng - Siêu Thị</title>
<link rel="stylesheet" href="../styles/style.css">
<link rel="stylesheet" href="../styles/home.css">
</head>
<body>
	<%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("../user/Login.jsp");
            return;
        }
        
        MembershipDAO memDAO = new MembershipDAO();
        Membership membership = memDAO.getActiveMembershipByCustomerId(user.getId());
        boolean isMember = (membership != null);
        boolean isExpired = (membership != null && membership.getEndDate().toLocalDate().isBefore(LocalDate.now()));
    %>

    <div class="home-container">
        <header class="home-header">
            <h2>Trang Chủ Khách Hàng</h2>
            <p>Hệ thống siêu thị điện máy - Dịch vụ tiện lợi cho bạn</p>
        </header>
        
        <div class="user-info">
            Xin chào, <strong><%= user.getFullName() %></strong>!
        </div>
        
        <div class="membership-status">
	        <% if (isMember && !isExpired) { %>
	            <p>
	                Thành viên <strong class="status-active"><%= membership.getType() %></strong> 
	                <span class="expiry">(Hết hạn: <%= membership.getEndDate() %>)</span>
	            </p>
	        <% } else if (isMember && isExpired) { %>
	            <p>
	                <span class="status-expired">Thành viên <%= membership.getType() %> đã hết hạn</span>
	            </p>
	        <% } else { %>
	            <p>Bạn chưa là thành viên</p>
	        <% } %>
    	</div>

        <div class="home-menu">
            <a href="<%= request.getContextPath() %>/customer/MembershipRegister.jsp">Đăng ký thành viên</a>
            <a href="#">Tìm kiếm mặt hàng</a>
            <a href="#">Đặt hàng trực tuyến</a>
            <a id="btn-logout" href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
        </div>
    </div>
</body>
</html>