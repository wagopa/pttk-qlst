package model;

import java.sql.Date;

public class WarehouseStaff extends Employee {

	public WarehouseStaff() {
		super();
		setPosition("WarehouseStaff");
	}
	
	public WarehouseStaff(int userId) {
        super(userId, "WarehouseStaff");
    }

    public WarehouseStaff(int id, String username, String password, String fullName, 
                         Date dob, String address, String email, String phone) {
        super(id, username, password, fullName, dob, address, email, phone, "WarehouseStaff");
    }
}
