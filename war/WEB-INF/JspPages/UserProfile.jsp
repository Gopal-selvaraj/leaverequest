<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<html style="height: 570px;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/Css/stylesheet.css" />
<title>UserProfile Page</title>
<%
	if (session.getAttribute("Username") == null
			|| session.getAttribute("Username") == "") {
		response.sendRedirect("Index.com");
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
		<%} %>
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

	<div class="design">
		<p>
			<br> <span>Adaptavant Techologies</span>
		</p>
		<div class="design1">
			<div class="profileimages">
				<img src="<%=session.getAttribute("Image")%>" />
			</div>
			<div class="details">
				<div class="designtable"
					style="margin-top: 10px; text-align: center; color: #eb0684; margin-left: 5px;"><%=session.getAttribute("Username")%></div>
				<table style="margin-top: 10px;">
					<%if(session.getAttribute("DateofBirth")!=null){ %><tr>
						<td>
							<h4>DateofBirth</h4>
						</td>
						<td><h4>
								:
								<%=session.getAttribute("DateofBirth")%></h4></td>
					</tr>
					<%} if(session.getAttribute("DateofRegistration")!=null){ %><tr>
						<td>
							<h4>Company</h4>
						</td>
						<td><h4>
								:
								<%=session.getAttribute("Company")%></h4></td>
					</tr>
					<%} if(session.getAttribute("Userid")!=null){ %>
					<tr>
						<td>
							<h4>Userid</h4>
						</td>
						<td><h4>
								:
								<%=session.getAttribute("Userid")%></h4></td>
					</tr>
					<%} if(session.getAttribute("Emailid")!=null){ %>
					<tr>
						<td>
							<h4>Emailid</h4>
						</td>
						<td><h4>
								:<%=session.getAttribute("Emailid")%></h4></td>
					</tr>
					<%} if(session.getAttribute("Mobileno")!=null){ %>
					<tr>
						<td>
							<h4>Mobileno</h4>
						</td>
						<td><h4>
								:<%=session.getAttribute("Mobileno")%></h4></td>
					</tr>
					<%}%>
				</table>
			</div>
			<div class="button">
				<%if (session.getAttribute("Count") != null) {%><table>
					<tr>
						<td><a href="Retrieve.htm"><input name="Update"
								type="submit" value="Update"></a></td>
						<td><a href="Delete.com"><input name="Delete"
								type="submit" value="Delete"></a></td>
					</tr>
				</table>
				<%}%>
			</div>
		</div>
	</div>
</body>
</html>
