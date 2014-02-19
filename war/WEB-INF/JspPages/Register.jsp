<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>Home Page</title>
<%
	if (session.getAttribute("EmployeeName") != null
			|| session.getAttribute("EmployeeName") != "") {
		session.invalidate();
		response.setHeader("Cache-Control",
				"no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	}
%>

<script type="text/javascript">
	
var request;
</script>

</head>
<body>

	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div class="row clearfix">
					<div class="col-md-12 column">
						<nav class="navbar navbar-default navbar-fixed-top"
							role="navigation">
							<div class="navbar-header">
								<button type="button" class="navbar-toggle"
									data-toggle="collapse"
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
						</nav>
					</div>
				</div>
				<div class="row center">
					<div class="col-md-12 column">
						<div class="row clearfix">

							<div class="col-md-10 column">
								<div class="span9"
									style="align: center; margin-left: 175px; margin-top: 150px">
									<h3 align="center">Employee Form</h3>

									<form class="form-horizontal" role="form" method="post"
										action ="/registration" style="margin-left: 100px;">
										<hr>
										<div class="form-group">
											<label class="col-sm-2 control-label">EmployeeName</label>
											<div class="col-sm-4">
												<input class="form-control" placeholder="Gopal123"
													name="EmployeeName" type="text" id="employeeName" value=""
													required>

											</div>
											<label class="col-sm-2 control-label">EmployeeId</label>
											<div class="col-sm-4">
												<input class="form-control" placeholder="2013Adapt0003"
													name="EmployeeId" type="text" id="employeeId" value=""
													required>
											</div>
										</div>
										<div class="form-group"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label">DateOfJoining</label>
											<div class="col-sm-4">
												<input class="form-control" placeholder="MM/DD/YYYY"
													name="DateOfJoining" type="date" value=""
													id="dateOfJoining" required>
											</div>
											<label class="col-sm-2 control-label">Address</label>
											<div class="col-sm-4">
												<textarea class="form-control" rows="3" id="address"
													name="Address" placeholder="Address"
													style="resize: none; max-width: 300px; max-height: 100px;"></textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">Team</label>
											<div class="col-sm-4">
												<input class="form-control" placeholder="Development"
													value="" name="Team" type="text" id="team" required>
											</div>
											<label class="col-sm-2 control-label">Role</label>
											<div class="col-sm-4">
												<input class="form-control" placeholder="SoftwareEngineer"
													value="" name="Role" type="text" id="role" required>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label">EmailId</label>
											<div class="col-sm-4">
												<input class="form-control" placeholder="Gopal88@gmail.com"
													name="EmailId" type="email" id="emailId" value="" required>
											</div>
											<label class="col-sm-2 control-label">MobileNo</label>
											<div class="col-sm-4">
												<input class="form-control" placeholder="+919911223344"
													name="MobileNo" type="text" id="mobileNo" value="" required>
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-2 control-label">Password</label>
											<div class="col-sm-4">
												<input class="form-control" maxlength="10"
													placeholder="Abc@123" value="" name="Password" size="20"
													type="password" id="password" required>
											</div>
											<label class="col-sm-2 control-label">ReTypePassword</label>
											<div class="col-sm-4">
												<input class="form-control" maxlength="10"
													placeholder="Abc@123" value="" name="ReTypePassword"
													size="20" type="password" id="reTypePassword"
													onBlur="passwordCheck()" required> 
											</div>
											<label style="color:red;">${model}</label>
										</div>

										<hr>
										<div class="form-group">
											<div class="col-sm-offset-4 col-sm-4">
												<button type="submit" class="btn btn-default"
													name="Registration">Register</button>
												<button type="reset" class="btn btn-default">Reset</button>
											</div>
										</div>
										<hr>
									</form>
								</div>
								<!--/.fluid-container-->
							</div>

						</div>
					</div>
				</div>
			</div>
			<nav class="navbar  navbar-fixed-bottom" role="navigation">
				<div class="row clearfix">
					<div class="col-md-12 column">
						<div class="footer">
							<p class="navbar-text pull-right">
								<img src="/Images/Logo.png" alt=" " class="img-rounded"
									style="height: 50px; width: 50px;" />© Adaptavant Inc.
							</p>
						</div>
					</div>
				</div>
			</nav>
		</div>
	</div>


</body>
</html>
