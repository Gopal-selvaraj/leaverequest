package com.employeedetails;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable
public class EmployeeBeanClass {

	
	@PrimaryKey
	private String employeeEmailId;
	private String key;
	private String employeeName;
	private String employeeId;
	private String address;
	private String team;
	private String role;
	private String password;
	private String mobileNo;	
	private String employeeDoj;
	
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getEmployeeEmailId() {
		return employeeEmailId;
	}

	public void setEmployeeEmailId(String employeeEmailId) {
		this.employeeEmailId = employeeEmailId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	

	public String getEmployeeDoj() {
		return employeeDoj;
	}

	public void setEmployeeDoj(String employeeDoj) {
		this.employeeDoj = employeeDoj;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}	

	private volatile static EmployeeBeanClass instance = null;

	public static EmployeeBeanClass getInstance() {

		if (instance == null) {

			instance = new EmployeeBeanClass();

		}

		return instance;

	}

	

}
