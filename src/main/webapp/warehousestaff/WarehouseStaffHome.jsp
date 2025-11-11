<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Employee" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ Kho - Siêu Thị</title>
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
    %>

    <div class="home-container">
        <header class="home-header">
            <h2>Trang Chủ Nhân Viên Kho</h2>
            <p>Hệ thống siêu thị điện máy - Quản lý trong tầm tay</p>
        </header>
        
        <div class="user-info">
                Xin chào, <strong><%= user.getFullName() %></strong>!
        </div>

        <div class="home-menu">
            <a href="<%= request.getContextPath() %>/warehousestaff/ImportProduct.jsp">Nhập hàng từ nhà cung cấp</a>
            <a href="#">Quản lý thông tin nhà cung cấp</a>
            <a href="#">Quản lý thông tin mặt hàng</a>
            <a href="#">Duyệt đơn hàng trực tuyến</a>
            <a href="#">Xuất cho nhân viên giao hàng</a>
            <a id= "btn-logout" href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
        </div>
    </div>
</body>
</html>