package model;

public class ImportDetails {
	
	private int id;
    private int quantity;
    private float price;
    private int importSlipId;
    private Product product;
    
    public ImportDetails() {}

    public ImportDetails(int quantity, float price, Product product) {
        this.quantity = quantity;
        this.price = price;
        this.product = product;
    }

    public ImportDetails(int id, int quantity, float price, Product product) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.product = product;
    }

    public ImportDetails(int quantity, float price, int importSlipId, Product product) {
        this.quantity = quantity;
        this.price = price;
        this.importSlipId = importSlipId;
        this.product = product;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getImportSlipId() {
		return importSlipId;
	}

	public void setImportSlipId(int importSlipId) {
		this.importSlipId = importSlipId;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public int getProductId() {
        return product != null ? product.getId() : 0;
    }
}
