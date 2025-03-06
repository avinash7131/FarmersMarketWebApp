// Farmer.java
package com.farmersmarket.models;

import java.sql.Timestamp;

public class Farmer {
	private int farmerId;
	private String username;
	private String password; // Should be hashed!
	private String farmName;
	private String location;
	private String contactInfo;
	private Timestamp registrationDate;

	// Constructors
	public Farmer() {
	}

	public Farmer(int farmerId, String username, String password, String farmName, String location, String contactInfo,
			Timestamp registrationDate) {
		this.farmerId = farmerId;
		this.username = username;
		this.password = password;
		this.farmName = farmName;
		this.location = location;
		this.contactInfo = contactInfo;
		this.registrationDate = registrationDate;
	}

	// Getters and Setters
	public int getFarmerId() {
		return farmerId;
	}

	public void setFarmerId(int farmerId) {
		this.farmerId = farmerId;
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

	public String getFarmName() {
		return farmName;
	}

	public void setFarmName(String farmName) {
		this.farmName = farmName;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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
}