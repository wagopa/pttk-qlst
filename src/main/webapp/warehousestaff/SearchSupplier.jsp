<%@page import="model.User"%>
<%@page import="model.Supplier"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tìm Nhà Cung Cấp</title>
<link rel="stylesheet" href="../styles/style.css">
<link rel="stylesheet" href="../styles/import-product.css">
</head>
<body>
	<%
		User user = (User) session.getAttribute("user");
	    if (user == null) {
	        response.sendRedirect("../user/Login.jsp");
	        return;
	    }
    
        List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");
    %>

    <div class="import-container">
   		<header class="import-header">
            <h2>Tìm Kiếm Nhà Cung Cấp</h2>
            <p>Hệ thống siêu thị điện máy - Nhập hàng từ nhà cung cấp</p>
        </header>
        
        <form action="<%= request.getContextPath() %>/warehousestaff/supplier" method="get" class="search-form">
            <input type="hidden" name="action" value="searchSupplier">
            <div class="search-bar">
                <input type="text" name="supplierName" placeholder="Nhập tên nhà cung cấp..." 
                       value="<%= request.getParameter("supplierName") != null ? request.getParameter("supplierName") : "" %>"
                       required class="search-input">
                <button type="submit" class="btn-styled btn-search">Tìm Kiếm</button>
                <a href="<%= request.getContextPath() %>/warehousestaff/AddSupplier.jsp" 
                   class="btn-styled btn-product btn-add-new">+ Thêm Mới</a>
            </div>
        </form>

        <!-- BẢNG KẾT QUẢ -->
        <% if (suppliers != null && !suppliers.isEmpty()) { %>
            <div class="table-container">
                <table class="result-table styled-table">
                    <thead>
                        <tr>
                            <th class="col-id">ID</th>
                            <th class="col-name">Tên NCC</th>
                            <th>Số điện thoại</th>
                            <th class="col-name">Địa chỉ</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Supplier s : suppliers) { %>
                            <tr>
                                <td class="col-id"><%= s.getId() %></td>
                                <td class="col-name"><%= s.getName() %></td>
                                <td><%= s.getPhone() %></td>
                                <td class="col-name"><%= s.getAddress() %></td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/warehousestaff/supplier" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="selectSupplier">
                                        <input type="hidden" name="supplierId" value="<%= s.getId() %>">
                                        <button type="submit" class="btn-select-small">Chọn</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else if (suppliers != null) { %>
            <p class="text-center" style="margin: 2rem 0; color: #e74c3c; font-weight: 500;">
                Không tìm thấy nhà cung cấp nào phù hợp.
            </p>
        <% } %>

        <!-- NÚT QUAY LẠI -->
        <div class="action-buttons" style="margin-top: 2rem; justify-content: center;">
            <a href="<%= request.getContextPath() %>/warehousestaff/ImportProduct.jsp" 
               class="btn btn-cancel">Quay Lại</a>
        </div>
    </div>
</body>
</html>