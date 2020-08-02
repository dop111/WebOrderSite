package WebService;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * This class is for the SOAP web service. 
 * It allows users to programatically place an order or view the product catalouge
 * @author Daniele Palazzo
 *
 */
public class Service {
	
	/**
	 * Places an order to the database
	 * @param ItemNumber The identification number of the product that will be purchased
	 * @param Amount The quantity that is needed
	 * @param FirstName First name of the customer
	 * @param LastName Last name of the customer
	 * @param EmailAddress Email of the customer
	 * @param Postcode Postcode of the customer
	 * @param StreetAddress Street address of the customer
	 * @param City City of the customer
	 * @param County County of the customer
	 * @return Returns "Order placed!" or "Invalid Order!"
	 */
	public String placeOrder(int ItemNumber,int Amount,String FirstName,String LastName,String EmailAddress,String Postcode,String StreetAddress,String City,String County) {
		try {
			//Load database driver
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			return("Can't load database driver.");
		}
		
		Connection con = null;
		try {
			//Connect to the database
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpartsdatabase?&serverTimezone=UTC", "root", "password");
		} catch (SQLException e) {
			return("Can't connect to database. " + e.getMessage());
		}
		
		//Database Query
		String sql = "INSERT INTO orders (ItemNumber,Amount,FirstName,LastName,EmailAddress,Postcode,StreetAddress,City,County,Dispatched) "
				+ "VALUES ("+ItemNumber+","+Amount+",'"+FirstName+"','"+LastName+"','"+EmailAddress+"','"+Postcode+"','"+StreetAddress+"','"+City+"','"+County+"',FALSE);";

		PreparedStatement stmt;
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.executeUpdate();
		} catch (SQLException e) {
			return("Invalid Order!" + sql);
		}
		
		return("Order placed!");
	}
	
	/**
	 * Returns the product catalogue in text format
	 * @return The product catalogue in text format
	 */
	public String getItemCatalogue() {
		//The SQL query string
		String sql = "SELECT * FROM products";
		
		java.sql.PreparedStatement stmt;
		java.sql.Connection connection;

		try {
			//Load database driver
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			return("Can't load database driver.");
		}

		connection = null;
		try {
			//Connect to the database
			connection = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/carpartsdatabase?&serverTimezone=UTC", "root", "password");
		} catch (java.sql.SQLException e) {
			return("Can't connect to database. " + e.getMessage());
		}
		
		//Execute query and process results
		String result = "";
		try {
			stmt = connection.prepareStatement(sql);
			java.sql.ResultSet resultSet = stmt.executeQuery();
			
			while (resultSet.next()) {
				result+="Item Number:" + resultSet.getString(1) + "\n";
				result+="Product Name:" + resultSet.getString(2) + "\n";
				result+="Description:" + resultSet.getString(3) + "\n";
				result+="Price: £"+resultSet.getString(4) + "\n";
			}
			//closing the connection
			resultSet.close();
			connection.close();
			stmt.close();
		} catch (SQLException e) {
			return("An unexpected error occured. Please try again later.");
		}
		return result;
	}
}
