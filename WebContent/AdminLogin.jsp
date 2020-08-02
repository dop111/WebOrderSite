<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login</title>
<link rel="stylesheet" type="text/css" href="Style.css">

<style type="text/css">
#loginTable {
border:0;
margin: auto;
font-size: 1.2rem;
}

#loginTable td {
padding: 10px;
}
</style>
</head>
<body>

<header>
	<img src="img/header.png"/>
</header>

<ul>
  <li><a href="/MailOrderApplication/Order.jsp">Order Form</a></li>
  <li><a href="/MailOrderApplication/ItemCatalogue.jsp">Item Catalogue</a></li>
  <li><a href="/MailOrderApplication/Contact.html">Contact</a></li>
  <li><a href="/MailOrderApplication/AdminLogin.jsp" class="active">Admin Area</a></li>
  <li style="float:right"><a href="/MailOrderApplication/About.html">About</a></li>
</ul>

<div class="infoBox">

<jsp:useBean id="user" class="Beans.UserBean" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="user"></jsp:setProperty>

<%
	String action = request.getParameter("action");
	String message = (request.getAttribute("message")!=null)?request.getAttribute("message").toString():null;

	//if the form was submitted go to LoginController (which might return a message that will be displayed on this page)
	if (action!=null && action.equals("submitted") && message==null) {
		request.getRequestDispatcher("/LoginController").forward(
				request,response);
		return;
	}
%>

<form action="/MailOrderApplication/AdminLogin.jsp" method="post">
<input type="hidden" name="action" value="submitted"/>
<table id="loginTable">
<tr>
	<td><label for="adminName">Admin Name:</label></td>
	<td><input type="text" id="adminName" name="adminName" required/></td>
</tr>
<tr>
	<td><label for="password">Password:</label></td>
	<td><input type="password" id="password" name="password" required/></td>
</tr>
</table>

<div style="text-align: center;">
<input type="submit" value="Log In" style="width: 100px; height: 25px;"/><br/>
</div>

<%
//if there is an error message (from LoginController) then reset bean - login is invalid
if (request.getAttribute("message")!= null) { 
	user.setAdminName("");
	user.setPassword("");
	//show error message
%>
	<p style="color: red; font-size: 1.25rem;"><%= request.getAttribute("message") %></p>
	
<%
//go to login restricted page (in case they navigate to this page manually when they are logged in)
} else if (user.getAdminName()!=null && user.getAdminName()!="" ) {
	request.getRequestDispatcher("/LoginSuccessful.jsp").forward(request,response);
}%>

</form>

</div>

<div style="margin-bottom:130px"></div>
<footer>
<p>Posted by: Daniele Palazzo</p>
<p>Copyright &copy; 2020 Daniele Palazzo</p>
</footer>

</body>
</html>