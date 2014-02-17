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
<script src="http://code.jquery.com/jquery.js"></script>
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
	function loginAuthentication() {
		var emailId = document.getElementById("emailId").value;
		var password = document.getElementById("password").value;
		var parameters = "EmailId=" + emailId + "&Password=" + password;
		if (window.XMLHttpRequest) {
			request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			request = new ActiveXObject("MicroSoft.XMLHTTP");
		}
		try {
			request.onreadystatechange = retrieveData();
			request.open("POST", '/LoginAuth.com', true);
			request.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			request.send(parameters);
		} catch (e) {
			alert("Unable to connect server");
		}
	}

	function retrieveData() {
		if (request.readyState == 4 && request.status == 200) {
			var Message = ${model};
		}
	}
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
									style="align: center; margin-left: 10px; margin-top: 150px">
									<div id="carousel-example-generic" class="carousel slide"
										data-ride="carousel">
										<!-- Indicators -->
										<ol class="carousel-indicators">
											<li data-target="#carousel-example-generic" data-slide-to="0"
												class="active"></li>
											<li data-target="#carousel-example-generic" data-slide-to="1"></li>
											<li data-target="#carousel-example-generic" data-slide-to="2"></li>
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
															passionate about their work. We partner with
															international operations in Australia, North America,
															Asia, and Europe to tackle complex business issues and
															navigate new markets.</p>
														<h4>Change through Innovation</h4>
														<p style="text-align: justify">We seek to change the
															world through innovation. Our team is open to new ideas
															with the potential to expand market share, improve
															profitability, or streamline oper- ations. Innovations in
															thought, products, and processes excite us. Flexibility
															enables our global management team to view challenges and
															opportunities from a fresh perspective.</p>
														<p style="text-align: justify">Adaptavant India is
															located within the Ascendas Pinnacle Building,
															Internatonal Tech Park, Chennai.</p>
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
															Pinnacle Building, International Tech Park, Taramani
															Road, Taramani, Chennai - 600113 India +91.44.42666652</p>
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
										<a class="left carousel-control"
											href="#carousel-example-generic" data-slide="prev"> <span
											class="glyphicon glyphicon-chevron-left"></span>
										</a> <a class="right carousel-control"
											href="#carousel-example-generic" data-slide="next"> <span
											class="glyphicon glyphicon-chevron-right"></span>
										</a>
									</div>
								</div>
								<!--/.fluid-container-->
							</div>
							<!-- Column Left  -->
							<div class="col-md-2 column">
								<div class="span9"
									style="align: center; margin-left: -120px; margin-top: 300px">
									<div class="modal-body">
										<form class="form-horizontal" role="form"
											action="/Loginauth.com" method="post">
											<div class="form-group">
												<label class="col-sm-1 control-label">EmailId</label>
												<div class="col-sm-4">
													<input type="text" class="form-control" name="EmailId"
														placeholder="EmailId" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-1 control-label">Password</label>
												<div class="col-sm-4">
													<input type="password" class="form-control" name="Password"
														placeholder="Password" />
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-offset-1 col-sm-4">
													<div class="checkbox">
														<label><input type="checkbox" /> Remember me </label>
													</div>
													<label style="color:red;">${model}</label>
												</div>
											</div>
											<div class="form-group">
												<div class="col-sm-offset-1 col-sm-8">
													<button type="submit" class="btn btn-default">Login</button>
													<button type="reset" class="btn btn-default">Reset</button>
												</div>
											</div>
										</form>
									</div>

								</div>


							</div>
							<!-- End of Column Left -->
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
									style="height: 50px; width: 50px;" />� Adaptavant Inc.
							</p>
						</div>
					</div>
				</div>
			</nav>
		</div>
</div>

		
</body>
</html>
