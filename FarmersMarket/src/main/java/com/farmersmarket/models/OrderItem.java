// OrderItem.java
package com.farmersmarket.models;

public class OrderItem {
	private int orderItemId;
	private int orderId;
	private int produceId;
	private double quantity;
	private double unitPrice;

	// Constructors
	public OrderItem() {
	}

	public OrderItem(int orderItemId, int orderId, int produceId, double quantity, double unitPrice) {
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.produceId = produceId;
		this.quantity = quantity;
		this.unitPrice = unitPrice;
	}

	// Getters and Setters
	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getProduceId() {
		return produceId;
	}

	public void setProduceId(int produceId) {
		this.produceId = produceId;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
}