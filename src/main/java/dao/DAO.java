package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
	
    public static Connection con = null;
    
    public DAO() {
    	String url = "jdbc:mysql://localhost:3306/SupermarketManagement?useSSL=false&serverTimezone=UTC";
    	String user = "root";
    	String password = "036463"; 
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
            System.out.println("KẾT NỐI DATABASE THÀNH CÔNG!");
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.err.println("KHÔNG KẾT NỐI ĐƯỢC DATABASE!");
        }
    }
    
//    public static void closeConnection(Connection con) {
//    	
//        if (con != null) {
//            try {
//                con.close();
//                
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//    }
    
}
