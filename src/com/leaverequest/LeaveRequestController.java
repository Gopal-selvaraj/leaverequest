package com.leaverequest;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.employeedetails.EmployeeBeanClass;
import com.instanceclass.PMF;

@Controller
public class LeaveRequestController {

	private Logger log = Logger
			.getLogger(LeaveRequestBeanClass.class.getName());

	@RequestMapping(value = "/leave")
	public String leaveRequest() {
		return "LeaveRequestForm";
	}

	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "/leaveHistory", method = RequestMethod.GET)
	@ResponseBody
	public String leaveHistory(HttpServletRequest req, HttpServletResponse res) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// String emailId="";
		String team = req.getParameter("Team");
		String emailId = req.getParameter("EmailId");
		LeaveRequestBeanClass leaves = LeaveRequestBeanClass.getInstance();
		Query history = pm.newQuery(LeaveRequestBeanClass.class);
		history.setFilter(" team == '" + team + "' ");
		List<LeaveRequestBeanClass> leavesTaken = (List<LeaveRequestBeanClass>) history
				.execute();

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();		
		
			for (LeaveRequestBeanClass leave : leavesTaken) {
				if (leave.getEmployeeEmailId().equals(emailId)) {
				jsonObject.put("AppliedDate", leave.getAppliedDate());
				jsonObject.put("ApprovedDate", leave.getApprovedDate());
				jsonObject.put("LeaveFrom", leave.getLeaveFrom());
				jsonObject.put("LeaveTo", leave.getLeaveTo());
				jsonObject.put("EmployeeName", leave.getNameOfApplicant());
				jsonObject.put("ApprovedBy", leave.getNameOfPoc());
				jsonObject.put("Status", leave.getStatus());
				/*
				 * jsonObject.put("CasualLeaves", leave.getCasualLeaves());
				 * jsonObject.put("OtherLeaves", leave.getOtherLeaves());
				 * jsonObject.put("PrivilegeLeaves",
				 * leave.getPrivilegeLeaves()); jsonObject.put("SickLeaves",
				 * leave.getSickLeaves());
				 */

				jsonArray.add(jsonObject);
			}
				else {
					

					jsonObject.put("AppliedDate", leave.getAppliedDate());
					jsonObject.put("ApprovedDate", leave.getApprovedDate());
					jsonObject.put("LeaveFrom", leave.getLeaveFrom());
					jsonObject.put("LeaveTo", leave.getLeaveTo());
					jsonObject.put("EmployeeName", leave.getNameOfApplicant());
					jsonObject.put("ApprovedBy", leave.getNameOfPoc());
					jsonObject.put("Status", leave.getStatus());
					/*
					 * jsonObject.put("CasualLeaves", leave.getCasualLeaves());
					 * jsonObject.put("OtherLeaves", leave.getOtherLeaves());
					 * jsonObject.put("PrivilegeLeaves",
					 * leave.getPrivilegeLeaves()); jsonObject.put("SickLeaves",
					 * leave.getSickLeaves());
					 */

					jsonArray.add(jsonObject);
				
			}
		} 
		res.setContentType("application/json");
		return jsonArray.toJSONString();

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/leaveStatus", method = RequestMethod.GET)
	@ResponseBody
	public String viewStatus(HttpServletRequest req, HttpServletResponse res) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// HttpSession session = req.getSession();
		// String team = (String) session.getAttribute("Team");
		String status = req.getParameter("Status");
		// Query pending = pm.newQuery(LeaveRequestBeanClass.class, "(team == '"
		// + team + "' )" + "&& status == '" + status + "' ");
		Query statusInfo = pm.newQuery(LeaveRequestBeanClass.class);
		statusInfo.setFilter(" status == '" + status + "' ");

		List<LeaveRequestBeanClass> leaveStatus = (List<LeaveRequestBeanClass>) statusInfo
				.execute();

		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();

		for (LeaveRequestBeanClass leave : leaveStatus) {

			jsonObject.put("AppliedDate", leave.getAppliedDate());
			jsonObject.put("ApprovedDate", leave.getApprovedDate());
			jsonObject.put("LeaveFrom", leave.getLeaveFrom());
			jsonObject.put("LeaveTo", leave.getLeaveTo());
			jsonObject.put("EmployeeName", leave.getNameOfApplicant());
			jsonObject.put("ApprovedBy", leave.getNameOfPoc());
			jsonObject.put("Status", leave.getStatus());
			/*
			 * jsonObject.put("CasualLeaves", leave.getCasualLeaves());
			 * jsonObject.put("OtherLeaves", leave.getOtherLeaves());
			 * jsonObject.put("PrivilegeLeaves", leave.getPrivilegeLeaves());
			 * jsonObject.put("SickLeaves", leave.getSickLeaves());
			 */

			jsonArray.add(jsonObject);
		}

		res.setContentType("application/json");
		return jsonArray.toJSONString();

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateLeaveStatus", method = RequestMethod.POST)
	public ModelAndView updateStatus(HttpServletRequest req, ModelAndView model) {
		// LeaveRequestBeanClass lr = new LeaveRequestBeanClass();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// LeaveRequestBeanClass leaveRequest = LeaveRequestBeanClass
		// .getInstance();

		try {

			// Get the values from the Jsp Form and set values into Datastore by
			// using the employee Object.

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();

			String nameOfApplicant = req.getParameter("employeeName");
			String emailIdFrom = req.getParameter("emailIdFrom");
			String approvedBy = req.getParameter("approvedBy");
			String emailIdTo = req.getParameter("emailIdTo");
			String approvedDate = formatter.format(date);
			String status = req.getParameter("status");
			// String appliedDate = req.getParameter("requestDate");
			String key = req.getParameter("key");
			String message = "Your Leave Request was approved by " + approvedBy
					+ "\n On " + approvedDate;

			/*
			 * Query query = pm.newQuery(LeaveRequestBeanClass.class,"team =='"
			 * + team + "' " + "&& status == 'Pending' " +
			 * "&& approvedDate == 'null' " +
			 * "&& appliedDate == '"+appliedDate+"' ");
			 */

			Query query = pm.newQuery(LeaveRequestBeanClass.class);
			query.setFilter("key == '" + key + "' ");
			List<LeaveRequestBeanClass> leaves = (List<LeaveRequestBeanClass>) query
					.execute();

			for (LeaveRequestBeanClass leave : leaves) {
				leave.setApprovedDate(approvedDate);
				leave.setNameOfPoc(approvedBy);
				leave.setStatus(status);
				pm.makePersistent(leave);
			}

			// Sending the mail to the employee who is requested for the leave
			// ......
			sendMail(nameOfApplicant, emailIdFrom, approvedBy, emailIdTo,
					message);
			// Here we add the model to the name of Leave that is used by
			// frontend pages ...

			model.addObject("Leave", leaves);
			model.setViewName("LoginTemplate");

		} catch (Exception e) {
			// In case of Not stored in datastore and email not send means the
			// error stored in the log
			log.info("Email address not found or Email address Mismatch");
		} finally {
			// Close the PersistenceManager
			pm.close();

		}

		return model;

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/leaveRequest", method = RequestMethod.POST)
	public ModelAndView leaveRequest(HttpServletRequest req) {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// HttpSession session = req.getSession();
		// Create the Object for LeaveRequestBeanClass
		LeaveRequestBeanClass leaveRequest = LeaveRequestBeanClass
				.getInstance();
		// EmployeeBeanClass employee = new EmployeeBeanClass();

		try {

			// Get the values from the Jsp Form and set values into Datastore by
			// using the employee Object.
			String nameOfApplicant = req.getParameter("EmployeeName");
			String appliedDate = req.getParameter("RequestDate");
			String leaveFrom = req.getParameter("LeaveFrom");
			String leaveTo = req.getParameter("LeaveTo");
			String team = req.getParameter("Team");
			String role = req.getParameter("Role");
			String emailIdFrom = req.getParameter("EmailIdFrom");
			String emailIdTo = req.getParameter("EmailIdTo");
			String sickLeave = req.getParameter("SickLeave");
			String casualLeave = req.getParameter("CasualLeave");
			String privilegeLeave = req.getParameter("PrivilegeLeave");
			String otherLeave = req.getParameter("OtherLeave");

			String approvedDate = "Not Assigned";
			String nameOfPoc = "Not Approved";
			String status = "Pending";

			// System.out.println("i am in");
			/*
			 * long leaveF=Long.parseLong(leaveFrom); long
			 * leaveT=Long.parseLong(leaveTo);
			 */

			/*
			 * System.out.println(leaveF); System.out.println(leaveT);
			 */

			String message = "Leave Request From " + nameOfApplicant + "\n"
					+ "Date From " + leaveFrom + " To " + leaveTo;

			Query query = pm.newQuery(EmployeeBeanClass.class);
			query.setFilter("employeeEmailId =='" + emailIdTo + "' ");

			List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query
					.execute();

			EmployeeBeanClass employee = employees.get(0);
			nameOfPoc = employee.getEmployeeName();

			leaveRequest.setEmployeeEmailId(emailIdFrom);
			leaveRequest.setNameOfApplicant(nameOfApplicant);
			leaveRequest.setNameOfPoc(nameOfPoc);
			leaveRequest.setTeam(team);
			leaveRequest.setRole(role);
			leaveRequest.setAppliedDate(appliedDate);
			leaveRequest.setApprovedDate(approvedDate);
			leaveRequest.setLeaveFrom(leaveFrom);
			leaveRequest.setLeaveTo(leaveTo);
			leaveRequest.setStatus(status);
			leaveRequest.setCasualLeaves(casualLeave);
			leaveRequest.setSickLeaves(sickLeave);
			leaveRequest.setPrivilegeLeaves(privilegeLeave);
			leaveRequest.setOtherLeaves(otherLeave);
			UUID key = UUID.randomUUID();
			leaveRequest.setKey(key.toString());

			String response = " ";
			String responseMessage = "";

			if (emailIdTo != null && emailIdTo != "") {

				// log.info(" message True" + response);
				response = sendMail(nameOfApplicant, emailIdFrom, nameOfPoc,
						emailIdTo, message);
				responseMessage = "Your Leave Request was Sent Successfully To "
						+ nameOfPoc
						+ "\nAnd Your Status is "
						+ status
						+ "\nAdmin will contact you shortly....";
				response = sendMail(nameOfPoc, emailIdTo, nameOfApplicant,
						emailIdFrom, responseMessage);

				// log.info("Mail Send Successfully :" + response);
				// log.info(" welcome " + emailIdTo + " message " + response);
			} else {
				// log.info(" message false :" + response);
				// response = "Failed";
				log.info("Mail Not Send....,Receipent MailId not Found or Null.....,"
						+ response);
			}

			// model.addObject("Mail", "Your Mail was sent successfully");

			pm.makePersistent(leaveRequest);
			// model.setViewName("LoginTemplate");

		} catch (Exception e) {
			log.warn("To address Mismatch");
		} finally {
			// Close the PersistenceManager
			pm.close();

		}

		// Return the results to the Userprofile page by using the model and
		// view
		return new ModelAndView("LoginTemplate");
	}

	// SendMail method is used to five parameters to when ever the employees try
	// to send an email for the request they will use this method
	// dynamically....
	private String sendMail(String nameOfApplicant, String emailIdFrom,
			String nameOfPoc, String emailIdTo, String message)
			throws UnsupportedEncodingException {
		log.info(" message test");
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		try {

			// HtmlEmail email = new HtmlEmail();
			Message msg = new MimeMessage(session);

			msg.setFrom(new InternetAddress(emailIdFrom, nameOfApplicant));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					emailIdTo, nameOfPoc));
			// msg.addRecipients(Message.RecipientType.CC,InternetAddress.parse("abc@abc.com,abc@def.com,ghi@abc.com"));
			msg.setSubject("Leave Request");

			msg.setText(message);
			Transport.send(msg);
			// msg.setReplyTo(InternetAddress.parse(emailIdFrom));
			// msg.getReplyTo();
			// replyMessage.setReplyTo(message.getReplyTo());
			// Transport.send(msg, InternetAddress.parse(emailIdFrom));
			log.info("Ok tested Good ");
			// MimeMessage message = new MimeMessage(session,
			// req.getInputStream());
		} catch (AddressException e1) {
			log.info("Address Mismatch ");
			log.info("AddressNotFound :" + e1);
		} catch (MessagingException e) {
			log.info("Message Mismatch ");
			log.info("Messaging :" + e);
		}
		return "Success";

	}

}
