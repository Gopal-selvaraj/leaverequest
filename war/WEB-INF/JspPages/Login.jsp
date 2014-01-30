<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/Css/stylesheet.css" />
<title>Login Page</title>
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
			} else {
		%>
		<div class="Menu" style="width: 200px;">
			<a href="UserProfile.com"><%=session.getAttribute("EmployeeName")%></a>
		</div>
		<div class="Menu" style="width: 50px;">
			<%=session.getAttribute("Count")%>
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
	<form action="/Loginauth.com" method="post">

		<div class="design">
			<p>
				<br> <span>Login Form</span>
			</p>

			<div class="design1">
				<br> <br> <br> <br> <br> <br>
				<table style="margin-left: 125px">
					<tr>
						<td>EmailId</td>
						<td>:<input maxlength="30" name="EmailId" size="20"
							type="text"></td>
					</tr>
					<tr>
						<td>Password</td>
						<td>:<input maxlength="10" name="Password" size="20"
							type="password"></td>
					</tr>
				</table>
				<br>
				<table style="margin-left: 30px">
					<tr>
						<td><div class="button" style="margin-top: 25px;">
								<input type="submit" value="Login">
							</div></td>
					</tr>
				</table>


			</div>
		</div>
	</form>

</body>
</html>


