package com.leaverequest;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable
public class LeaveType {

	@PrimaryKey	
	private String emailId;
	
	private int sickLeaves;
	private int casualLeaves;
	private int previlegeLeaves;
	private int otherLeaves;
	
	
	public int getSickLeaves() {
		return sickLeaves;
	}

	public void setSickLeaves(int sickLeaves) {
		this.sickLeaves = sickLeaves;
	}

	public int getCasualLeaves() {
		return casualLeaves;
	}

	public void setCasualLeaves(int casualLeaves) {
		this.casualLeaves = casualLeaves;
	}

	public int getPrevilegeLeaves() {
		return previlegeLeaves;
	}

	public void setPrevileageLeaves(int previleageLeaves) {
		this.previlegeLeaves = previleageLeaves;
	}

	public int getOtherLeaves() {
		return otherLeaves;
	}

	public void setOtherLeaves(int otherLeaves) {
		this.otherLeaves = otherLeaves;
	}

		
	private volatile static LeaveType instance = null;

	public static LeaveType getInstance() {

		if (instance == null) {
			instance = new LeaveType();
		}
		return instance;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	
}
