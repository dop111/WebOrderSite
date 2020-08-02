<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error</title>

<link rel="stylesheet" type="text/css" href="Style.css">

<style type="text/css">
#ErrorBox {
position: absolute;
top: 50%;
left: 50%;
margin-top: -110px;
margin-left: -260px;
width: 500px;
height: 200px;
background-color: orange;
opacity: .9;
padding:20px;
}
</style>

</head>
<body>

<div id="ErrorBox">
<img src="img/Error.png" width="200" height="200" style="float:left"></img>
<p style="font-size:2rem; color:red;">Error!</p>
<p><%
//display the error message of the forwarding page
if (request.getAttribute("message")!= null) { %>
<p style="color: red; font-size: 1.25rem;"><%= request.getAttribute("message") %></p>

<%} else {}%>
</p>
</div>

</body>
</html>