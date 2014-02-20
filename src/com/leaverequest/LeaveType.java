package com.leaverequest;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable
public class LeaveType {

	@PrimaryKey
	private String key;
	private int sickLeaves;
	private int casualLeaves;
	private int previleageLeaves;
	private int otherLeaves;
	
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

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

	public int getPrevileageLeaves() {
		return previleageLeaves;
	}

	public void setPrevileageLeaves(int previleageLeaves) {
		this.previleageLeaves = previleageLeaves;
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
	
}
