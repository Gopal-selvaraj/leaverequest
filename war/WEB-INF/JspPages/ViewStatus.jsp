<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

	<form method="post" action="/UpdateStatus.com">
		<div class="design">
			<p>
				<br> <span>LeaveRequest Form</span>
			</p>

			<div class="design1">
				<table style="margin-left: 125px; margin-top: 85px">
					<tr>
						<td>EmployeeName</td><td>Role</td><td>Team</td><td>EmailId</td><td>LeaveFrom</td><td>LeaveTo</td>
						<td>RequestDate</td><td>SendTo</td></tr>
						<c:forEach items="${Employee}" var="empLeaveList">
						<tr>
						<td>:<input maxlength="30" size="25" type="text" id="employeeName"
							value="${empLeaveList.employeeName}" disabled></td>
					
						
						<td>:<input type="text" name="Role" id="role"							
							value="${empLeaveList.role}" disabled></td>
					
											
						<td>:<input maxlength="30" value="${empLeaveList.team}" name="Team" size="25"
							type="text" id="team" disabled></td>
						
						<td>:<input maxlength="30" name="EmailId" size="25" type="email" id="emailId"
							value="${empLeaveList.emailId}" disabled></td>
						
						<td>:<input maxlength="10" name="LeaveFrom" size="25" type="date" id="leaveFrom" value="${empLeaveList.leaveFrom}"
							disabled></td>
						
						<td>:<input maxlength="10" name="LeaveTo" size="25" type="date" value="${empLeaveList.leaveTo}" id="leaveTo"
							disabled></td>
						<td>:<input maxlength="30" value="${empLeaveList.requestDate}"	name="RequestDate" 
						size="25" type="date" id="requestDate" disabled></td>

						<td>:<input maxlength="10"
							value="${empLeaveList.approvedBy}" name="ApprovedBy" size="25" type="text" id="approvedBy" disabled></td>
					<td>:<input maxlength="10"
							value="${empLeaveList.status}" name="Status" size="25" type="text" id="status" disabled></td>
					
					</tr>
					</c:forEach>

				</table>
				<table style="margin-left: 220px; margin-top: 15px">
					<tr>
						<td><input name="Update" type="submit" id="update" value="Update"></td>
					</tr>
				</table>
			</div>
		</div>
	</form>

</body>
</html>
