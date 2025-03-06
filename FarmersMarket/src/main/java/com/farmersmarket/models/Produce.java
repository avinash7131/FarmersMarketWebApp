// Produce.java
package com.farmersmarket.models;

public class Produce {
	private int produceId;
	private int farmerId;
	private String produceName;
	private String description;
	private double quantity;
	private String unit;
	private double price;
	private String imagePath;

	// Constructors
	public Produce() {
	}

	public Produce(int produceId, int farmerId, String produceName, String description, double quantity, String unit,
			double price, String imagePath) {
		this.produceId = produceId;
		this.farmerId = farmerId;
		this.produceName = produceName;
		this.description = description;
		this.quantity = quantity;
		this.unit = unit;
		this.price = price;
		this.imagePath = imagePath;
	}

	// Getters and Setters
	public int getProduceId() {
		return produceId;
	}

	public void setProduceId(int produceId) {
		this.produceId = produceId;
	}

	public int getFarmerId() {
		return farmerId;
	}

	public void setFarmerId(int farmerId) {
		this.farmerId = farmerId;
	}

	public String getProduceName() {
		return produceName;
	}

	public void setProduceName(String produceName) {
		this.produceName = produceName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
}