<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>User Pages</title>
<%
	if (session.getAttribute("EmployeeName") == null
			|| session.getAttribute("EmployeeName") == "") {
		session.invalidate();
		response.sendRedirect("/HomeTemplate.com");
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

function passCheck(){
	var password=document.getElementById("pass").value;
	var reTypePassword=document.getElementById("rePass").value;
	if(password!==reTypePassword){
		alert("Password Mismatch please retype the password");
	}
}

function updatePassword(){
	var emailId="<%=session.getAttribute("EmailId")%>";
	var password=document.getElementById("pass").value;
	var parameters="EmailId="+emailId+"&Password="+password;
	var url="/updatePassword";
	var method="POST";	
	alert(parameters);
	var Pass=sendRequest(method,parameters, url);	
	document.getElementById("updatePass").blur();
}
function addEmployee(){
	var employeeName= document.getElementById("aemployeeName").value;
	var employeeId = document.getElementById("aemployeeId").value;
	var dateOfJoining = document.getElementById("adateOfJoining").value;
	var emailId = document.getElementById("aemailId").value;
	var address = document.getElementById("aaddress").value;
	var role=document.getElementById("arole").value;
	var mobileNo=document.getElementById("amobileNo").value;
	var password=document.getElementById("apassword").value;
	var teamName = document.getElementById("adepartment").selectedIndex;
	var team = document.getElementById("adepartment")[teamName].text;	
	var parameters="EmployeeName="+employeeName+"&EmployeeId="+employeeId+"&DateOfJoining="+dateOfJoining+"&EmailId="+emailId+
	"&Address="+address+"&Department="+team+"&Role="+role+"&MobileNo="+mobileNo+"&Password="+password;
	alert(parameters);
	var url="/register";
	var method="POST";
	
	var add=sendRequest(method,parameters, url);	
	document.getElementById("register").blur();
	alert("Employee Record Added");
}
function updateEmployee(){
	var employeeName= document.getElementById("EmployeeName").value;
	var employeeId = document.getElementById("EmployeeId").value;
	var dateOfJoining = document.getElementById("DateOfJoining").value;
	var emailId = document.getElementById("EmailId").value;
	var address = document.getElementById("Address").value;
	var role=document.getElementById("Role").value;
	var mobileNo=document.getElementById("MobileNo").value;
	var password=document.getElementById("Password").value;
	var teamName = document.getElementById("Department").selectedIndex;
	var team = document.getElementById("Department")[teamName].text;	
	var parameters="EmployeeName="+employeeName+"&EmployeeId="+employeeId+"&DateOfJoining="+dateOfJoining+"&EmailId="+emailId+
	"&Address="+address+"&Department="+team+"&Role="+role+"&MobileNo="+mobileNo+"&Password="+password;
	alert(parameters);
	var url="/register";
	var method="POST";
	
	var update=sendRequest(method,parameters, url);	
	document.getElementById("update").blur();
	alert("Employee Record Added");
}

function searchEmployeeRecord(){
	
	var searchEmailId=document.getElementById("searchEmailId").value;
	
	var parameters="EmailId="+searchEmailId;	
	var url="/searchEmployee?EmailId="+searchEmailId;
	var method="GET";	
	var searchEmployee=sendRequest(method,parameters,url);
	document.getElementById("search").blur();
}

function deleteEmployeeRecord(){
	
	var searchEmailId=document.getElementById("searchEmailId").value;
	
	var parameters="EmailId="+searchEmailId;
	
	var url="/deleteEmployee?EmailId="+searchEmailId;
	var method="GET";	
	var deleteEmployee=sendRequest(method,parameters, url);	
	document.getElementById("delete").blur();
}



function leaveHistory(){
	
	var teamName = document.getElementById("departments").selectedIndex;
	var team = document.getElementById("departments")[teamName].text;
	var emailId=document.getElementById("email").value;

	var parameters="EmailId="+emailId+"&Team="+team;
	
	var url="/LeaveHistory.com";
	var method="POST";
	alert(parameters+ " " +url);
	var history = sendRequest(method,parameters,url);
	document.getElementById("leavesHistoryTable").style.display='block';
	alert(document.getElementById("leavesHistoryTable").style.display);	

}

function sendEmail(){		
	var employeeName= document.getElementById("employeeName").value;
	var emailIdFrom = document.getElementById("emailId").value;
	var emailIdTo = document.getElementById("emailIdTo").value;
	var team = document.getElementById("team").value;	
	var role=document.getElementById("role").value;
	var requestDate = document.getElementById("requestDate").value;
	var leaveTo = document.getElementById("leaveTo").value;
	var leaveFrom = document.getElementById("leaveFrom").value;
	
	if(document.getElementById("sickLeave").checked===true)
	var sickLeave=1;
	else sickLeave=0;
	if(document.getElementById("casualLeave").checked===true)
	var casualLeave=1;
	else casualLeave=0;
	if(document.getElementById("privilegeLeave").checked===true)
	var privilegeLeave=1;
	else privilegeLeave=0;
	if(document.getElementById("otherLeave").checked===true)
	var other=1;
	else other=0;
	alert(sickLeave+"  "+casualLeave+"  "+privilegeLeave+" "+other);
	
	
	var parameters = "EmailIdFrom="	+ emailIdFrom +"&EmailIdTo=" + emailIdTo+
	"&EmployeeName=" + employeeName + "&Team="	+ team + "&Role=" + role + 
	"&LeaveFrom=" + leaveFrom +"&LeaveTo="	+ leaveTo + "&RequestDate=" + requestDate + 
	"&SickLeave=" + sickLeave+ "&CasualLeave=" + casualLeave+"&PrivilegeLeave=" + privilegeLeave+"&OtherLeave="+other;
	
	var url="leaveRequest";
	
	var method="POST";
	
	//alert(parameters+" "+url);
	var sendMail = confirm("Press ok to send Email and Send the Leave Request  else click cancel");
	if (sendMail == true) {
		var mail = sendRequest(method,parameters,url);	
		alert("Leave Request Send Successfully");
		document.getElementById("leaveTo").value="";
		document.getElementById("leaveFrom").value="";
		document.getElementById("send").blur();
		document.getElementById("sickLeave").checked=false;
		document.getElementById("casualLeave").checked=false;
		document.getElementById("privilegeLeave").checked=false;
		

	} else {
		alert("Leave request was not send Please check and send");
	}
	
	
}

function approvedStatus(id) {	
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

				var parameters = "approvedBy=" + approvedBy + "&emailIdFrom="
						+ emailIdFrom + "&employeeName=" + employeeName
						+ "&emailIdTo=" + emailIdTo + "&teamName=" + teamName
						+ "&status=" + updatedStatus + "&requestDate="
						+ requestDate + "&key=" + key;

				var url = "/updateLeaveStatus";
				var method="POST";
				//alert(parameters+" "+url);
				var sendMail = confirm("Press ok to send Email and Update the Leave Request Status else click cancel");
				if (sendMail == true) {
					var mail = sendRequest(method,parameters, url);
					document.getElementById(id).disabled = true;

				} else {
					alert("Leave request was not updated Please click ok to send Email and Update");
				}
				
			}
		}
	}

	var request;
	function sendRequest(method,parameters, url) {
		if (window.XMLHttpRequest) {
			request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			request = new ActiveXObject("MicroSoft.XMLHTTP");
		}
		try {
			
			request.open(method, url, true);
			request.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			request.send(parameters);
			request.onreadystatechange=function()
			  {
			  if (request.readyState==4 && request.status==200)
			    {
				  var JSONObject = JSON.parse(request.responseText);			
					document.getElementById("EmployeeName").value =JSONObject.employeeName ;
					document.getElementById("EmployeeId").value=JSONObject.employeeId ;
					//document.getElementById("Department").value=JSONObject.team ;
					document.getElementById("Role").value=JSONObject.role ;
					document.getElementById("Address").value=JSONObject.address ;
					document.getElementById("DateOfJoining").value =JSONObject.dateOfJoining ;			
					document.getElementById("EmailId").value =JSONObject.emailId ;
					document.getElementById("MobileNo").value = JSONObject.mobileNo;
					document.getElementById("Password").value = JSONObject.password; 
			    }
			}
		} catch (e) {
			alert("Unable to connect server");
		}		
		
	}

	/* function getResponse() {
		if (request.readyState == 4 && request.status == 200) {
			alert("Server Connected Successfully");
			var JSONObject = JSON.parse(request.responseText);			
			document.getElementById("EmployeeName").value =JSONObject.employeeName ;
			document.getElementById("EmployeeId").value=JSONObject.employeeId ;
			document.getElementById("Team").value=JSONObject.team ;
			document.getElementById("Role").value=JSONObject.role ;
			document.getElementById("Address").value=JSONObject.address ;
			document.getElementById("DateOfJoining").value =JSONObject.dateOfJoining ;			
			document.getElementById("EmailId").value =JSONObject.emailId ;
			document.getElementById("MobileNo").value = JSONObject.mobileNo;
			document.getElementById("Password").value = JSONObject.password; 
			
		}
	} */
	
	
