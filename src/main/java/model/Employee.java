package model;

import java.sql.Date;

public class Employee extends User {
	
	private String position;

	public Employee() {
		super();
		setRole("Employee");
	}

	public Employee(int userId, String position) {
        super();
        setId(userId);
        this.position = position;
        setRole("Employee");
    }

    public Employee(int id, String username, String password, String fullName, 
                   Date dob, String address, String email, String phone, 
                   String position) {
        super(id, username, password, fullName, dob, address, email, phone, "Employee");
        this.position = position;
    }

    public String getPosition() {
    	return position; 
    }
    
    public void setPosition(String position) {
    	this.position = position; 
    }
	
}
