<%@page import="model.User"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký Thành Viên - Siêu Thị</title>
<link rel="stylesheet" href="../styles/style.css">
<link rel="stylesheet" href="../styles/membership.css">
</head>
<body>
	<%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("../user/Login.jsp");
            return;
        }
        LocalDate today = LocalDate.now();
    %>

    <div class="register-container">
        <header class="register-header">
            <h2>Đăng Ký Thành Viên</h2>
            <p>Trở thành thành viên siêu thị ngay hôm nay</p>
        </header>

        <div class="user-info">
            Khách hàng: <strong><%= user.getFullName() %></strong> <%-- (ID: <%= user.getId() %>) --%>
        </div>

        <form action="<%= request.getContextPath() %>/customer/membership-register" method="post" class="membership-form">
            
            <div class="form-group">
                <label for="membershipType">Loại thành viên <span class="required">*</span></label>
                <select name="type" id="membershipType" required class="form-control">
                    <option value="">-- Chọn loại --</option>
                    <option value="Silver">Thành viên bạc (Silver)</option>
                    <option value="Gold">Thành viên vàng (Gold)</option>
                    <option value="Platinum">Thành viên bạch kim (Platinum)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="startDate">Ngày bắt đầu <span class="required">*</span></label>
                <input type="date" 
			           name="startDate" 
			           id="startDate" 
			           value="<%= java.time.LocalDate.now() %>"
			           min="<%= java.time.LocalDate.now() %>"
			           required 
			           class="form-control">
			           
            </div>
            
            <div class="membership-note">
			    <svg class="icon-info" viewBox="0 0 16 16" width="16" height="16" fill="currentColor">
			        <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
			    </svg>
    			<span>
	    			<strong>Lưu ý:</strong> Tư cách thành viên có hiệu lực trong vòng <strong>30 ngày</strong> kể từ ngày bắt đầu<br>
				</span>
			</div>

            <div class="form-actions">
                <button type="submit" class="btn-register">Đăng ký ngay</button>
                <a href="<%= request.getContextPath() %>/customer/CustomerHome.jsp" class="btn-cancel">Hủy</a>
            </div>
        </form>

        <% 
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
        %>
        <% if (message != null) { %>
            <div class="alert success"><%= message %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="alert error"><%= error %></div>
        <% } %>
    </div>
</body>
</html>