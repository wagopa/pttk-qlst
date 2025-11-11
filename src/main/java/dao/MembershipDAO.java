package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Membership;

public class MembershipDAO extends DAO {
	
	public MembershipDAO() {
        super();
    }

    public boolean registerMembership(Membership membership) {
        String sql = "INSERT INTO Membership (customerId, type, startDate, endDate) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, membership.getCustomerId());
            ps.setString(2, membership.getType());
            ps.setDate(3, membership.getStartDate());
            ps.setDate(4, membership.getEndDate());
            
            int rows = ps.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Membership getActiveMembershipByCustomerId(int customerId) {
        String sql = "SELECT * FROM Membership WHERE customerId = ? AND endDate >= CURDATE() ORDER BY startDate DESC LIMIT 1";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Membership m = new Membership();
                m.setCustomerId(rs.getInt("customerId"));
                m.setType(rs.getString("type"));
                m.setStartDate(rs.getDate("startDate"));
                m.setEndDate(rs.getDate("endDate"));
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
