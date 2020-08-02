This was an exercise in Java back-end development. (Hence the lacking visuals).

It is a "car parts shop" themed web application that allows users to place orders to a database.
Users can view and search for products in the database. Once they have
decided which product they would like to purchase, they can place an order using the order form.

The site also has an interface to manage all placed orders. This is a login restricted area
that only "admins" with a valid login are supposed to be able to access.

The application is built of Java servlets, JSP-s, Beans and POJOs.
It (obviously) is also connected to a database (MySQL).
The application takes advantage of prepared statements and parameterized queries
to prevent SQL injection attacks.

The application also offers a simple SOAP webservice to enable clients
to place orders programmatically.
