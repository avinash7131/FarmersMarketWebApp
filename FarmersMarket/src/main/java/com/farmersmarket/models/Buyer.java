// Buyer.java
package com.farmersmarket.models;

import java.sql.Timestamp;

public class Buyer {
	private int buyerId;
	private String username;
	private String password; // Should be hashed!
	private String contactInfo;
	private Timestamp registrationDate;

	// Constructors
	public Buyer() {
	}

	public Buyer(int buyerId, String username, String password, String contactInfo, Timestamp registrationDate) {
		this.buyerId = buyerId;
		this.username = username;
		this.password = password;
		this.contactInfo = contactInfo;
		this.registrationDate = registrationDate;
	}

	public int getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(int buyerId) {
		this.buyerId = buyerId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password; // Should be hashed!
	}

	public String getContactInfo() {
		return contactInfo;
	}

	public void setContactInfo(String contactInfo) {
		this.contactInfo = contactInfo;
	}

	public Timestamp getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Timestamp registrationDate) {
		this.registrationDate = registrationDate;
	}

	@Override
	public String toString() {
		return "Buyer [buyerId=" + buyerId + ", username=" + username + ", password=" + password + ", contactInfo="
				+ contactInfo + ", registrationDate=" + registrationDate + "]";
	}

}