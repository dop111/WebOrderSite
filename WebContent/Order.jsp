<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Form</title>
<link rel="stylesheet" type="text/css" href="Style.css">
</head>
<body>

<header>
	<img src="img/header.png"/>
</header>

<ul>
  <li><a href="/MailOrderApplication/Order.jsp" class="active">Order Form</a></li>
  <li><a href="/MailOrderApplication/ItemCatalogue.jsp">Item Catalogue</a></li>
  <li><a href="/MailOrderApplication/Contact.html">Contact</a></li>
  <li><a href="/MailOrderApplication/AdminLogin.jsp">Admin Area</a></li>
  <li style="float:right"><a href="/MailOrderApplication/About.html">About</a></li>
</ul>

<div style="background-color:#FFA500; display:block; text-align:center; width: 50%; margin:auto; padding: 30px; opacity: 0.9;">
<p style="font-size:2rem; color: white; margin: 0">Order Form</p>
</div>

<div id="orderBox">
<form action="/MailOrderApplication/MailOrderController" method="post" style="font-size: 1.5rem;">

<fieldset>
<legend><strong>Item information</strong></legend>

<label for="ItemNumber">Item number:</label>
<input type="text" id="ItemNumber" name="ItemNumber" required/><br/>

<label for="Amount">Amount:</label>
<input type="number" id="Amount" name="Amount" min="1" max="10" value="1" required/><br/>

</fieldset>

<fieldset>
<legend><strong>Shipping information</strong></legend>
<label for="FirstName">First name:</label>
<input type="text" id="FirstName" name="FirstName" required/>

<label for="LastName">Last name:</label>
<input type="text" id="LastName" name="LastName" required/><br/>

<label for="EmailAddress">Email address: </label>
<input type="email" id="EmailAddress" name="EmailAddress" size="30" required/><br/>

<label for="Postcode">Postcode:       </label>
<input type="text" id="Postcode" name="Postcode" required/><br/>

<label for="StreetAddress">Street address:</label>
<input type="text" id="StreetAddress" name="StreetAddress" size="40" required/><br/>

<label for="City">City:           </label>
<input type="text" id="City" name="City" required/><br/>

<label for="County">County:</label>
<input type="text" id="County" name="County" list="Counties" required/><br/>

<datalist id="Counties">
    <option>Bedfordshire</option>
    <option>Berkshire</option>
    <option>Bristol</option>
    <option>Buckinghamshire</option>
    <option>Cambridgeshire</option>
    <option>Cheshire</option>
    <option>City of London</option>
    <option>Cornwall</option>
    <option>Cumbria</option>
    <option>Derbyshire</option>
    <option>Devon</option>
    <option>Dorset</option>
    <option>Durham</option>
    <option>East Riding of Yorkshire</option>
    <option>East Sussex</option>
    <option>Essex</option>
    <option>Gloucestershire</option>
    <option>Greater London</option>
    <option>Greater Manchester</option>
    <option>Hampshire</option>
    <option>Herefordshire</option>
    <option>Hertfordshire</option>
    <option>Isle of Wight</option>
    <option>Kent</option>
    <option>Lancashire</option>
    <option>Leicestershire</option>
    <option>Lincolnshire</option>
    <option>Merseyside</option>
    <option>Norfolk</option>
    <option>North Yorkshire</option>
    <option>Northamptonshire</option>
    <option>Northumberland</option>
    <option>Nottinghamshire</option>
    <option>Oxfordshire</option>
    <option>Rutland</option>
    <option>Shropshire</option>
    <option>Somerset</option>
    <option>South Yorkshire</option>
    <option>Staffordshire</option>
    <option>Suffolk</option>
    <option>Surrey</option>
    <option>Tyne and Wear</option>
    <option>Warwickshire</option>
    <option>West Midlands</option>
    <option>West Sussex</option>
    <option>West Yorkshire</option>
    <option>Wiltshire</option>
    <option>Worcestershire</option>
</datalist>

<div style="text-align: center;">
<input type="submit" value="Submit" style="width: 100px; height: 25px;"/><br/>
</div>
</fieldset>

<%
//display order feedback message (either with green or red colour)
if (request.getAttribute("message")!= null) { %>

	<p style="color: <%=(request.getAttribute("message")=="Order placed!")?"green":"red" %>; font-size: 1.25 rem;"><%= request.getAttribute("message") %></p>
	
<%} else {}%>
	
</form>

</div>

<div style="margin-bottom:130px"></div>
<footer>
<p>Posted by: Daniele Palazzo</p>
<p>Copyright &copy; 2020 Daniele Palazzo</p>
</footer>

</body>
</html>