<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript">


	function clickme(id) {
		//alert(id);
		
		var row = document.getElementsByTagName('TR').length;
		for (var j = 1; j <= row; j++) {
			var status = 'status' + j;
			var email= "email" + j;
			var nameOfApplicant="applicant" + j;
			var team="team" + j;
			var appliedDate="appliedDate"+j;
			var uuidKey="key" + j;
			if (id == status) {
				
				var emailIdTo = document.getElementById(email).value;
				var key = document.getElementById(uuidKey).value;
								
				var approvedBy= "<%=session.getAttribute("EmployeeName")%>";
				var emailIdFrom = "<%=session.getAttribute("EmailId")%>";
				var teamName = document.getElementById(team).innerHTML;
				var employeeName = document.getElementById(nameOfApplicant).innerHTML;
				var requestDate = document.getElementById(appliedDate).innerHTML;
				var statusIndex = document.getElementById(status).selectedIndex;
				var updatedStatus = document.getElementById(status)[statusIndex].text;

				var sendMail = confirm("Press ok to send Email and Update the Leave Request Status else click cancel");
				if (sendMail == true) {
					var mail = updateCalled(approvedBy, emailIdFrom,
							employeeName, emailIdTo, teamName, updatedStatus,
							requestDate, id, key);
					alert(mail);

				} else {
					alert("Leave request was not updated Please click ok to send Email and Update");
				}

			}
		}

	}

	var request;
	function updateCalled(approvedBy, emailIdFrom, employeeName, emailIdTo,
			teamName, updatedStatus, requestDate, id, key) {

		var parameters = "approvedBy=" + approvedBy + "&emailIdFrom="
				+ emailIdFrom + "&employeeName=" + employeeName + "&emailIdTo="
				+ emailIdTo + "&teamName=" + teamName + "&status="
				+ updatedStatus + "&requestDate=" + requestDate + "&key=" + key;

		//	alert("Sent email to the user");

		if (window.XMLHttpRequest) {
			request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			request = new ActiveXObject("MicroSoft.XMLHTTP");
		}
		try {
			request.onreadystatechange = retrieveData();
			request.open("POST", '/UpdateStatus.com', true);
			request.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			request.send(parameters);
		} catch (e) {
			alert("Unable to connect server");
		}

		return document.getElementById(id).disabled = true;
	}

	function retrieveData() {
		if (request.readyState == 4 && request.status == 200) {
			alert("Leave Status Updated Successfully");

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
		<div style="height: 500px; margin-top: 100px;">
			<br />
			<table border="1"
				style="margin-top: 20px; margin-left: 150px; text-align: left; padding: 5px; border-spacing: 5px"
				id="tableView">

				<tr>
					<th>NameOfApplicant</th>
					<th>Team</th>
					<th>Role</th>
					<th>LeaveFrom</th>
					<th>LeaveTo</th>
					<th>AppliedDate</th>
					<th>Status</th>

				</tr>
				<%
					int count = 0;
				%>
				<c:forEach items="${Leave}" var="LeaveList">
					<%
						++count;
					%>
						<input name="Email" type="hidden"
						value="${LeaveList.employeeEmailId}" id="email<%=count%>">
						<input name="Key" type="hidden"
						value="${LeaveList.key}" id="key<%=count%>">
					<tr>
						<td id="applicant<%=count%>">${LeaveList.nameOfApplicant}</td>
						<td id="team<%=count%>">${LeaveList.team}</td>
						<td id="role<%=count%>">${LeaveList.role}</td>
						<td id="leaveFrom<%=count%>">${LeaveList.leaveFrom}</td>
						<td id="leaveTo<%=count%>">${LeaveList.leaveTo}</td>
						<td id="appliedDate<%=count%>">${LeaveList.appliedDate}</td>
						<td><select name="Status" id="status<%=count%>"
							onchange="clickme(this.id)">
								<option value="Pending">Pending</option>
								<option value="Approved">Approved</option>
								<option value="Declined">Declined</option>
						</select></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</form>
</body>
</html>
