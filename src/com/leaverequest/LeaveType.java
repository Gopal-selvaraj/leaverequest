package com.leaverequest;

public class LeaveType {

	private String key;
	private int sickLeave;
	private int casualLeave;
	private int previleageLeave;
	
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public int getSickLeave() {
		return sickLeave;
	}
	public void setSickLeave(int sickLeave) {
		this.sickLeave = sickLeave;
	}
	public int getCasualLeave() {
		return casualLeave;
	}
	public void setCasualLeave(int casualLeave) {
		this.casualLeave = casualLeave;
	}
	public int getPrevileageLeave() {
		return previleageLeave;
	}
	public void setPrevileageLeave(int previleageLeave) {
		this.previleageLeave = previleageLeave;
	}
	private volatile static LeaveType instance = null;

	public static LeaveType getInstance() {

		if (instance == null) {
			instance = new LeaveType();
		}
		return instance;
	}
}
