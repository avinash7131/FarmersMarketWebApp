// Order.java
package com.farmersmarket.models;

import java.sql.Timestamp;

public class Order {
	private int orderId;
	private int buyerId;
	private int farmerId;
	private Timestamp orderDate;
	private double totalAmount;
	private String orderStatus;
	private String shippingAddress;

	// Constructors
	public Order() {
	}

	public Order(int orderId, int buyerId, int farmerId, Timestamp orderDate, double totalAmount, String orderStatus,
			String shippingAddress) {
		this.orderId = orderId;
		this.buyerId = buyerId;
		this.farmerId = farmerId;
		this.orderDate = orderDate;
		this.totalAmount = totalAmount;
		this.orderStatus = orderStatus;
		this.shippingAddress = shippingAddress;
	}

	// Getters and Setters
	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(int buyerId) {
		this.buyerId = buyerId;
	}

	public int getFarmerId() {
		return farmerId;
	}

	public void setFarmerId(int farmerId) {
		this.farmerId = farmerId;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
}