</script>
<script type="text/javascript">
	function showLeaveMenu() {
		if (document.getElementById("leaveInfo").style.display === "none") {
			document.getElementById("carousel").style.display = 'none';
			document.getElementById("employeeInfo").style.display = 'none';
			document.getElementById("userProfileInfo").style.display = 'none';
			document.getElementById("profileSettings").style.display = 'none';
			document.getElementById("leaveInfo").style.display = 'block';
		}
	}
	function showEmployeeMenu() {
		if (document.getElementById("employeeInfo").style.display === "none") {
			document.getElementById("carousel").style.display = 'none';
			document.getElementById("leaveInfo").style.display = 'none';
			document.getElementById("userProfileInfo").style.display = 'none';
			document.getElementById("profileSettings").style.display = 'none';
			document.getElementById("employeeInfo").style.display = 'block';
		}
	}
	function showHome() {
		if (document.getElementById("carousel").style.display === "none") {
			document.getElementById("employeeInfo").style.display = 'none';
			document.getElementById("leaveInfo").style.display = 'none';
			document.getElementById("userProfileInfo").style.display = 'none';
			document.getElementById("profileSettings").style.display = 'none';
			document.getElementById("carousel").style.display = 'block';
		}
	}
	function showProfileInfo() {
		if (document.getElementById("userProfileInfo").style.display === "none") {
			document.getElementById("employeeInfo").style.display = 'none';
			document.getElementById("leaveInfo").style.display = 'none';
			document.getElementById("carousel").style.display = 'none';
			document.getElementById("profileSettings").style.display = 'none';
			document.getElementById("userProfileInfo").style.display = 'block';
		}

	}
	function showSettings() {
		if (document.getElementById("profileSettings").style.display === "none") {
			document.getElementById("employeeInfo").style.display = 'none';
			document.getElementById("leaveInfo").style.display = 'none';
			document.getElementById("carousel").style.display = 'none';
			document.getElementById("userProfileInfo").style.display = 'none';
			document.getElementById("profileSettings").style.display = 'block';
		}
	}
