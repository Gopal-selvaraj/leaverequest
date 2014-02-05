<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	/* /* /* /* /* function get(){
	 var row=document.getElementsByTagName('TR');
	 alert(row.length-1);
	 for(var i=1;i<=row.length-1;i++){
	 if(row[i])
	 }
	 }
	 function checkAll() {		
	 var count = 0;
	
	 var check = document.getElementById("checkall").checked;
	 if (check) {			
	 document.getElementById('check[1]').checked = true;
	 Check();
	 } else {
	 document.getElementById('status[1]').selectedIndex = 0;
	 document.getElementById('status[1]').disabled = true;
	 document.getElementById('update[1]').disabled=true;
	 document.getElementById('check[1]').checked = false;
	 }
	 } */
	//var one=document.getElementById('status').selectedIndex;
	//alert(one); */ */ */ */
	function Check() {

		/* var today=new Date();
		var day=today.getDate();
		var month=today.getMonth()+1;
		var year=today.getFullYear();
		var todayDate=year+"-"+month+"-"+day; */
		var row = document.getElementsByTagName('TR').length;

		for (var count = 1; count < row; count++) {

			var status = "status" + count;
			var update = "update" + count;
			var check = "check" + count;
			var deleteId = "del" + count;
			var approvedDate = "approvedDate" + count;
			var tableId = "tableView";
			var checked = document.getElementById(check).checked;

			if (checked) {
				document.getElementById(status).selectedIndex = 1;
				document.getElementById(update).disabled = false;
				document.getElementById(status).disabled = false;
				document.getElementById(deleteId).disabled = false;
				document.getElementById(approvedDate).disabled = false
				//var del=deleteRow(tableId);
				//alert(del);
				/*  document.getElementById(approvedDate).value=todayDate;*/

			} else {
				document.getElementById(status).selectedIndex = 0;
				document.getElementById(status).disabled = true;
				document.getElementById(update).disabled = true;
				document.getElementById(deleteId).disabled = true;
				document.getElementById(approvedDate).disabled = true;
			}
		}
	}
	/* 	  function update(){
	 var request;
	 function updateCalled() {
	
	 var employeeName=encodeURIComponent(document.getElementById("employeeName").value);
	 var emailId=encodeURIComponent(document.getElementById("emailId").value);
	 var approvedDate=encodeURIComponent(document.getElementById("approvedDate").value);
	 var appliedDate=encodeURIComponent(document.getElementById("appliedDate").value);
	 var emailIdTo = encodeURIComponent(document.getElementById("emailIdTo").value);
	 var status	=encodeURIComponent(document.getElementById("status").value);
	 var team=${LeaveList.team};
	 var parameters="employeeName="+employeeName+"&emailId="+emailId+"&approvedDate="+approvedDate+"&appliedDate="+appliedDate+
	 "&emailIdTo="+emailIdTo+"&status="+status;
	
	 //var url = "/updateServlet";
	
	 if (window.XMLHttpRequest) {
	 request = new XMLHttpRequest();
	 } else if (window.ActiveXObject) {
	 request = new ActiveXObject("MicroSoft.XMLHTTP");
	 }
	 try {
	 request.onreadystatechange = retrieveData;
	 request.open("POST", '/updateStatus' , true);
	 request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	 request.send(parameters);
	 } catch (e) {
	 alert("Unable to connect server");
	 }
	 }
	 function retrieveData() {
	 if (request.readyState == 4 && request.status == 200) {
	 //	var JSONObject = JSON.parse(request.responseText);
	 alert("Mail Sent Successfully");
	 //document.getElementById("form1").innerHTML = val;
	 /* document.getElementById("userName").value =JSONObject.userName ;
	 document.getElementById("userId").value=JSONObject.userId ;
	 document.getElementById("dateOfBirth").value = JSONObject.dateOfBirth;
	 document.getElementById("dateOfRegistration").value =JSONObject.dateOfRegistration ;
	 document.getElementById("companyName").value =JSONObject.companyName ;
	 document.getElementById("emailId").value =JSONObject.emailId ;
	 document.getElementById("mobileNo").value = JSONObject.mobileNo;
	 document.getElementById("password").value = JSONObject.password; */

	//	}
	//	}
	//} 
	function deleteRow(tableID) {
		try {
			var table = document.getElementById(tableID);
			var rowCount = table.rows.length;

			for (var i = 0; i < rowCount; i++) {
				var row = table.rows[i];
				var chkbox = row.cells[0].childNodes[0];
				if (null != chkbox && true == chkbox.checked) {
					table.deleteRow(i);
					rowCount--;
					i--;
				}

			}
		} catch (e) {
			alert(e);
		}
		//return "Deleted"
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
			<!--${fn:length(Leave)}   -->
			<br />
			<table border="1"
				style="margin-top: 20px; margin-left: 80px; text-align: left; padding: 5px; border-spacing: 5px"
				id="tableView">

				<tr>
					<th>App/Dec</th>
					<th>ApprovedBy</th>
					<th>NameOfApplicant</th>
					<th>Team</th>
					<th>Role</th>
					<th>LeaveFrom</th>
					<th>LeaveTo</th>
					<th>AppliedDate</th>
					<th>ApprovedDate</th>
					<th>Status</th>
					<th>Update</th>
				</tr>
				<%
					int count = 0;
				%>
				<c:forEach items="${Leave}" var="LeaveList">

					<%
						count = count + 1;
					%>
					<tr>
						<td><input name="checkbox" type="checkbox"
							id="check<%=count%>" onclick="Check()"></td>

						<td>${LeaveList.nameOfPoc}</td>
						<td>${LeaveList.nameOfApplicant}</td>
						<td>${LeaveList.team}</td>
						<td>${LeaveList.role}</td>
						<td>${LeaveList.leaveFrom}</td>
						<td>${LeaveList.leaveTo}</td>
						<td>${LeaveList.appliedDate}</td>
						<td><input style="width: 130px" type="date"
							value="${LeaveList.approvedDate}" id="approvedDate<%=count%>"
							disabled></td>
						<td><select name="status" id="status<%=count%>" disabled>
								<option>Pending</option>
								<option>Approved</option>
								<option>Declined</option>
						</select></td>
						<td><input type="button" name="Update" value="Update"
							id="update<%=count%>" onclick="update()" disabled /></td>
						 <td><input type="button" name="Delete" value="Delete"
							id="del<%=count%>" onclick="deleteRow('tableView')" disabled /></td>
					</tr> 
				</c:forEach>
			</table>
		</div>

	</form>

</body>
</html>
