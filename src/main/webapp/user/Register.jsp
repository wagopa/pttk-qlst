<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký - Siêu Thị</title>
<link rel="stylesheet" href="../styles/style.css">
<link rel="stylesheet" href="../styles/login.css">
</head>
<body>
	<div class="login-container">
		<div class="login-form">
	        <div class="login-header">
	            <h2>Đăng Ký</h2>
	            <p>Hệ thống siêu thị điện máy</p>
	        </div>
	        
	        <form action="register" method="post">
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
	            
	            <div class="form-group">
	                <label for="confirmed-password">Xác nhận mật khẩu</label>
	                <input type="password" 
	                       class="form-control" 
	                       id="confirmed-password" 
	                       name="confirmedPassword" 
	                       required 
	                       placeholder="Nhập lại mật khẩu">
	            </div>
	            
	            <button type="submit" class="btn-login">ĐĂNG KÝ</button>
	        </form>

            <div class="footer-text">
                Đã tài khoản? <a href="Login.jsp">Đăng nhập ngay</a>
            </div>
	    </div>
    </div>
</body>
</html>