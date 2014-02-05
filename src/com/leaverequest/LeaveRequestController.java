package com.leaverequest;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

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
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.employeedetails.EmployeeBeanClass;
import com.instanceclass.PMF;

@Controller
public class LeaveRequestController {
	private Logger log = Logger
			.getLogger(LeaveRequestBeanClass.class.getName());

	@RequestMapping(value = "Leave.com")
	public String leaveRequest() {
		return "LeaveRequestForm";

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "ViewStatus.com")
	public ModelAndView viewStatus(HttpServletRequest req, ModelAndView model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		HttpSession session = req.getSession();
		String team = (String) session.getAttribute("Team");
		Query query1 = pm.newQuery(LeaveRequestBeanClass.class);
		query1.setFilter("team =='" + team + "' ");

		List<LeaveRequestBeanClass> leaves = (List<LeaveRequestBeanClass>) query1
				.execute();
		model.addObject("Leave", leaves);
		model.setViewName("ViewStatus");
		return model;

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/UpdateStatus.com")
	public ModelAndView updateStatus(HttpServletRequest req, ModelAndView model) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// LeaveRequestBeanClass leaveUpdate = new LeaveRequestBeanClass();
		try {

			// Get the values from the Jsp Form and set values into Datastore by
			// using the employee Object.
			String approvedDate = (String) req.getParameter("approvedDate");
			String status = (String) req.getParameter("status");
			String emailIdFrom = (String) req.getParameter("emailId");
			String team = req.getParameter("team");
			String nameOfApplicant = req.getParameter("employeeName");

			Query query = pm.newQuery(LeaveRequestBeanClass.class);
			query.setFilter("team =='" + team + "' ");
			List<LeaveRequestBeanClass> leaves = (List<LeaveRequestBeanClass>) query
					.execute();

			for (LeaveRequestBeanClass leave : leaves) {
				if ((leave.getNameOfApplicant())
						.equalsIgnoreCase(nameOfApplicant)
						&& (leave.getTeam()).equals(team)) {

					// session.setAttribute("TeamLeader",
					// employee.getEmailId());
					// String emailIdTo = ((EmployeeBeanClass)
					// leaves).getEmailId();
					leave.setApprovedDate(approvedDate);
					leave.setStatus(status);

				}
			}

			model.addObject("Leave", leaves);
			model.setViewName("ViewStatus");
			// pm.makePersistent(leaveUpdate);

		} catch (Exception e) {
			log.warn("Wrong To address");
		} finally {
			// Close the PersistenceManager
			pm.close();

		}

		return model;

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/LeaveRequest.com")
	public ModelAndView Register(HttpServletRequest req, ModelAndView model)
			throws ParseException, UnsupportedEncodingException {

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
			String nameOfPoc = req.getParameter("SendTo");
			String appliedDate = req.getParameter("RequestDate");
			String leaveFrom = req.getParameter("LeaveFrom");
			String leaveTo = req.getParameter("LeaveTo");
			String team = req.getParameter("Team");
			String emailIdFrom = req.getParameter("EmailId");
			String role = req.getParameter("Role");
			String approvedDate = "null";
			String status = "Pending";
			String emailIdTo = null;
			// String message = req.getParameter("Message");
			String message = "Message Sent Successfully";
			Query query = pm.newQuery(EmployeeBeanClass.class);
			query.setFilter("team =='" + team + "' ");

			List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query
					.execute();

			for (EmployeeBeanClass employee : employees) {
				if ((employee.getEmployeeName()).equalsIgnoreCase(nameOfPoc)
						&& employee.getRole().equalsIgnoreCase("TeamLeader")
						&& (employee.getTeam().equals(team))) {

					// session.setAttribute("TeamLeader",
					// employee.getEmailId());
					emailIdTo = employee.getEmailId();

				}
			}
			// String one=nameOfApplicant+"<"+emailIdFrom+">";
			// String two=nameOfPoc+"<"+emailIdTo+">";
			// Key key = KeyFactory.createKey(
			// LeaveRequestBeanClass.class.getSimpleName(), emailIdFrom);

			leaveRequest.setNameOfApplicant(nameOfApplicant);
			leaveRequest.setNameOfPoc(nameOfPoc);
			leaveRequest.setTeam(team);
			leaveRequest.setRole(role);
			leaveRequest.setAppliedDate(appliedDate);
			leaveRequest.setApprovedDate(approvedDate);
			leaveRequest.setLeaveFrom(leaveFrom);
			leaveRequest.setLeaveTo(leaveTo);
			leaveRequest.setStatus(status);
			// leaveRequest.setKey(key);

			// System.out.println(emailIdTo + " message ");
			String response = "";
			if (emailIdTo != null && emailIdTo != "") {
				log.info(" message True" + response);
				response = sendMail(nameOfApplicant, emailIdFrom, nameOfPoc,
						emailIdTo, message);
				log.info("Mail Send Successfully :" + response);
				log.info(" welcome " + emailIdTo + " message " + response);
			} else {
				log.info(" message false :" + response);
				response = "Failed";
				log.info("Mail Not Send....,Receipent MailId not Found or Null.....,"
						+ response);
			}

			Query query1 = pm.newQuery(EmployeeBeanClass.class);
			query1.setFilter("team =='" + team + "' ");

			List<LeaveRequestBeanClass> leaves = (List<LeaveRequestBeanClass>) query
					.execute();
			model.addObject("Leave", leaves);
			model.setViewName("UserProfile");

			pm.makePersistent(leaveRequest);

		} catch (Exception e) {
			log.warn("To address Mismatch");
		} finally {
			// Close the PersistenceManager
			pm.close();

		}

		// Return the results to the Userprofile page by using the model and
		// view
		return model;
	}

