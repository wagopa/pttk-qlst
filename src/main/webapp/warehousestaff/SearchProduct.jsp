<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ImportDetails"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tìm Mặt Hàng</title>
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

	List<Product> products = (List<Product>) request.getAttribute("products");
	List<ImportDetails> selectedDetails = (List<ImportDetails>) session.getAttribute("tempImportDetails");
	if (selectedDetails == null)
		selectedDetails = new ArrayList<>();
	%>

	<div class="import-container">
		<header class="import-header">
			<h2>Tìm Kiếm Mặt Hàng</h2>
			<p>Hệ thống siêu thị điện máy - Nhập hàng từ nhà cung cấp</p>
		</header>

		<!-- Ô TÌM KIẾM + NÚT -->
		<form action="<%=request.getContextPath()%>/warehousestaff/product"
			method="get" class="search-form">
			<input type="hidden" name="action" value="searchProduct">
			<div class="search-bar">
				<input type="text" name="productName"
					placeholder="Nhập tên mặt hàng..."
					value='<%=request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : ""%>'
					required class="search-input">
				<button type="submit" class="btn-styled btn-search">Tìm
					Kiếm</button>
				<a
					href="<%=request.getContextPath()%>/warehousestaff/AddProduct.jsp"
					class="btn-styled btn-product btn-add-new">+ Thêm Mới</a>
			</div>
		</form>

		<!-- BẢNG KẾT QUẢ TÌM KIẾM -->
		<%
		if (products != null && !products.isEmpty()) {
		%>
		<div class="table-container">
			<table class="result-table styled-table">
				<thead>
					<tr>
						<th class="col-id">ID</th>
						<th class="col-name">Tên mặt hàng</th>
						<th class="col-qty">Số lượng</th>
						<th class="col-price">Đơn giá (VNĐ)</th>
						<th style="width: 10%"></th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Product p : products) {
					%>
					<tr>
						<td class="col-id"><%=p.getId()%></td>
						<td class="col-name"><%=p.getName()%></td>
						<td class="col-qty"><%=p.getQuantity()%></td>
						<td class="col-price"><%=String.format("%,.0f", p.getPrice())%></td>
						<td>
							<form
								action="<%=request.getContextPath()%>/warehousestaff/product"
								method="post">
								<input type="hidden" name="action" value="selectProduct">
								<input type="hidden" name="productId" value="<%=p.getId()%>">
								<input type="hidden" name="productName"
									value='<%=request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : ""%>'>
								<button type="submit" class="btn-select-small">Chọn</button>
							</form>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<%
		} else if (products != null) {
		%>
		<p class="text-center"
			style="margin: 2rem 0; color: #e74c3c; font-weight: 500;">Không
			tìm thấy mặt hàng nào.</p>
		<%
		}
		%>

		<!-- BẢNG MẶT HÀNG ĐÃ CHỌN -->
		<%
		if (!selectedDetails.isEmpty()) {
		%>
		<div class="table-container" style="margin-top: 2rem;">
			<h3 style="margin-bottom: 1rem; color: #2c3e50;">Mặt hàng đã
				chọn</h3>
				<form action="<%=request.getContextPath()%>/warehousestaff/product"
					method="post">
					<input type="hidden" name="action" value="updateDetails"> <input
						type="hidden" name="productName"
						value='<%=request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : ""%>'>
					<table class="import-table styled-table">
						<thead>
							<tr>
								<th class="col-stt">STT</th>
								<th class="col-name">Tên mặt hàng</th>
								<th class="col-id">ID</th>
								<th class="col-qty">Số lượng</th>
								<th class="col-price">Đơn giá (VNĐ)</th>
								<th class="col-total">Thành tiền (VNĐ)</th>
								<th style="width: 10%">Xóa</th>
							</tr>
						</thead>
						<tbody>
							<%
							double subTotal = 0;
							for (int i = 0; i < selectedDetails.size(); i++) {
								ImportDetails d = selectedDetails.get(i);
								double lineTotal = d.getQuantity() * d.getPrice();
								subTotal += lineTotal;
							%>
							<tr>
								<td class="col-stt"><%=i + 1%></td>
								<td class="col-name"><%=d.getProduct().getName()%></td>
								<td class="col-id"><%=d.getProductId()%></td>
								<td class="col-qty"><input type="number" name="qty_<%=i%>"
									value="<%=d.getQuantity()%>" min="1" class="qty-input" required
									style="width: 70px;"></td>
								<td class="col-price"><input type="number"
									name="price_<%=i%>" value="<%=(int) d.getPrice()%>" min="0"
									step="1000" class="price-input" required style="width: 100px;"></td>
								<td class="col-total"><%=String.format("%,.0f", lineTotal)%></td>
								<td>
									<button type="submit" name="removeIndex" value="<%=i%>"
										class="btn-remove">Xóa</button>
								</td>
							</tr>
							<%
							}
							%>
							<tr class="total-row">
								<td colspan="5"><strong>TỔNG TIỀN:</strong></td>
								<td><strong><%=String.format("%,.0f", subTotal)%>
										VNĐ</strong></td>
								<td></td>
							</tr>
						</tbody>
					</table>

					<div class="action-buttons" style="float:left; margin: 20px 0 20px 250px">
						<button type="submit" class="btn btn-primary">Cập Nhật</button>
					</div>
				</form>

				<form action="<%=request.getContextPath()%>/warehousestaff/product"
					method="post" style="display: inline;">
					<input type="hidden" name="action" value="confirmProducts">
					<input type="hidden" name="productName"
						value='<%=request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : ""%>'>
					<div class="action-buttons" style="float:right; margin: 20px 250px 20px 0"">
						<button type="submit" class="btn btn-primary btn-product btn-success">Xác Nhận</button>
					</div>
				</form>
		</div>
		<%
		}
		%>

		<!-- NÚT QUAY LẠI -->
		<div class="action-buttons"
			style="margin-top: 2rem; justify-content: center;">
			<a
				href="<%=request.getContextPath()%>/warehousestaff/ImportProduct.jsp"
				class="btn btn-cancel">QUAY LẠI</a>
		</div>
	</div>
</body>
</html>