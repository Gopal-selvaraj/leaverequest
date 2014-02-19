package com.employeedetails;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.UUID;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.instanceclass.PMF;
import com.leaverequest.LeaveRequestBeanClass;

@Controller
public class EmployeeController {
	private Logger log = Logger
			.getLogger(LeaveRequestBeanClass.class.getName());

	@RequestMapping(value = "/homePage")
	public String homePage() {
		return "HomeTemplate";
	}

	@RequestMapping(value = "/login")
	public String loginPage() {
		return "LoginPage";
	}
	@RequestMapping(value = "/register")
	public String register() {
		return "Register";
	}

	@RequestMapping(value = "/logout",method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest req) {
		HttpSession session = req.getSession(true);
		session.invalidate();
		return new ModelAndView("HomeTemplate");
	}
	
	@RequestMapping(value = "/deleteEmployee",method = RequestMethod.POST)
	public ModelAndView deletion(HttpServletRequest req, HttpServletResponse res,ModelAndView model)
			throws ParseException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();
		String emailId=req.getParameter("EmailId");
		
		Query query = pm.newQuery(EmployeeBeanClass.class);
		query.setFilter("employeeEmailId =='" + emailId + "' ");
		if(emailId.equals(employee.getEmployeeEmailId())){
			pm.deletePersistent(employee.getEmployeeEmailId());
		}
		model.addObject("Delete", "Deleted Successfully");
		model.setViewName("LoginTemplate");
		return model;
	}
	
	@RequestMapping(value = "/searchEmployee",method = RequestMethod.POST)
	public ModelAndView searching(HttpServletRequest req, HttpServletResponse res,ModelAndView model)
			throws ParseException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();
		String emailId=req.getParameter("EmailId");
		
		Query query = pm.newQuery(EmployeeBeanClass.class);
		query.setFilter("employeeEmailId =='" + emailId + "' ");
		if(emailId.equals(employee.getEmployeeEmailId())){
			model.addObject("search", "");
		}		
		model.setViewName("LoginTemplate");
		return model;
	}
	

	@RequestMapping(value = "/registration",method = RequestMethod.POST)
	public ModelAndView registration(HttpServletRequest req, HttpServletResponse res)
			throws ParseException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();
		//count the Registration 
		String count=null;
		try {

			count=employee.getKey();
			// Get the values from the Jsp Form and set values into Datastore by
			// using the employee Object.
			String employeeName = req.getParameter("EmployeeName");
			String employeeId = req.getParameter("EmployeeId");
			String employeeDoj = req.getParameter("DateOfJoining");
			String team = req.getParameter("Team");
			String role = req.getParameter("Role");
			String address = req.getParameter("Address");
			String emailId = req.getParameter("EmailId");
			String mobileNo = req.getParameter("MobileNo");
			String password = req.getParameter("Password");

			// Set the Employee records into employee Object
			employee.setEmployeeName(employeeName);
			employee.setEmployeeId(employeeId);
			employee.setEmployeeDoj(employeeDoj);
			employee.setTeam(team);
			employee.setRole(role);
			employee.setAddress(address);
			employee.setEmployeeEmailId(emailId);
			employee.setMobileNo(mobileNo);
			employee.setPassword(password);
		
			// Universal Unique Identifier to set the Key for each Employee
			// Records
			UUID id = UUID.randomUUID();
			employee.setKey(id.toString());

			// Persist the Employee Object into DataStore
			pm.makePersistent(employee);
						

		} catch (Exception e) {
			// Incase of any failure in try block Error information stored in logs
			log.info("Your Employee Record Not Registered Because of : " + e);
		} finally {
			// Close the Persistence Manager
			pm.close();
		}
		if(count==null)
			return new ModelAndView("Register","model","Registered Successfully");
		else 
			return new ModelAndView("LoginTemplate");
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loginAuthentication", method = RequestMethod.POST)
	public ModelAndView loginAuthentication(HttpServletRequest req,
			HttpServletResponse res,ModelAndView model) throws IOException {

		PersistenceManager pm = PMF.get().getPersistenceManager();
		HttpSession session = req.getSession();
		// Getting the input from the front end and assign into local variable..
		String emailId = req.getParameter("EmailId");
		String password = req.getParameter("Password");
		
		// It is used to check the Login status
		int loginState = 0;	
		try {		
			// Query filter is used to filter the particular field with
			// value
			Query query = pm.newQuery(EmployeeBeanClass.class);
			query.setFilter("employeeEmailId =='" + emailId + "' ");

			// using the List to get the entries from the data store

			
			List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query
					.execute();
			EmployeeBeanClass employeeLogin = employees.get(0);
			
				if ((employeeLogin.getPassword()).equals(password)) {
					
					// Creating the session and setting the employee details
					// into the session variables
					
					session.setAttribute("EmployeeName",
							employeeLogin.getEmployeeName());
					session.setAttribute("EmployeeId", employeeLogin.getEmployeeId());
					session.setAttribute("EmployeeDoj",
							employeeLogin.getEmployeeDoj());
					session.setAttribute("EmailId",
							employeeLogin.getEmployeeEmailId());
					session.setAttribute("MobileNo", employeeLogin.getMobileNo());
					session.setAttribute("CompanyName",
							"Adaptavant Technologies Pvt Ltd.");
					session.setAttribute("Team", employeeLogin.getTeam());
					session.setAttribute("role", employeeLogin.getRole());
					
					Query teamLeader = pm.newQuery(EmployeeBeanClass.class, "(team == '"
							+ employeeLogin.getTeam() + "' )" + "&& role == 'TeamLeader' ");
					List<EmployeeBeanClass> tlName = (List<EmployeeBeanClass>) teamLeader
							.execute();
					EmployeeBeanClass teamLead = tlName.get(0);
					
					session.setAttribute("TeamLead", teamLead.getEmployeeEmailId());
					
					loginState = 1;
				
				
				} 			
				else 
					loginState = 0;
			
				String team = (String) session.getAttribute("Team");
				String status = "Pending";

				Query pending = pm.newQuery(LeaveRequestBeanClass.class, "(team == '"
						+ team + "' )" + "&& status == '" + status + "' ");
				// query1.setFilter("team =='" + team + "' ");				
				List<LeaveRequestBeanClass> pendingLeaves = (List<LeaveRequestBeanClass>) pending
						.execute();
				model.addObject("PendingLeaves", pendingLeaves);	
				
				Query history = pm.newQuery(LeaveRequestBeanClass.class, "employeeEmailId == '" + emailId + "' ");
				List<LeaveRequestBeanClass> leavesTaken = (List<LeaveRequestBeanClass>) history
						.execute();
							
				model.addObject("LeavesTaken", leavesTaken);				
							
				model.setViewName("LoginTemplate");	

		
		} catch (Exception e) {
			// Incase of any failure in try block Error information stored in logs
			log.info("Login Failed Because of : " + e);

		} finally {
			// Close the Persistence Manager
			pm.close();
		}
		if (loginState == 1) {
			return model;
		} else {			
			return new ModelAndView ("LoginPage","model","EmailId or Password Mismatch LoginFailed");
		}
	}
	@RequestMapping(value = "/updateEmployee", method = RequestMethod.POST)
	public ModelAndView updateEmployee(HttpServletRequest req,
			HttpServletResponse res) throws IOException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// Getting the input from the front end and assign into local variable..
		String emailId = req.getParameter("EmailId");
					
					// Query filter is used to filter the particular field with
					// value
					Query query = pm.newQuery(EmployeeBeanClass.class);
					query.setFilter("employeeEmailId =='" + emailId + "' ");

					// using the List to get the entries from the data store

					@SuppressWarnings("unchecked")
					List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query
							.execute();
					for (EmployeeBeanClass employee : employees) {
						if ((employee.getEmployeeEmailId()).equals(emailId)) {
							
							// Creating the session and setting the employee details
							// into the session variables
							HttpSession session = req.getSession();
							session.setAttribute("EmployeeName",
									employee.getEmployeeName());
							session.setAttribute("EmployeeId", employee.getEmployeeId());
							session.setAttribute("EmployeeDoj",
									employee.getEmployeeDoj());
							session.setAttribute("EmailId",
									employee.getEmployeeEmailId());
							session.setAttribute("MobileNo", employee.getMobileNo());
							session.setAttribute("CompanyName",
									"Adaptavant Technologies Pvt Ltd.");
							session.setAttribute("Team", employee.getTeam());
							session.setAttribute("role", employee.getRole());	
							session.setAttribute("password", employee.getPassword());	
						} 	
					}
		return new ModelAndView("LoginTemplate");		
	}

}
