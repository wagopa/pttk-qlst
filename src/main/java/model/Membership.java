package model;

import java.sql.Date;
import java.time.LocalDate;

public class Membership {
	
	private int customerId;
    private String type;
    private Date startDate;
    private Date endDate;
    
    public Membership() {}

	public Membership(int customerId, String type, Date startDate) {
		super();
		this.customerId = customerId;
		this.type = type;
		this.startDate = startDate;
		this.endDate = Date.valueOf(startDate.toLocalDate().plusDays(30));
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
    
	public boolean isActive() {
        return endDate != null && 
               endDate.toLocalDate().isAfter(LocalDate.now()) || 
               endDate.toLocalDate().equals(LocalDate.now());
    }
}
