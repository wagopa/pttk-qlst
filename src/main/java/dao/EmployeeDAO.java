package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeeDAO extends DAO {
	
	public EmployeeDAO() {
		super();
	}
	
	public String getPositionById(int id) {
		String sql = "SELECT position FROM Employee WHERE userId = ?";
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				return rs.getString("position");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			if (rs != null) {
                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
		}
		
		return null;
	}
}
