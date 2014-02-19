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
<title>Login Page</title>
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
									style="align: center; margin-left: 200px; margin-top: 100px">
									<h3 align="center">Login Form</h3><hr>
										<form class="form-horizontal" role="form"
											 method="post" action="/loginAuthentication"style="margin-top: 100px">
											<div class="form-group" style="margin-left: 250px">
												<label class="col-sm-2 control-label">EmailId</label>
												<div class="col-sm-5">
													<input type="text" class="form-control" name="EmailId"
														placeholder="EmailId" id="emailId"/>
												</div>
											</div>
											<div class="form-group" style="margin-left: 250px">
												<label class="col-sm-2 control-label">Password</label>
												<div class="col-sm-5">
													<input type="password" class="form-control" name="Password"
														placeholder="Password" id="password"/>
												</div>
											</div>
											<div class="form-group" style="margin-left: 250px">
												<div class="col-sm-offset-2 col-sm-5">
													<div class="checkbox">
														<label><input type="checkbox" /> Remember me </label>
													</div>
													<label style="color:red;">${model}</label>
												</div>
											</div>
											<hr><div class="form-group" style="margin-left: 250px">
												<div class="col-sm-offset-2 col-sm-8">
													<button type="submit" class="btn btn-default" >Login</button>
													<button type="reset" class="btn btn-default">Reset</button>
												</div>
											</div><hr>
										</form>
									

								</div>							
							<!-- End of Column Left -->
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

