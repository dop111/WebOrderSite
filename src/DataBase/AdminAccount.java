package DataBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * This class checks if a login is valid or not
 * @author Daniele Palazzo
 *
 */
public class AdminAccount {
	private Connection connection;
	
	/**
	 * Constructs the object
	 * @param connection The connection to the database.
	 */
	public AdminAccount(Connection connection) {
		this.connection = connection;
	}
	
	/**
	 * Checks whether or not the entered login information exists in the database.
	 * @param userName The user name of the admin
	 * @param password The password of the admin
	 * @return Returns true if the login information exists in the database
	 * @throws SQLException Throws an exception if the query cannot be completed
	 */
	public boolean login(String userName, String password) throws SQLException {
		//Query string
		String sql = "select count(*) as count from admins where UserName=? and Password=?";

		PreparedStatement stmt;
		
		int count = 0;
		
		stmt = connection.prepareStatement(sql);
		//set wildcards
		stmt.setString(1, userName);
		stmt.setString(2, password);
		ResultSet resultSet = stmt.executeQuery();
		
		//process results
		if (resultSet.next()) {
			count = resultSet.getInt("count");
		}
		
		//close
		resultSet.close();
		stmt.close();
		
		//return
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
}
