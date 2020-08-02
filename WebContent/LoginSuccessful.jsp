<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Orders List</title>
<link rel="stylesheet" type="text/css" href="Style.css">
<style type="text/css">

#ordersTable {
  border-collapse: collapse;
  margin: 0 auto;
  margin-bottom: 10px;
}
#ordersTable, #ordersTable th, #ordersTable td {
  border: 1px solid black;
}
#ordersTable th {background-color:#dae8fc; padding: 5px;}
#ordersTable td {background-color:white;text-align:left;padding: 5px;}

</style>

<script>
   function submitForm(x){
	   document.getElementById('action').value=x.id;
	   document.forms[1].submit();
   }
</script>

</head>
<body>

<jsp:useBean id="user" class="Beans.UserBean" scope="session"></jsp:useBean>

<%
java.sql.PreparedStatement stmt;

java.sql.Connection connection;

try {
	//Load database driver
	Class.forName("com.mysql.cj.jdbc.Driver");
} catch (ClassNotFoundException e) {
	request.setAttribute("message", "Can't load database driver.");
	request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
}

//Set up a database conenction
connection = null;
try {
	connection = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/carpartsdatabase?&serverTimezone=UTC", "root", "password");
} catch (java.sql.SQLException e) {
	request.setAttribute("message","Can't connect to database: " + e.getMessage());
	request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
}

String action = request.getParameter("action");

//Log out if they have clicked logout button
if (action!=null && action.equals("logout")) {
	user.setAdminName("");
	user.setPassword("");
}

//Execute user's database action (if any)
if (action!=null && action.matches("Delete[0-9]+")) {
	String sql = "DELETE FROM orders WHERE OrderID=" + action.substring(6);
	stmt = connection.prepareStatement(sql);
	stmt.executeUpdate();
	stmt.close();
} else if (action!=null && action.matches("Dispatch[0-9]+")) {
	String sql = "UPDATE orders SET Dispatched=TRUE WHERE OrderID=" + action.substring(8);
	stmt = connection.prepareStatement(sql);
	stmt.executeUpdate();
	stmt.close();
}

connection.close();
%>

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

<%
if(user.getAdminName()!=null && user.getAdminName()!="") {
%>

<div class="search-box">
<form action="/MailOrderApplication/LoginSuccessful.jsp" method="post">
<label for="Search">Search Order ID:</label>
<input type="text" id="Search" name="Search"/>
<input type="submit" value="Go"/>
</form>
</div>

<button type="button" id = "logout" class="button" onclick="submitForm(this)">
<img src="img/logout.png" height="35px" width="35px"/>
<div>
Log Out
</div>

</button>

<p style="font-size:2rem; color: white; display: box; background-color: #FFA500; margin:0px auto 10px auto; width:20%; text-align:center;">Orders</p>

<table id="ordersTable">
  <tr>
 	<th>Order ID</th>
    <th>Item number</th>
    <th >Amount</th>
    <th>First name</th>
    <th>Last name</th>
    <th>Email address</th>
    <th>Postcode</th>
    <th>Street address</th>
    <th>City</th>
    <th>County</th>
    <th>Manage</th>
  </tr>
 
<%

java.sql.PreparedStatement stmt2;
java.sql.Connection connection2;

//Set up new database conenction
connection2 = null;
try {
	connection2 = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/carpartsdatabase?&serverTimezone=UTC", "root", "password");
} catch (java.sql.SQLException e) {
	request.setAttribute("message","Can't connect to database: " + e.getMessage());
	request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
}

//Set up statement based on what the user searched for (if nothing then display all orders)
	
java.sql.ResultSet resultSet;
String sql = "";
if (request.getParameter("Search")!=null && request.getParameter("Search")!="") {
	
	sql = "SELECT * FROM orders WHERE OrderID=?;";
	stmt2 = connection2.prepareStatement(sql);
	stmt2.setString(1, request.getParameter("Search"));//avoids SQL injection
} else {
	sql = "SELECT * FROM orders";
	stmt2 = connection2.prepareStatement(sql);
}
resultSet = stmt2.executeQuery();

while (resultSet.next()) {
%>
<tr>
  <td><%=resultSet.getString(1)%></td>
  <td><%=resultSet.getString(2)%></td>
  <td><%=resultSet.getString(3)%></td>
  <td><%=resultSet.getString(4)%></td>
  <td><%=resultSet.getString(5)%></td>
  <td><%=resultSet.getString(6)%></td>
  <td><%=resultSet.getString(7)%></td>
  <td><%=resultSet.getString(8)%></td>
  <td><%=resultSet.getString(9)%></td>
  <td><%=resultSet.getString(10)%></td>
  <td>
  <%
  if (resultSet.getString(11).equals("0")) {
	  //if order is not dispatched yet, show dispatch button
  %>
  	<button type="button" id = "Dispatch<%=resultSet.getString(1)%>" onclick="submitForm(this)">Dispatch</button>
  	<button type="button" id = "Delete<%=resultSet.getString(1)%>" onclick="submitForm(this)">Delete</button>
  <%} else {
  	//if order is already dispatched, only show delete button
  %>
	  <p style="color:Green;font-weight: bold;">OUT FOR DELIVERY</p>
	  <button type="button" id = "Delete<%=resultSet.getString(1)%>" onclick="submitForm(this)">Delete</button>
  <%}%>
  </td>
</tr>
<%
}
connection2.close();
resultSet.close();
stmt2.close();
 %>
</table>

<form action="/MailOrderApplication/LoginSuccessful.jsp" method="post">
<input type='hidden' id='action'  name='action'>
</form>

<%

} else {%>

<div class=infoBox>
<p>You are logged out!</p>
</div>
<%
}
%>

<div style="margin-bottom:130px"></div>
<footer>
<p>Posted by: Daniele Palazzo</p>
<p>Copyright &copy; 2020 Daniele Palazzo</p>
</footer>

</body>
</html>