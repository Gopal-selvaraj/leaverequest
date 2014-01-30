package com.leaverequest;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
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

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.employeedetails.EmployeeBeanClass;

@Controller
public class LeaveRequestController {
	private Logger log = Logger.getLogger(LeaveRequestBeanClass.class.getName());

	@RequestMapping(value = "Leave.com")
	public String leaveRequest() {
		return "LeaveRequestForm";

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/LeaveRequest.com")
	public ModelAndView Register(HttpServletRequest req) throws ParseException,
			UnsupportedEncodingException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// HttpSession session = req.getSession();
		// Create the Object for LeaveRequestBeanClass
		LeaveRequestBeanClass leaveRequest = new LeaveRequestBeanClass();
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
			String approvedDate = "Empty";
			String status = "Pending";
			String emailIdTo = null;

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
					System.out.println(emailIdTo);

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
			
			System.out.println(emailIdTo+" message ");
			String response="";
			if (emailIdTo != null && emailIdTo != "") {
				System.out.println(" message True"+response);
				response = sendMail(nameOfApplicant, emailIdFrom,
						nameOfPoc, emailIdTo);
				log.info("Mail Send Successfully :" + response);
				System.out.println(" welcome "+emailIdTo+" message "+response);
			}
			else{
				System.out.println(" message false :"+response);
				response="Failed";
				log.info("Mail Not Send....,Receipent MailId not Found or Null.....,"+response);
			}
			pm.makePersistent(leaveRequest);

		} catch(Exception e){
			System.out.println(" message error ");			
		}finally {
			// Close the PersistenceManager
			pm.close();

		}

		// Return the results to the Userprofile page by using the model and
		// view
		return new ModelAndView("UserProfile");
	}

	private String sendMail(String nameOfApplicant, String emailIdFrom,
			String nameOfPoc, String emailIdTo)
			throws UnsupportedEncodingException {
		System.out.println(" message test");
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		String msgBody = "You Got a Mail ";

		try {

			Message msg = new MimeMessage(session);

			msg.setFrom(new InternetAddress(emailIdFrom, nameOfApplicant));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(
					emailIdTo, nameOfPoc));
			msg.setSubject("Leave Request");
			msg.setText(msgBody);
			Transport.send(msg);
			
			System.out.println("Ok tested Good ");
			// MimeMessage message = new MimeMessage(session,
			// req.getInputStream());
		} catch (AddressException e1) {
			System.out.println("Address Mismatch ");
			log.info("AddressNotFound :" + e1);
		} catch (MessagingException e) {
			System.out.println("Message Mismatch ");
			log.info("Messaging :" + e);
		}
		return "Success";

	}

}
