<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/Css/stylesheet.css" />
<title>Welcome Page</title>
<%
	if (session.getAttribute("EmployeeName") != null
			|| session.getAttribute("EmployeeName") != "") {

		response.setHeader("Cache-Control",
				"no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	}
%>
</head>
<body bgcolor="Teal">
	<div id="header">
		<h1>Welcome to Adaptavant Technologies</h1>
		<div class="Menu">

			<a href="Index.com">Home</a>

		</div>
		<div class="Menu">

			<a href="Registration.com">Registration</a>

		</div>
		<%
			if (session.getAttribute("EmployeeName") == null) {
		%>
		<div class="Menu">

			<a href="Login.com">Login</a>

		</div>
		<%
			} else {
		%>
		<div class="Menu" style="width: 200px;">
			<a href="UserProfile.com"><%=session.getAttribute("EmployeeName")%></a>
		</div>
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

	<form method="post" action="/LeaveRequest.com">
		<div class="design">
			<p>
				<br> <span>LeaveRequest Form</span>
			</p>

			<div class="design1">
				<table style="margin-left: 125px; margin-top: 85px">
					<tr>
						<td>EmployeeName</td>
						<td>:<input maxlength="30" placeholder="Krish"
							name="EmployeeName" size="25" type="text" id="employeeName"
							value="<%=session.getAttribute("EmployeeName")%>" required></td>
					</tr>
					<tr>
						<td>Role</td>
						<td>:<input type="text" name="Role" id="role"
							placeholder="JuniorSoftwareEngineer"
							value="<%=session.getAttribute("role")%>" required></td>
					</tr>
					<tr>
						<td>Team</td>
						<td>:<input maxlength="30" placeholder="Developers"
							value="<%=session.getAttribute("Team")%>" name="Team" size="25"
							type="text" id="team" required></td>
					</tr>
					<tr>
					<tr>
						<td>EmailId</td>
						<td>:<input maxlength="30" placeholder="abc@gmail.com"
							name="EmailId" size="25" type="email" id="emailId"
							value="<%=session.getAttribute("EmailId")%>" required></td>
					</tr>
					<tr>
						<td>LeaveFrom</td>
						<td>:<input maxlength="10" placeholder="MM/DD/YYYY"
							name="LeaveFrom" size="25" type="date" id="leaveFrom" value=""
							required></td>
					</tr>
					<tr>
						<td>LeaveTo</td>
						<td>:<input maxlength="10" placeholder="MM/DD/YYYY"
							name="LeaveTo" size="25" type="date" value="" id="leaveTo"
							required></td>
					</tr>
					<tr>
						<td>RequestDate</td>
						<td>:<input maxlength="30" placeholder="Abcdef" value=""
							name="RequestDate" size="25" type="date" id="requestDate"
							required></td>
					</tr>
					<tr>
						<td>SendTo</td>
						<td>:<input maxlength="25" placeholder="TeamLeadername"
							value="" name="SendTo" size="25" type="text" id="SendTo" required></td>
					</tr>

				</table>
				<table style="margin-left: 220px; margin-top: 15px">
					<tr>
						<td><input name="Send" type="submit" id="send" value="send"></td>
						<td><input name="Reset" type="reset" value="Reset"></td>

					</tr>

				</table>
			</div>
		</div>
	</form>

</body>
</html>
