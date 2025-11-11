package model;

import java.sql.Date;

public class Customer extends User {

	public Customer() {
		super();
		setRole("Customer");
	}

	public Customer(int userId) {
        super();
        setId(userId);
        setRole("Customer");
    }

    public Customer(int id, String username, String password, String fullName, 
                   Date dob, String address, String email, String phone) {
        super(id, username, password, fullName, dob, address, email, phone, "Customer");
    }
}
