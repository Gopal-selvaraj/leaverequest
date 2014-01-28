package com.leaverequest;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.employeedetails.EmployeeBeanClass;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;


@Controller
public class LeaveRequestController {

	@RequestMapping(value = "Index.com")
	public String Index() {
		return "Index";
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
		EmployeeBeanClass employee = new EmployeeBeanClass();

		try {

			// Create the Object for SimpleDateFormat for Date type.
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date employeeDob = null;
			Date employeeDoj = null;

			// Get the values from the Jsp Form and set values into Datastore by
			// using the employee Object.
			String employeeName = req.getParameter("EmployeeName");
			String employeeId = req.getParameter("EmployeeId");
			String edob = req.getParameter("DateOfBirth");
			String edoj = req.getParameter("DateOfJoining");
			String companyName = req.getParameter("CompanyName");
			String team = req.getParameter("Team");
			String role = req.getParameter("Role");
			String address = req.getParameter("Address");
			String emailId = req.getParameter("EmailId");
			String mobileNo = req.getParameter("MobileNo");
			String password = req.getParameter("Password");

			if (edob != null && edoj != null) {
				employeeDob = formatter.parse(edob);
				employeeDoj = formatter.parse(edoj);
			}

			employee.setEmployeeName(employeeName);
			employee.setEmployeeDob(employeeDob);
			employee.setEmployeeDoj(employeeDoj);
			employee.setCompanyName(companyName);
			employee.setTeam(team);
			employee.setRole(role);
			employee.setAddress(address);
			employee.setEmailId(emailId);
			employee.setMobileNo(mobileNo);
			employee.setPassword(password);
			employee.setEmployeeId(employeeId);

			Key key = KeyFactory.createKey(
					EmployeeBeanClass.class.getSimpleName(), employeeId);
			employee.setKey(key);
			pm.makePersistent(employee);

		} finally {
			// Close the PersistenceManager
			pm.close();

		}

		// Return the results to the Userprofile page by using the model and
		// view
		return new ModelAndView("RegisteredSuccessfully");
	}
	
	
		@RequestMapping(value = "Loginauth.com", method = RequestMethod.POST)
		public String userInfo(HttpServletRequest req) throws IOException {

			PersistenceManager pm = PMF.get().getPersistenceManager();

			String employeeId = req.getParameter("EmployeeId");
			String password = req.getParameter("Password");

			try {
				// int increment = 0;

				// Query filter is used to filter the particular field with
				// value
				Query query = pm.newQuery(EmployeeBeanClass.class);
				query.setFilter("employeeId =='" + employeeId + "' ");

				// using the List to get the entries from the data store
				@SuppressWarnings("unchecked")
				List<EmployeeBeanClass> employees = (List<EmployeeBeanClass>) query.execute();
				for (EmployeeBeanClass employee : employees) {
					if (employee.getEmployeeId().equals(employeeId)
							&& employee.getPassword().equals(password)) {
//						HttpSession session = req.getSession();

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

//						session.setAttribute("DateofBirth",
//								employee.getDateOfBirth());
//						session.setAttribute("DateofRegistration",
//								employee.getDateOfRegistration());
//						session.setAttribute("Userid", employee.getUserId());
//						session.setAttribute("Username", employee.getUserName());
//						session.setAttribute("Emailid", employee.getEmailId());
//						session.setAttribute("Image", employee.getImage());
//						session.setAttribute("Mobileno", employee.getMobileNo());
//						session.setAttribute("Company", employee.getCompany());
//						session.setAttribute("Count", employee.getCount());
//						session.setAttribute("Password", employee.getPassword());

						//pm.makePersistent(employee);
						
						System.out.println("Welcome to user Login");
					}
				}
			} catch (Exception e) {
				return "LoginFailed";

			} finally {
				pm.close();
			}
			return "Index";

		
	}

}
