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
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.instanceclass.PMF;
import com.leaverequest.LeaveRequestBeanClass;
import com.leaverequest.LeaveType;

@Controller
public class EmployeeController {
	private Logger log = Logger
			.getLogger(LeaveRequestBeanClass.class.getName());

	@RequestMapping(value = "/registerPage")
	public String register() {
		return "Register";
	}

	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public ModelAndView registration(HttpServletRequest req,
			HttpServletResponse res) throws ParseException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();
		// count the Registration
		String count = null;
		try {

			count = employee.getKey();
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
			
		
			// Create the Object for LeaveRequestBeanClass
			LeaveType leave = LeaveType.getInstance();
			leave.setEmailId(emailId);
			leave.setCasualLeaves(12);
			leave.setPrevileageLeaves(12);
			leave.setSickLeaves(12);
			leave.setOtherLeaves(0);
			pm.makePersistent(leave);
		//	pmf.close();
			

		} catch (Exception e) {
			// Incase of any failure in try block Error information stored in
			// logs
			log.info("Your Employee Record Not Registered Because of : " + e);
		} finally {
			// Close the Persistence Manager
			pm.close();
		}
		if (count == null)
			return new ModelAndView("Register", "model",
					"Registered Successfully");
		else
			return new ModelAndView("LoginTemplate");
	}
	
	

	@RequestMapping(value = "/homePage")
	public String homePage() {
		return "HomeTemplate";
	}

	@RequestMapping(value = "/login")
	public String loginPage() {
		return "LoginPage";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest req) {
		HttpSession session = req.getSession(true);
		session.invalidate();
		return new ModelAndView("HomeTemplate");
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public void update(HttpServletRequest req) throws ParseException {
		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();
		String emailId = req.getParameter("EmailId");
		String password = req.getParameter("Password");
		String message = "Employee Password was not Inserted";

		Query query = pm.newQuery(EmployeeBeanClass.class);
		query.setFilter("employeeEmailId =='" + emailId + "' ");
		List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query
				.execute();
		EmployeeBeanClass emailUpdate = employees.get(0);
		emailUpdate.setEmployeeEmailId(emailId);
		emailUpdate.setPassword(password);
		pm.makePersistent(emailUpdate);

	}

	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/deleteEmployee", method = RequestMethod.GET)
	public void deletion(HttpServletRequest req) throws ParseException {
		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();

		String emailId = req.getParameter("EmailId");

		String message = "Employee Record was not Deleted";

		Query query = pm.newQuery(EmployeeBeanClass.class);
		query.setFilter("employeeEmailId =='" + emailId + "' ");
		List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query
				.execute();
		EmployeeBeanClass emailDelete = employees.get(0);
		pm.deletePersistent(emailDelete);
		pm.makePersistent(emailDelete);
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@RequestMapping(value = "/searchEmployee", method = RequestMethod.GET)
	public @ResponseBody
	String searching(HttpServletRequest req, HttpServletResponse res)
			throws ParseException, IOException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();

		String emailId = req.getParameter("EmailId");
		// System.out.println(emailId);
		Query query = pm.newQuery(EmployeeBeanClass.class);
		query.setFilter("employeeEmailId =='" + emailId + "' ");
		List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query
				.execute();
		EmployeeBeanClass emailSearch = employees.get(0);
		JSONObject empRecord = new JSONObject();

		if (emailId.equals(emailSearch.getEmployeeEmailId())) {
			// System.out.println("iam in ");
			empRecord.put("employeeName", emailSearch.getEmployeeName());
			empRecord.put("employeeId", emailSearch.getEmployeeId());
			empRecord.put("address", emailSearch.getAddress());
			empRecord.put("emailId", emailSearch.getEmployeeEmailId());
			empRecord.put("team", emailSearch.getTeam());
			empRecord.put("role", emailSearch.getRole());
			empRecord.put("password", emailSearch.getPassword());
			empRecord.put("mobileNo", emailSearch.getMobileNo());
			// System.out.println(empRecord.toJSONString());
			res.setContentType("application/json");
			// res.encodeRedirectURL(empRecord.toJSONString());

		}
		return empRecord.toJSONString();

	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(HttpServletRequest req)
			throws ParseException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();

		try {
			// Get the values from the Jsp Form and set values into Datastore by
			// using the employee Object.
			String employeeName = req.getParameter("EmployeeName");
			String employeeId = req.getParameter("EmployeeId");
			String employeeDoj = req.getParameter("DateOfJoining");
			String team = req.getParameter("Department");
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
			
			LeaveType leave = LeaveType.getInstance();
			leave.setEmailId(emailId);
			leave.setCasualLeaves(12);
			leave.setPrevileageLeaves(12);
			leave.setSickLeaves(12);
			leave.setOtherLeaves(0);
			pm.makePersistent(leave);

		} catch (Exception e) {
			// Incase of any failure in try block Error information stored in
			// logs
			log.info("Your Employee Record Not Registered Because of : " + e);
		} finally {
			// Close the Persistence Manager
			pm.close();
		}
		return "LoginTemplate";

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/loginAuthentication", method = RequestMethod.POST)
	public ModelAndView loginAuthentication(HttpServletRequest req,ModelAndView model) throws IOException {
		// Create the Object for EmployeeBeanClass
		//EmployeeBeanClass employee = EmployeeBeanClass.getInstance();
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
			if (employeeLogin.getPassword().equals(password)) {			
				// Creating the session and setting the employee details
				// into the session variables				
				session.setAttribute("EmployeeName",
						employeeLogin.getEmployeeName());
				session.setAttribute("EmployeeId",
						employeeLogin.getEmployeeId());
				session.setAttribute("EmployeeDoj",
						employeeLogin.getEmployeeDoj());
				session.setAttribute("EmailId",
						employeeLogin.getEmployeeEmailId());
				session.setAttribute("MobileNo", employeeLogin.getMobileNo());
				session.setAttribute("CompanyName","Adaptavant Technologies Pvt Ltd.");
				session.setAttribute("Team", employeeLogin.getTeam());
				session.setAttribute("role", employeeLogin.getRole());

				Query teamLeader = pm.newQuery(EmployeeBeanClass.class);
				query.setFilter(" team == '" + employeeLogin.getTeam() + "' ");
						
				List<EmployeeBeanClass> tlName = (List<EmployeeBeanClass>) teamLeader.execute();
				for(EmployeeBeanClass teamLead :tlName){
					if(teamLead.getRole().equals("TeamLeader")){
						session.setAttribute("TeamLead", teamLead.getEmployeeEmailId());
				
					}
				}	

				loginState = 1;

			} 			
			 
			model.setViewName("LoginTemplate");

		} catch (Exception e) {
			// Incase of any failure in try block Error information stored in
			// logs
			log.info("Login Failed Because of : " + e);

		} finally {
			// Close the Persistence Manager
			pm.close();
		}
		if (loginState == 1) {
			return model;

		} else {
			return new ModelAndView("LoginPage", "model",
					"EmailId or Password Mismatch LoginFailed");
		}
	}
}
