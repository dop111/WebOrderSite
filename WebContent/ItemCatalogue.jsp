<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Item Catalogue</title>
<link rel="stylesheet" type="text/css" href="Style.css">
</head>
<body>

<header>
	<img src="img/header.png"/>
</header>

<ul>
  <li><a href="/MailOrderApplication/Order.jsp">Order Form</a></li>
  <li><a href="/MailOrderApplication/ItemCatalogue.jsp" class="active">Item Catalogue</a></li>
  <li><a href="/MailOrderApplication/Contact.html">Contact</a></li>
  <li><a href="/MailOrderApplication/AdminLogin.jsp">Admin Area</a></li>
  <li style="float:right"><a href="/MailOrderApplication/About.html">About</a></li>
</ul>

<div class="search-box">
<form action="/MailOrderApplication/ItemCatalogue.jsp" method="post">
<label for="Search">Search Item Name:</label>
<input type="text" id="Search" name="Search"/>
<input type="submit" value="Go"/>
</form>
</div>

<%
try {
	//Load database driver
	Class.forName("com.mysql.cj.jdbc.Driver");
} catch (ClassNotFoundException e) {
	request.setAttribute("message", "Can't load database driver.");
	request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
}

java.sql.Connection connection;

//Set up a connection to database
connection = null;
try {
	connection = java.sql.DriverManager.getConnection(
			"jdbc:mysql://localhost:3306/carpartsdatabase?&serverTimezone=UTC", 
			"root", "password");
} catch (java.sql.SQLException e) {
	request.setAttribute("message", "Can't connect to database. " + e.getMessage());
	request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
}

String sql = "";
java.sql.PreparedStatement stmt;

if (request.getParameter("Search")!=null && request.getParameter("Search")!="") {
	sql = "SELECT * FROM products WHERE ProductName LIKE ?;";
	stmt = connection.prepareStatement(sql); //set up statement
	stmt.setString(1, "%" + request.getParameter("Search") + "%");//avoids SQL injection
} else {
	sql = "SELECT * FROM products";
	stmt = connection.prepareStatement(sql); //set up statement
}

java.sql.ResultSet resultSet = stmt.executeQuery(); //execute query

//display results on website
while (resultSet.next()) {
%>
<div class="infoBox">
<strong>Item Number: </strong> <%=resultSet.getString(1)%><br/>

<strong>Product Name: </strong> <%=resultSet.getString(2)%><br/>

<strong>Description: </strong> <%=resultSet.getString(3)%><br/>

<strong>Price: </strong> <%="£"+resultSet.getString(4)%><br/>
</div>
<%
}
//close connection
resultSet.close();
stmt.close();
connection.close();
%>

<div style="margin-bottom:130px"></div>
<footer>
<p>Posted by: Daniele Palazzo</p>
<p>Copyright &copy; 2020 Daniele Palazzo</p>
</footer>

</body>
</html>