<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/Css/stylesheet.css" />
<title>Registration Page</title>
<%
	if (session.getAttribute("EmployeeName") == null
			|| session.getAttribute("EmployeeName") == "") {

	} else {
		response.setHeader("Cache-Control",
				"no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	}
%>
<script type="text/javascript">
function passwordCheck(){
	
	var password=document.getElementById("password").value;
	var reTypePassword=document.getElementById("reTypePassword").value;
	if(password!==reTypePassword){
		alert("Password Mismatch please retype the password");
	}
}


</script>

</head>
<body bgcolor="Teal">
	<div id="header">
		<h1>Welcome to Adaptavant Technologies</h1>
		<div class="Menu">

			<a href="Index.com">Home</a>

		</div>

		<%
			if (session.getAttribute("Username") == null) {
		%>
		<div class="Menu">

			<a href="Login.com">Login</a>

		</div>
		<%
			} else {
		%>
		<div class="Menu" style="width: 200px;">
			<a href="UserProfile.com"><%=session.getAttribute("Username")%></a>
		</div>
		<%
			if (session.getAttribute("Count") != null) {
		%>
		<div class="Menu" style="width: 50px;">
			<%=session.getAttribute("Count")%>
		</div>
		<%
			}
		%>
		<div class="Menu">
			<a href="Logout.com">Logout</a>
		</div>
		<%
			}
		%>
		<div class="Menu">

			<a href="Contactus.com">ContactUs</a>

		</div>
	</div>
	<div></div>
	<div class="break"></div>
	<form method="post" action="/Register.com">
		<div class="design">
			<p>
				<br> <span>Registration Form</span>
			</p>

			<div class="design1">
				<table style="margin-left: 100px">
					<tr>
						<td>EmployeeName</td>
						<td>:<input maxlength="30" placeholder="Abc123"
							name="EmployeeName" size="20" type="text" id="employeeName"
							value="" required></td>
					</tr>
					<tr>
						<td>EmployeeId</td>
						<td>:<input maxlength="12" placeholder="2013Abcd0003"
							name="EmployeeId" size="20" type="text" id="employeeId" value=""
							required></td>
					</tr>
					<tr>
						<td>DateOfBirth</td>
						<td>:<input maxlength="10" placeholder="MM/DD/YYYY" value=""
							name="DateOfBirth" size="20" type="date" id="dateOfBirth"
							value="" required></td>
					</tr>
					<tr>
						<td>DateOfJoining</td>
						<td>:<input maxlength="10" placeholder="MM/DD/YYYY"
							name="DateOfJoining" size="20" type="date" value=""
							id="dateOfJoining" required></td>
					</tr>
					<tr>
						<td>CompanyName</td>
						<td>:<input maxlength="30" placeholder="Abcdef" value=""
							name="CompanyName" size="20" type="text" id="companyName"
							required></td>
					</tr>
					<tr>
						<td>Team</td>
						<td>:<input maxlength="30" placeholder="Abcdef" value=""
							name="Team" size="20" type="text" id="team" required></td>
					</tr>
					<tr>
						<td>Role</td>
						<td>:<input maxlength="30" placeholder="Abcdef" value=""
							name="Role" size="20" type="text" id="role" required></td>
					</tr>
					<tr>
						<td>Address</td>
						<td>:<textarea rows="3" cols="30" id="address" name="Address"
								placeholder="Address"
								style="resize: none; max-width: 100px; max-height: 100px;"></textarea></td>
					</tr>
					<tr>
						<td>EmailId</td>
						<td>:<input maxlength="30" placeholder="abc*88@gmail.com"
							name="EmailId" size="20" type="email" id="emailId" value=""
							required></td>
					</tr>
					<tr>
						<td>MobileNo</td>
						<td>:<input maxlength="10" placeholder="9988771123"
							name="MobileNo" size="20" type="text" id="mobileNo" value=""
							required></td>
					</tr>
					<tr>
						<td>Password</td>
						<td>:<input maxlength="10" placeholder="Abc@123" value=""
							name="Password" size="20" type="password" id="password" required>
						</td>
					</tr>
					<tr>
						<td>ReTypePassword</td>
						<td>:<input maxlength="10" placeholder="Abc@123" value=""
							name="ReTypePassword" size="20" type="password"
							id="reTypePassword" onBlur="passwordCheck()" required></td>
					</tr>
				</table>
				<table style="margin-left: 200px">
					<tr>
						<td><input name="Registration" type="submit" id="register"
							value="Register"></td>
						<td><input name="Reset" type="reset" value="Reset"></td>

					</tr>

				</table>
			</div>
		</div>
	</form>
</body>
</html>
