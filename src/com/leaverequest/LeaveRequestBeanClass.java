package com.leaverequest;

//import javax.jdo.annotations.IdGeneratorStrategy;
//import javax.jdo.annotations.Persistent;
//import javax.jdo.annotations.PrimaryKey;
//import com.google.appengine.api.datastore.Key;
import javax.jdo.annotations.PersistenceCapable;

@PersistenceCapable
public class LeaveRequestBeanClass {
	
//	@PrimaryKey
//    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
//	private Key key;
	private String nameOfApplicant;
	private String team;
	private String role;
	private String nameOfPoc;
	//private String request;
	private String status;
	private String leaveFrom;
	private String leaveTo;
	private String appliedDate;
	private String approvedDate;

//	public Key getKey() {
//		return key;
//	}
//
//	public void setKey(Key key) {
//		this.key = key;
//	}

	public String getNameOfApplicant() {
		return nameOfApplicant;
	}

	public void setNameOfApplicant(String nameOfApplicant) {
		this.nameOfApplicant = nameOfApplicant;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getNameOfPoc() {
		return nameOfPoc;
	}

	public void setNameOfPoc(String nameOfPoc) {
		this.nameOfPoc = nameOfPoc;
	}

//	public String getRequest() {
//		return request;
//	}
//
//	public void setRequest(String request) {
//		this.request = request;
//	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLeaveFrom() {
		return leaveFrom;
	}

	public void setLeaveFrom(String leaveFrom) {
		this.leaveFrom = leaveFrom;
	}

	public String getLeaveTo() {
		return leaveTo;
	}

	public void setLeaveTo(String leaveTo) {
		this.leaveTo = leaveTo;
	}

	public String getAppliedDate() {
		return appliedDate;
	}

	public void setAppliedDate(String appliedDate) {
		this.appliedDate = appliedDate;
	}

	public String getApprovedDate() {
		return approvedDate;
	}

	public void setApprovedDate(String approvedDate) {
		this.approvedDate = approvedDate;
	}

}
