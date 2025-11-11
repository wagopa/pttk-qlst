<%@page import="model.Product"%>
<%@page import="model.Employee"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="model.User, model.Supplier, model.ImportDetails, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nhập Hàng Từ Nhà Cung Cấp</title>
<link rel="stylesheet" href="../styles/style.css">
<link rel="stylesheet" href="../styles/import-product.css">
</head>
<body>
	<%
	Employee emp = (Employee) session.getAttribute("user");
	if (emp == null || !"Employee".equals(emp.getRole())) {
		response.sendRedirect("../user/Login.jsp");
		return;
	}

	Supplier supplier = (Supplier) session.getAttribute("selectedSupplier");
	/* if (supplier != null) {
	session.removeAttribute("selectedSupplier");
	} */

	List<ImportDetails> importDetails = (List<ImportDetails>) session.getAttribute("importDetails");
	if (importDetails == null)
		importDetails = List.of();
	/* else {
	session.removeAttribute("importDetails");
	} */
	double totalAmount = 0;
	for (ImportDetails detail : importDetails) {
		totalAmount += detail.getQuantity() * detail.getPrice();
	}
	%>
	
	
	<%
	if (request.getAttribute("errorMessage") != null) {
	%>
	<div class="alert alert-error"
		style="text-align: center; padding: 1rem; background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 8px; margin: 1rem 0;">
		<strong>LỖI!</strong>
		<%=request.getAttribute("errorMessage")%>
	</div>
	<%
	}
	%>

	<!-- MAIN CONTENT -->
	<div class="import-container">
		<header class="import-header">
			<h2>Nhập Hàng Từ Nhà Cung Cấp</h2>
			<p>Hệ thống siêu thị điện máy - Quản lý trong tầm tay</p>
		</header>

		<div class="search-links">
			<a
				href="<%=request.getContextPath()%>/warehousestaff/SearchSupplier.jsp"
				class="btn-styled"> Tìm kiếm nhà cung cấp </a> <a
				href="<%=request.getContextPath()%>/warehousestaff/SearchProduct.jsp"
				class="btn-styled btn-product"> Tìm kiếm mặt hàng </a>
		</div>

		<!-- THÔNG TIN NHÂN VIÊN -->
		<div class="info-section">
			<p>
				<strong>Nhân viên nhập:</strong>
				<%=emp.getFullName()%>
				<%-- (ID: <%= emp.getId() %>) --%>
			</p>
		</div>

		<!-- THÔNG TIN NHÀ CUNG CẤP -->
		<div class="info-section supplier-info">
			<%
			if (supplier != null) {
			%>
			<p>
				<strong>Nhà cung cấp:</strong>
				<%=supplier.getName()%></p>
			<p>
				<strong>Địa chỉ:</strong>
				<%=supplier.getAddress()%></p>
			<p>
				<strong>Số điện thoại:</strong>
				<%=supplier.getPhone()%></p>
			<%
			} else {
			%>
			<p class="text-muted">Chưa chọn nhà cung cấp</p>
			<%
			}
			%>
		</div>

		<!-- BẢNG SẢN PHẨM -->
		<div class="table-container">
			<table class="import-table styled-table">
				<thead>
					<tr>
						<th class="col-stt">STT</th>
						<th class="col-name">Tên mặt hàng</th>
						<th class="col-id">ID</th>
						<th class="col-qty">Số lượng</th>
						<th class="col-price">Đơn giá (VNĐ)</th>
						<th class="col-total">Thành tiền (VNĐ)</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (importDetails.isEmpty()) {
					%>
					<tr>
						<td colspan="6" class="text-center">Chưa có mặt hàng nào</td>
					</tr>
					<%
					} else {
					for (int i = 0; i < importDetails.size(); i++) {
						ImportDetails d = importDetails.get(i);
						double lineTotal = d.getQuantity() * d.getPrice();
					%>
					<tr>
						<td class="col-stt"><%=i + 1%></td>
						<td class="col-name"><%=d.getProduct().getName()%></td>
						<td class="col-id"><%=d.getProductId()%></td>
						<td class="col-qty"><%=d.getQuantity()%></td>
						<td class="col-price"><%=String.format("%,.0f", d.getPrice())%></td>
						<td class="col-total"><%=String.format("%,.0f", lineTotal)%></td>
					</tr>
					<%
					}
					}
					%>
					<tr class="total-row">
						<td class="col-total total-word" colspan="5"><strong>TỔNG TIỀN:</strong></td>
						<td class="col-total"><strong><%=String.format("%,.0f", totalAmount)%>
								VNĐ</strong></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- NÚT HÀNH ĐỘNG -->
		<div class="action-buttons">
			<a href="../warehousestaff/WarehouseStaffHome.jsp"
				class="btn btn-primary btn-cancel">Quay Về Trang Chủ</a>
			<form action="<%=request.getContextPath()%>/warehousestaff/import"
				method="post" style="display: inline;">
				<input type="hidden" name="action" value="saveImport">
				<%
				if (supplier != null) {
				%>
				<input type="hidden" name="supplierId" value="<%=supplier.getId()%>">
				<%
				}
				%>
				<button type="submit" class="btn btn-primary"
					<%=(supplier == null || importDetails.isEmpty()) ? "disabled" : ""%>>
					Xuất Hóa Đơn</button>
			</form>
		</div>
	</div>
</body>
</html>