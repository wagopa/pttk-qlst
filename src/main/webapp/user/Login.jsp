<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Nhập - Siêu Thị</title>
<link rel="stylesheet" href="../styles/style.css">
<link rel="stylesheet" href="../styles/login.css">
</head>
<body>
	<div class="login-container">
		<div class="login-form">
	        <div class="login-header">
	            <h2>Đăng Nhập</h2>
	            <p>Hệ thống siêu thị điện máy</p>
	        </div>
	        
	        <% 
	            String error = (String) request.getAttribute("error");
	            request.removeAttribute("error");
        	%>

	        <% if (request.getAttribute("error") != null) { %>
	            <div class="error-message">
	                <%= request.getAttribute("error") %>
	            </div>
	        <% } %>
	        
	        <form action="login" method="post">
	            <div class="form-group">
	                <label for="username">Tên đăng nhập</label>
	                <input type="text" 
	                       class="form-control" 
	                       id="username" 
	                       name="username" 
	                       required 
	                       placeholder="Nhập tên đăng nhập">
	            </div>
	            
	            <div class="form-group">
	                <label for="password">Mật khẩu</label>
	                <input type="password"
	                       class="form-control" 
	                       id="password" 
	                       name="password" 
	                       required 
	                       placeholder="Nhập mật khẩu">
	            </div>
	            
	            <button type="submit" class="btn-login">ĐĂNG NHẬP</button>
	        </form>

            <div class="footer-text">
                Chưa có tài khoản? <a href="Register.jsp">Đăng ký ngay</a>
            </div>
	    </div>
    </div>
</body>
</html>