</script>
</head>
<body>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<nav class="navbar navbar-default navbar-fixed-top"
					role="navigation">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span><span
								class="icon-bar"></span><span class="icon-bar"></span><span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#"><img src="/Images/Logo.png"
							alt=" " class="img-rounded" style="height: 50px; width: 50px;" /><img
							src="/Images/AdaptLogo.png" alt=" " class="img-rounded"
							style="height: 50px;" /></a>
					</div>

					<div class="collapse navbar-collapse"	id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown"><%=session.getAttribute("EmployeeName")%><strong
									class="caret"></strong></a>
								<ul class="dropdown-menu">
									<li><a href="#" onclick="showHome()">Home</a></li>
									<li><a href="#" onclick="showProfileInfo()">Profile</a></li>
									<li><a href="#" onclick="showSettings()">Settings</a></li>
									<li class="divider"></li>
									<li><a href="/logout">Logout</a></li>
								</ul></li>
						</ul>
					</div>

				</nav>
			</div>
		</div>
		<!-- Row  Starting -->
		<div class="row clearfix" style="margin-top: 130px">
			<div class="col-md-12 column">
				<div class="row clearfix">
					<!-- Column Left  -->
					<div class="col-md-2 column">
						<%
							if (session.getAttribute("role").equals("TeamLeader")
									|| session.getAttribute("role").equals("Administrator")) {
						%>
						<ul class="nav nav-list">
							<li><a href="#" onclick="showEmployeeMenu()" id="employee">EmployeeInfomation</a></li>
						</ul>
						<%
							}
						%>
						<ul class="nav nav-list">
							<li><a href="#" onclick="showLeaveMenu()" id="leave">LeaveInformation</a></li>
						</ul>

						<!--/.well -->

					</div>
					<!-- End of Column Left -->

					<!--Column Right -->
					<div class="col-md-10 column">
						<div class="span9" style="align: center; margin-left: 75px;">
							<!-- Image Display -->
							<div id="carousel" class="carousel slide" data-ride="carousel"
								style="display: block;">
								<!-- Indicators -->
								<ol class="carousel-indicators">
									<li data-target="#carousel" data-slide-to="0" class="active"></li>
									<li data-target="#carousel" data-slide-to="1"></li>
									<li data-target="#carousel" data-slide-to="2"></li>
								</ol>

								<!-- Wrapper for slides -->
								<div class="carousel-inner">
									<div class="item active">
										<img src="/Images/AdaptBackground.png" alt="">
										<div class="carousel-caption">
											<marquee direction="down" behavior="alternate"
												scrolldelay="1000" style="width: 500px; height: 400px;">
												<h3>
													<p>Welcome To Adaptavant</p>
													<img src="/Images/LogoImage.png" alt=" "
														class="img-rounded" style="height: 350px; width: 450px;" />
												</h3>

											</marquee>
										</div>
									</div>
									<div class="item ">
										<img src="/Images/AdaptBackground.png" alt="">
										<div class="carousel-caption">
											<marquee direction="down" behavior="alternate"
												scrolldelay="1000" style="width: 500px; height: 375px;">
												<h1>About Adaptavant</h1>
												<h4>People-powered success</h4>
												<p style="text-align: justify">Adaptavant is a
													high-energy environment driven by talented people
													passionate about their work. We partner with international
													operations in Australia, North America, Asia, and Europe to
													tackle complex business issues and navigate new markets.</p>
												<h4>Change through Innovation</h4>
												<p style="text-align: justify">We seek to change the
													world through innovation. Our team is open to new ideas
													with the potential to expand market share, improve
													profitability, or streamline oper- ations. Innovations in
													thought, products, and processes excite us. Flexibility
													enables our global management team to view challenges and
													opportunities from a fresh perspective.</p>
												<p style="text-align: justify">Adaptavant India is
													located within the Ascendas Pinnacle Building, Internatonal
													Tech Park, Chennai.</p>
											</marquee>
										</div>
									</div>
									<div class="item">
										<img src="/Images/AdaptBackground.png" alt="">
										<div class="carousel-caption">
											<marquee direction="down" behavior="alternate"
												scrolldelay="1000" style="width: 500px; height: 375px;">
												<h1>Contact</h1>
												<p>ADAPTAVANT INDIA Ascendas Phase 1, 4th Floor,
													Pinnacle Building, International Tech Park, Taramani Road,
													Taramani, Chennai - 600113 India +91.44.42666652</p>
												<p>ADAPTAVANT USA Portland, Oregon 1.800.595.6534</p>
												<h4>EMAIL</h4>
												<p>info@adaptavant.com</p>
												<h4>NEED HELP ON A PROJECT?</h4>
												<p>sales@adaptavant.com</p>
											</marquee>
										</div>
									</div>

								</div>

								<!-- Controls -->
								<a class="left carousel-control" href="#carousel"
									data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left"></span>
								</a> <a class="right carousel-control" href="#carousel"
									data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</div>
							<!-- End of Image Display -->

							<!-- Profile Settings  -->
							<div id="profileSettings" style="display: none;">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#profileInformation"
										data-toggle="tab">Profile Information</a></li>
								</ul>
								<div class="tab-content">
									<!-- Change Profile Information -->
									<div class="tab-pane active" id="profileInformation">
										<h3 align="center">Profile Information</h3>
										<hr>
										<form class="form-horizontal" role="form" method="post" 
										style="margin-left: 100px;">
										<input type="hidden" id="updateProfilePassword" value="<%=session.getAttribute("EmailId")%>" >
											<div class="form-group">
												<label class="col-sm-2 control-label">Password</label>
												<div class="col-sm-4">
													<input type="password" class="form-control" name="Password"
														id="pass" placeholder="Password"
														value="<%=session.getAttribute("Password")%>" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label">ReTypePassword</label>
												<div class="col-sm-4">
													<input type="password" class="form-control"
														name="ReTypePassword" placeholder="Password"
														id="rePass" value="<%=session.getAttribute("Password")%>"
														onblur="passCheck()" />
												</div>
											</div>
											<hr>
											<div class="form-group">
												<div class="col-sm-offset-3 col-sm-6">
													<button type="button" id="updatePass" class="btn btn-default" onclick="updatePassword()">Update</button>
													<button type="reset" class="btn btn-default">Reset</button>
												</div>
											</div>
											<hr>
										</form>
									</div>
								</div>
							</div>
							<!-- End of Profile Settings  -->
							<!-- Leave Information -->
							<div id="leaveInfo" style="display: none;">
								<!-- Nav tabs -->
								<ul class="nav nav-tabs">
									<li class="active"><a href="#leaveSummary"
										data-toggle="tab">LeaveSummary</a></li>

									<li><a href="#leaveRequest" data-toggle="tab">LeaveRequest</a></li>

									<%
										if (session.getAttribute("role").equals("TeamLeader")
												|| session.getAttribute("role").equals("Administrator")) {
									%>
									<li><a href="#pendingLeaveRequest" data-toggle="tab">PendingLeaveRequest</a></li>
									<%
										}
									%>
									<li><a href="#leaveHistory" data-toggle="tab">LeaveHistory</a></li>
								</ul>

								<!-- Leaves Tab panes -->
								<div class="tab-content">

									<!-- Leave Summary -->
									<div class="tab-pane active" id="leaveSummary">

										<h3 align="center">Leave Summary</h3>
										<form class="form-horizontal" role="form">

											<table class="table ">
												<tr>
													<th>LeaveType</th>
													<th>MaximumAllowedLeaves</th>
													<th>LeavesTaken</th>
													<th>LeavesRemaining</th>
												</tr>
												<tr>
													<td>SickLeave</td>
													<td>1</td>
													<td><%=session.getAttribute("SickLeave") %></td>
													<td>1</td>
												</tr>
												<tr>
													<td>CasualLeave</td>
													<td>1</td>
													<td><%=session.getAttribute("CasualLeave") %></td>
													<td>1</td>
												</tr>
												<tr>
													<td>PrivilegeLeave</td>
													<td>15</td>
													<td><%=session.getAttribute("PrivilegeLeave") %></td>
													<td>15</td>
												</tr>
												<tr>
													<td>LossOfPay</td>
													<td>0</td>
													<td><%=session.getAttribute("OtherLeave") %></td>
													<td>0</td>
												</tr>
											</table>
										</form>
									</div>
									<!--  End of Leave Summary -->
									<!-- Leave History -->
									<div class="tab-pane fade " id="leaveHistory" >
										<h3 align="center">Leave History</h3>

										<form class="form-horizontal" role="form" method="post">
											<%
												if (session.getAttribute("role").equals("TeamLeader")
														|| session.getAttribute("role").equals("Administrator")) {
											%>
											<hr>
											<div class="form-group" >
												<label class="col-sm-2 control-label">Department</label>
												<div class="col-sm-3" >
													<select class="form-control" id="departments">
														<option>AccountManagement</option>
														<option>BusinessSupport</option>
														<option>ContentWriting</option>
														<option>Designing</option>
														<option>Developement</option>
														<option>Financial</option>
														<option>HumanResources</option>
														<option>InformationTechnology</option>
														<option>OpsTeam</option>
														<option>Performance</option>
														<option>QualityAssurance</option>
														<option>Testing</option>
													</select>
												</div>
												<label class="col-sm-1 control-label">EmailId</label>
												<div class="col-sm-4" >
													<input type="text" class="form-control" name="EmailId"
														id="email" placeholder="EmailId" />
												</div>
												<div class="col-sm-1">
													<button type="button" class="btn btn-default"
														onclick="leaveHistory()">Search</button>
												</div>
												<div class="col-sm-1">
													<button type="reset" class="btn btn-default">Reset</button>
												</div>
											</div>
											<hr>
											<%
												}
											%>

											<div class="table-responsive" id="leavesHistoryTable" >

												<div class="form-group" >
													<table class="table ">
														<tr>
															<th>NameOfApplicant</th>
															<th>Team</th>
															<th>Role</th>
															<th>LeaveFrom</th>
															<th>LeaveTo</th>
															<th>AppliedDate</th>
															<th>Status</th>

														</tr>
														<c:forEach items="${LeavesTaken}" var="leavesHistory">
															<tr>
																<td>${leavesHistory.nameOfApplicant}</td>
																<td>${leavesHistory.team}</td>
																<td>${leavesHistory.role}</td>
																<td>${leavesHistory.leaveFrom}</td>
																<td>${leavesHistory.leaveTo}</td>
																<td>${leavesHistory.appliedDate}</td>
																<td>${leavesHistory.status}</td>
															</tr>
														</c:forEach>
													</table>
												</div>
											</div>
										</form>


									</div>
									<!-- End of Leave History -->
									<!-- Leave Request -->
									<div class="tab-pane fade " id="leaveRequest">

										<h3 align="center">Leave Request Form</h3>
										<hr>
										<form class="form-horizontal" role="form" method="post"	style=" margin-left: 100px;">

											<div class="form-group">
												<label class="col-sm-3 control-label">EmployeeName</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="30"
														placeholder="Krish" name="EmployeeName" type="text"
														id="employeeName"
														value="<%=session.getAttribute("EmployeeName")%>" required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">Role</label>
												<div class="col-sm-4">
													<input class="form-control" type="text" name="Role"
														id="role" placeholder="JuniorSoftwareEngineer"
														value="<%=session.getAttribute("role")%>" required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">Team</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="30"
														placeholder="Developers"
														value="<%=session.getAttribute("Team")%>" name="Team"
														type="text" id="team" required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">EmailId</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="30"
														placeholder="abc@gmail.com" name="EmailId" type="email"
														id="emailId" value="<%=session.getAttribute("EmailId")%>"
														required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">LeaveFrom</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="10"
														placeholder="MM/dd/yyyy" name="LeaveFrom" type="date"
														id="leaveFrom" value="" required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">LeaveTo</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="10"
														placeholder="MM/dd/yyyy" name="LeaveTo" type="date"
														value="" id="leaveTo" required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">RequestDate</label>
												<div class="col-sm-4">
													<%
														Date today = new Date();
														SimpleDateFormat date = new SimpleDateFormat(
																"MM/dd/yyyy");														
													%>
													<input class="form-control" maxlength="10"
														placeholder="MM/dd/yyyy" value="<%=date.format(today)%>" name="RequestDate"
														type="text" id="requestDate" required >
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">TeamLeadMailId</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="30"
														value="<%=session.getAttribute("TeamLead")%>"
														name="EmailIdTo" type="text" id="emailIdTo" required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label">LeaveType</label>
												<div class="col-sm-9">
													<label class="checkbox-inline"> <input
														type="checkbox" id="sickLeave" value="SickLeave">
														SickLeave
													</label> <label class="checkbox-inline"> <input
														type="checkbox" id="casualLeave" value="CasualLeave">
														CasualLeave
													</label> <label class="checkbox-inline"> <input
														type="checkbox" id="privilegeLeave" value="PrivilegeLeave">
														PrivilegeLeave
													</label>
													<label class="checkbox-inline"> <input
														type="checkbox" id="otherLeave" value="OtherLeave">
														OtherLeave
													</label>													
												</div>
												<label style="color:red;">${Mail}</label>												
											</div>
											<hr>
											<div class="form-group">
												<div class="col-sm-offset-3 col-sm-5">
													<button type="button" class="btn btn-default"
														name="SendEmail" id="send" onclick="sendEmail()">SendEmail</button>
													<button type="reset" name="Reset" class="btn btn-default">Reset</button>
												</div>
											</div>
											<hr>
										</form>
									</div>
									<!-- End of Leave Request -->

									<!-- Pending Leave Request -->
									<div class="tab-pane fade " id="pendingLeaveRequest">

										<h3 align="center">Pending Leave Request</h3>
										
										<form class="form-horizontal" role="form" method="get">
											<hr>
											<div class="table-responsive" id="pendingLeavesTable">

												<div class="form-group">
													<table class="table ">
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
														<c:forEach items="${PendingLeaves}" var="LeaveList">
															<%
																++count;
															%>
															<input name="Email" type="hidden"
																value="${LeaveList.employeeEmailId}"
																id="email<%=count%>">
															<input name="Key" type="hidden" value="${LeaveList.key}"
																id="key<%=count%>">
															<tr>
																<td id="applicant<%=count%>">${LeaveList.nameOfApplicant}</td>
																<td id="team<%=count%>">${LeaveList.team}</td>
																<td id="role<%=count%>">${LeaveList.role}</td>
																<td id="leaveFrom<%=count%>">${LeaveList.leaveFrom}</td>
																<td id="leaveTo<%=count%>">${LeaveList.leaveTo}</td>
																<td id="appliedDate<%=count%>">${LeaveList.appliedDate}</td>
																<td><select class="form-control" name="Status"
																	id="status<%=count%>"
																	onchange="approvedStatus(this.id)">
																		<option value="Pending">Pending</option>
																		<option value="Approved">Approved</option>
																		<option value="Declined">Declined</option>
																</select></td>
															</tr>
														</c:forEach>
													</table>
												</div>
											</div>
										</form>

									</div>
									<!--End of Pending Leave Request -->
								</div>
								<!-- End of Leaves Tab panes -->
							</div>

							<!-- End of Leave Information -->
	
							<!-- Employee Information -->
							<div id="employeeInfo" style="display: none;">
								<!-- Nav tabs -->
								<ul class="nav nav-tabs">
									<li class="active"><a href="#Add" data-toggle="tab">Add
											Employee Details</a></li>
									<li><a href="#updateDelete" data-toggle="tab">Update/Delete
											Employee Details</a></li>
								</ul>

								<!-- Employees Tab panes -->
								<div class="tab-content">
									<!-- Add Employee -->
									<div class="tab-pane active" id="Add">

										<h3 align="center">Employee Form</h3>
										<hr>
										<form class="form-horizontal" role="form" method="POST"
											style="margin-left: 100px;">
											<div class="form-group">
												<label class="col-sm-2 control-label">EmployeeName</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="Gopal123"
														name="EmployeeName" type="text" id="aemployeeName" value=""
														required>

												</div>
												<label class="col-sm-2 control-label">EmployeeId</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="2013Adapt0003"
														name="EmployeeId" type="text" id="aemployeeId" value=""
														required>
												</div>
											</div>
											<div class="form-group"></div>
											<div class="form-group">
												<label class="col-sm-2 control-label">DateOfJoining</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="MM/DD/YYYY"
														name="DateOfJoining" type="date" value=""
														id="adateOfJoining" required>
												</div>
												<label class="col-sm-2 control-label">Address</label>
												<div class="col-sm-4">
													<textarea class="form-control" rows="3" id="aaddress"
														name="Address" placeholder="Address"
														style="resize: none; max-width: 300px; max-height: 100px;"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label">Team</label>
												<div class="col-sm-4">
													<select class="form-control" id="adepartment">
														<option>AccountManagement</option>
														<option>BusinessSupport</option>
														<option>ContentWriting</option>
														<option>Designing</option>
														<option>Developement</option>
														<option>Financial</option>
														<option>HumanResources</option>
														<option>InformationTechnology</option>
														<option>OpsTeam</option>
														<option>Performance</option>
														<option>QualityAssurance</option>
														<option>Testing</option>
													</select>
												</div>
												<label class="col-sm-2 control-label">Role</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="SoftwareEngineer"
														value="" name="Role" type="text" id="arole" required>
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-2 control-label">EmailId</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="Gopal88@gmail.com"
														name="EmailId" type="email" id="aemailId" value="" required>
												</div>
												<label class="col-sm-2 control-label">MobileNo</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="+919911223344"
														name="MobileNo" type="text" id="amobileNo" value=""
														required>
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-2 control-label">Password</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="10"
														placeholder="Abc@123" value="" name="Password" size="20"
														type="password" id="apassword" required>
												</div>
												<label class="col-sm-2 control-label">ReTypePassword</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="10"
														placeholder="Abc@123" value="" name="ReTypePassword"
														size="20" type="password" id="areTypePassword"
														onBlur="passwordCheck()" required>
												</div>
											</div>

											<hr>
											<div class="form-group">
												<div class="col-sm-offset-4 col-sm-4">
													<button type="button" class="btn btn-default"
														name="Registration" id="register" onclick="addEmployee()">Register</button>
													<button type="reset" class="btn btn-default">Reset</button>
												</div>
											</div>
											<hr>
										</form>
									</div>
									<!-- End of Add Employee -->

									<!-- Update/Delete Employee -->

									<div class="tab-pane fade " id="updateDelete">
										<h3 align="center">Update/Delete Employee Record</h3>
										<hr>
										<form class="form-horizontal" role="form" method="GET"
											style="margin-left: 100px">
											<div class="form-group">
												<label class="col-sm-1 control-label">Email</label>
												<div class="col-sm-4">
													<input type="text" class="form-control" name="EmailId" id="searchEmailId"
														placeholder="Email" />
												</div>
												<div class="col-sm-2">
													<button type="button" class="btn btn-default" id="search" onclick="searchEmployeeRecord()">Search</button>
												</div>
												<div class="col-sm-2">
												<button type="button" class="btn btn-default" name="Delete"
														id="delete" onclick="deleteEmployeeRecord()">Delete</button>
												</div>
												<div class="col-sm-1">
													<button type="reset" class="btn btn-default">Reset</button>
												</div>
												
											</div>
										</form>
										<form class="form-horizontal" role="form" method="POST"
											style="margin-left: 100px">
											<hr>
											<div class="form-group">
												<label class="col-sm-2 control-label">EmployeeName</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="Gopal123"
														name="EmployeeName" type="text" id="EmployeeName" value=""
														required>

												</div>
												<label class="col-sm-2 control-label">EmployeeId</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="2013Adapt0003"
														name="EmployeeId" type="text" id="EmployeeId" value=""
														required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label">DateOfJoining</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="MM/DD/YYYY"
														name="DateOfJoining" type="date" value=""
														id="DateOfJoining" required>
												</div>
												<label class="col-sm-2 control-label">Address</label>
												<div class="col-sm-4">
													<textarea class="form-control" rows="3" id="Address"
														name="Address" placeholder="Address"
														style="resize: none; max-width: 300px; max-height: 100px;"></textarea>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label">Team</label>
												<div class="col-sm-4">
													<select class="form-control" id="Department">
														<option>AccountManagement</option>
														<option>BusinessSupport</option>
														<option>ContentWriting</option>
														<option>Designing</option>
														<option>Developement</option>
														<option>Financial</option>
														<option>HumanResources</option>
														<option>InformationTechnology</option>
														<option>OpsTeam</option>
														<option>Performance</option>
														<option>QualityAssurance</option>
														<option>Testing</option>
													</select>
												</div>
												<label class="col-sm-2 control-label">Role</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="SoftwareEngineer"
														value="" name="Role" type="text" id="Role" required>
												</div>
											</div>

											<div class="form-group">
												<label class="col-sm-2 control-label">EmailId</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="Gopal88@gmail.com"
														name="EmailId" type="email" id="EmailId" value="" required>
												</div>
												<label class="col-sm-2 control-label">MobileNo</label>
												<div class="col-sm-4">
													<input class="form-control" placeholder="+919911223344"
														name="MobileNo" type="text" id="MobileNo" value=""
														required>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label">Password</label>
												<div class="col-sm-4">
													<input class="form-control" maxlength="10"
														placeholder="Abc@123" value="" name="Password" size="20"
														type="password" id="Password" required>
												</div>
											</div>
											<hr>
											<div class="form-group">
												<div class="col-sm-offset-4 col-sm-5">
													<button type="button" class="btn btn-default" name="Update"
														id="update" onclick="updateEmployee()">Update</button>													
													<button type="reset" class="btn btn-default">Reset</button>
												</div>
											</div>
											<hr>
										</form>

									</div>
									<!-- End of Update/Delete Employee -->
								</div>
								<!-- End of Employees Tab Pane -->
							</div>
							<!-- End of Employee Information -->

							<!--User Profile -->
							<div id="userProfileInfo" style="display: none;">
								<h3 align="center">Profile Information</h3>
								<hr>
								<form class="form-horizontal" role="form">
									<h3 align="right"><%=session.getAttribute("EmployeeName")%></h3>
									<hr>
									<div class="form-group">
										<label class="col-sm-2 control-label">DateOfJoining</label>
										<div class="col-sm-5">
											<h5><%=session.getAttribute("EmployeeDoj")%></h5>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">CompanyName</label>
										<div class="col-sm-5">
											<h5><%=session.getAttribute("CompanyName")%></h5>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">Employeeid</label>
										<div class="col-sm-5">
											<h5><%=session.getAttribute("EmployeeId")%></h5>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">Emailid</label>
										<div class="col-sm-5">
											<h5><%=session.getAttribute("EmailId")%></h5>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">MobileNo</label>
										<div class="col-sm-5">
											<h5><%=session.getAttribute("MobileNo")%></h5>
										</div>
									</div>
								</form>
							</div>
							<!-- End of User Profile -->
						</div>
					</div>
					<!--End of Column Right -->
				</div>
				<!-- End of the Row -->
			</div>
		</div>
		<!-- End of the Row -->
		<!--  Footer Navigation  -->
		<nav class="navbar  navbar-fixed-bottom" role="navigation">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="footer">
						<p class="navbar-text pull-right">
							<img src="/Images/Logo.png" alt=" " class="img-rounded"
								style="height: 50px; width: 50px;" />� Adaptavant Inc.
						</p>
					</div>
				</div>
			</div>
		</nav>

		<!--  End of Footer -->
	</div>
	<!-- End of Div Container -->
</body>
</html>