	@RequestMapping(value = "/LeaveResponse.com")
	public ModelAndView Resonse(HttpServletRequest req, ModelAndView model)
			throws ParseException, UnsupportedEncodingException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// HttpSession session = req.getSession();
		// Create the Object for LeaveRequestBeanClass
		LeaveRequestBeanClass leaveRequest = LeaveRequestBeanClass
				.getInstance();
		// EmployeeBeanClass employee = new EmployeeBeanClass();
		
		try{
		String response = "";
		String nameOfApplicant = req.getParameter("EmployeeName");
		String nameOfPoc = req.getParameter("ApprovedBy");
		String emailIdFrom = req.getParameter("EmailId");
		Date today = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String approvedDate = formatter.format(today);
		String status = req.getParameter("status");		
		String emailIdTo = req.getParameter("EmailIdTo");		
		String message = "Your Leave Request has been " + status;
		
		if (emailIdTo != null && emailIdTo != "") {
			log.info(" message True" + response);
			response = sendMail(nameOfApplicant, emailIdFrom, nameOfPoc,
					emailIdTo, message);
			log.info("Mail Send Successfully :" + response);
			log.info(" welcome " + emailIdTo + " message " + response);
		} else {
			log.info(" message false :" + response);
			response = "Failed";
			log.info("Mail Not Send....,Receipent MailId not Found or Null.....,"
					+ response);
			
			leaveRequest.setApprovedDate(approvedDate);
			leaveRequest.setStatus(status);
			
			pm.makePersistent(leaveRequest);
		}
		}catch(Exception e){
			e.printStackTrace();
		}finally {pm.close();}
		
		model.setViewName("ViewStatus");
		return model;

	}

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
			// msg.addRecipients(Message.RecipientType.TO,InternetAddress.parse("abc@abc.com,abc@def.com,ghi@abc.com"));
			msg.setSubject("Leave Request");
			// msg.setReplyTo(InternetAddress.parse(emailIdFrom));
			// msg.getReplyTo();
			msg.setText(message);
			Transport.send(msg);
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
