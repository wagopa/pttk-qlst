package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import model.ImportDetails;
import model.ImportSlip;

public class ImportSlipDAO extends DAO {
	
	public ImportSlipDAO() {
		super();
	}
	
	public boolean addImportSlip(ImportSlip slip) {
        PreparedStatement psSlip = null;
        PreparedStatement psDetail = null;
        ResultSet generatedKeys = null;

        try {
            con.setAutoCommit(false);
            // 1. Thêm ImportSlip
            String sqlSlip = "INSERT INTO ImportSlip (`date`, supplierId, warehouseStaffId) VALUES (?, ?, ?)";
            psSlip = con.prepareStatement(sqlSlip, Statement.RETURN_GENERATED_KEYS);
            psSlip.setDate(1, slip.getDate());
            psSlip.setInt(2, slip.getSupplierId());
            psSlip.setInt(3, slip.getWarehouseStaffId());
            int affectedRows = psSlip.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating ImportSlip failed, no rows affected.");
            }

            // Lấy ID
            generatedKeys = psSlip.getGeneratedKeys();
            if (generatedKeys.next()) {
                int importSlipId = generatedKeys.getInt(1);
                slip.setId(importSlipId); // CẬP NHẬT ID VÀO OBJECT
            } else {
                throw new SQLException("No ID obtained.");
            }

            // 2. Thêm ImportDetails
            String sqlDetail = "INSERT INTO ImportDetails (quantity, price, importSlipId, productId) VALUES (?, ?, ?, ?)";
            psDetail = con.prepareStatement(sqlDetail);

            for (ImportDetails d : slip.getImportDetailsList()) {
                psDetail.setInt(1, d.getQuantity());
                psDetail.setFloat(2, d.getPrice());
                psDetail.setInt(3, slip.getId()); // DÙNG ID VỪA TẠO
                psDetail.setInt(4, d.getProductId());
                psDetail.addBatch();
            }
            psDetail.executeBatch();

            con.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            // Đóng tài nguyên...
        	try {
                if (generatedKeys != null) generatedKeys.close();
                if (psDetail != null) psDetail.close();
                if (psSlip != null) psSlip.close();
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
