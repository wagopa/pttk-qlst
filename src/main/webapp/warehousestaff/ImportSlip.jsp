<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Employee"%>
<%@page import="model.Supplier"%>
<%@page import="model.ImportDetails"%>
<%@page import="java.util.List"%>
<%@page import="model.ImportSlip"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hóa Đơn Nhập Hàng</title>
<link rel="stylesheet" href="../styles/style.css">
<link rel="stylesheet" href="../styles/import-product.css">
</head>
<body>
	<%
	ImportSlip slip = (ImportSlip) session.getAttribute("currentImportSlip");
	List<ImportDetails> details = (List<ImportDetails>) session.getAttribute("currentImportDetails");
	Supplier supplier = (Supplier) session.getAttribute("currentSupplier");
	Employee emp = (Employee) session.getAttribute("user");

	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	double total = 0;
	for (ImportDetails d : details) {
		total += d.getQuantity() * d.getPrice();
	}
	%>

	<div class="alert alert-success"
		style="text-align: center; padding: 1rem; background: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 8px; margin-bottom: 1.5rem;">
		<strong>THÀNH CÔNG!</strong> Phiếu nhập hàng đã được lưu vào hệ thống.<br>
		Mã phiếu: <strong>#<%=slip.getId()%></strong> | Ngày: <strong><%=new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(slip.getDate())%></strong>
	</div>

	<div class="import-container">
		<header class="import-header">
			<h2>HÓA ĐƠN NHẬP HÀNG</h2>
			<p>
				Mã phiếu: <strong>#<%=slip.getId()%></strong> -
				<%=sdf.format(slip.getDate())%></p>
		</header>

		<div class="info-section">
			<p>
				<strong>Nhân viên nhập:</strong>
				<%=emp.getFullName()%></p>
			<p>
				<strong>Nhà cung cấp:</strong>
				<%=supplier.getName()%>
				-
				<%=supplier.getPhone()%></p>
		</div>

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
					for (int i = 0; i < details.size(); i++) {
						ImportDetails d = details.get(i);
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
					%>
					<tr class="total-row">
						<td colspan="5"><strong>TỔNG TIỀN:</strong></td>
						<td><strong><%=String.format("%,.0f", total)%> VNĐ</strong></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="action-buttons"
			style="justify-content: center; gap: 2rem;">
			<a
				href="<%=request.getContextPath()%>/warehousestaff/WarehouseStaffHome.jsp"
				class="btn btn-primary">HOÀN TẤT</a>
			<button class="btn btn-primary btn-product" onclick="window.print()" class="btn btn-success">IN
				HÓA ĐƠN</button>
		</div>
	</div>

	<!-- Xóa dữ liệu sau khi in -->
	<%
	session.removeAttribute("currentImportSlip");
	session.removeAttribute("currentImportDetails");
	session.removeAttribute("currentSupplier");
	%>
</body>
</html>