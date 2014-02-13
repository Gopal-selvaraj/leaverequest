package com.employeedetails;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.UUID;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.instanceclass.PMF;

@Controller
public class EmployeeController {

	@RequestMapping(value = "Index.com")
	public String Index() {
		return "Index";
	}
	
	@RequestMapping(value = "loginTemplate.com")
	public String loginTemplate() {
		return "LoginTemplate";
	}

	@RequestMapping(value = "Registration.com")
	public String Registration() {
		return "Registration";
	}

	@RequestMapping(value = "Login.com")
	public String Login() {
		return "Login";
	}

	@RequestMapping(value = "Contactus.com")
	public String Contactus() {

		return "Contactus";
	}
	
	@RequestMapping(value = "UserProfile.com")
	public String userProfile() {

		return "UserProfile";
	}

	@RequestMapping(value = "Logout.com")
	public String Logout(HttpServletRequest req) {

		HttpSession session = req.getSession();
		session.invalidate();
		return "Logout";
	}

	@RequestMapping(value = "/Register.com")
	public ModelAndView Register(HttpServletRequest req) throws ParseException {

		// Create the singleton Object for persistence manager Class
		PersistenceManager pm = PMF.get().getPersistenceManager();

		// Create the Object for EmployeeBeanClass
		EmployeeBeanClass employee = EmployeeBeanClass.getInstance();
		

		try {

			// Get the values from the Jsp Form and set values into Datastore by
			// using the employee Object.
			String employeeName = req.getParameter("EmployeeName");
			String employeeId = req.getParameter("EmployeeId");
			String employeeDob = req.getParameter("DateOfBirth");
			String employeeDoj = req.getParameter("DateOfJoining");
			String companyName = req.getParameter("CompanyName");
			String team = req.getParameter("Team");
			String role = req.getParameter("Role");
			String address = req.getParameter("Address");
			String emailId = req.getParameter("EmailId");
			String mobileNo = req.getParameter("MobileNo");
			String password = req.getParameter("Password");

			employee.setEmployeeName(employeeName);
			employee.setEmployeeDob(employeeDob);
			employee.setEmployeeDoj(employeeDoj);
			employee.setCompanyName(companyName);
			employee.setTeam(team);
			employee.setRole(role);
			employee.setAddress(address);
			employee.setEmployeeEmailId(emailId);
			employee.setMobileNo(mobileNo);
			employee.setPassword(password);
			employee.setEmployeeId(employeeId);
			UUID id=UUID.randomUUID();
			employee.setKey(id.toString());
			
			pm.makePersistent(employee);

		} finally {
			// Close the PersistenceManager
			pm.close();

		}

		// Return the results to the Userprofile page by using the model and
		// view
		return new ModelAndView("RegisteredSuccessfully");
	}


	@RequestMapping(value = "/Loginauth.com", method = RequestMethod.POST)
	public String userInfo(HttpServletRequest req) throws IOException {

		PersistenceManager pm = PMF.get().getPersistenceManager();

		String emailId = req.getParameter("EmailId");
		String password = req.getParameter("Password");

		try {
			// int increment = 0;

			// Query filter is used to filter the particular field with
			// value
			Query query = pm.newQuery(EmployeeBeanClass.class);
			query.setFilter("employeeEmailId =='" + emailId + "' ");
			
			// using the List to get the entries from the data store
			
			@SuppressWarnings("unchecked")
			List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query.execute();
			for (EmployeeBeanClass employee : employees) {
				if ((employee.getEmployeeEmailId()).equals(emailId)
						&& (employee.getPassword()).equals(password)) {
					
					HttpSession session = req.getSession();

					/*
					 * model.addAttribute("Username", employee.getUserName());
					 * model.addAttribute("Company", employee.getCompany());
					 * model
					 * .addAttribute("DateofBirth",employee.getDateOfBirth());
					 * model.addAttribute("DateofRegistration",employee.
					 * getDateOfRegistration());
					 * model.addAttribute("Userid",employee.getUserId());
					 * model.addAttribute("Emailid", employee.getEmailId());
					 * model.addAttribute("Image", employee.getImage());
					 * model.addAttribute("Mobileno", employee.getMobileNo());
					 * model.addAttribute("Count",employee.getCount());
					 */

					session.setAttribute("EmployeeDob",employee.getEmployeeDob());
					session.setAttribute("EmployeeDoj",employee.getEmployeeDoj());
					session.setAttribute("EmployeeId", employee.getEmployeeId());
					session.setAttribute("EmployeeName", employee.getEmployeeName());
					session.setAttribute("EmailId", employee.getEmployeeEmailId());
					session.setAttribute("MobileNo", employee.getMobileNo());
					session.setAttribute("CompanyName", employee.getCompanyName());
					session.setAttribute("Team", employee.getTeam());
					session.setAttribute("role", employee.getRole());
					
					pm.makePersistent(employee);

				}
			}
		} catch (Exception e) {
			
			 return "LoginFailed";

		} finally {
			pm.close();
		}
		return "UserProfile";
	}

}
