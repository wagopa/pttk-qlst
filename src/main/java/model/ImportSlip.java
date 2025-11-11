package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ImportSlip {

	private int id;
    private Date date;
    private int supplierId;
    private int warehouseStaffId;
    private List<ImportDetails> importDetailsList;
    
    public ImportSlip() {}

    public ImportSlip(Date date, int supplierId, int warehouseStaffId) {
        this.date = date;
        this.supplierId = supplierId;
        this.warehouseStaffId = warehouseStaffId;
        this.importDetailsList = new ArrayList<>();
    }

    public ImportSlip(int id, Date date, int supplierId, int warehouseStaffId) {
        this.id = id;
        this.date = date;
        this.supplierId = supplierId;
        this.warehouseStaffId = warehouseStaffId;
        this.importDetailsList = new ArrayList<>();
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(int supplierId) {
		this.supplierId = supplierId;
	}

	public int getWarehouseStaffId() {
		return warehouseStaffId;
	}

	public void setWarehouseStaffId(int warehouseStaffId) {
		this.warehouseStaffId = warehouseStaffId;
	}

	public List<ImportDetails> getImportDetailsList() {
		return importDetailsList;
	}

	public void setImportDetailsList(List<ImportDetails> importDetailsList) {
		this.importDetailsList = importDetailsList != null ? importDetailsList : new ArrayList<>();
	}

	public void addImportDetail(ImportDetails detail) {
        if (detail != null) {
            detail.setImportSlipId(this.id);
            importDetailsList.add(detail);
        }
    }
    
	public void removeImportDetail(ImportDetails detail) {
        importDetailsList.remove(detail);
    }
	
	public int getTotalItems() {
        return importDetailsList.size();
    }

    public float getTotalAmount() {
        float total = 0;
        for (ImportDetails detail : importDetailsList) {
            total += detail.getQuantity() * detail.getPrice();
        }
        return total;
    }
    
    
}
