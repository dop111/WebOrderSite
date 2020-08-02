package Beans;

/**
 * The UserBean is used to hold admin login information
 * @author Daniele Palazzo
 *
 */
public class UserBean {
	private String adminName="";
	private String password="";

	/**
	 * Gets the user name of the logged in admin
	 * @return Returns the user name of the logged in admin
	 */
	public String getAdminName() {
		return adminName;
	}

	/**
	 * Sets the user name of the logged in admin
	 * @param adminName The user name of the admin
	 */
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
	/**
	 * Gets the password of the logged in admin
	 * @return Returns the password of the logged in admin
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * Sets the password of the logged in admin
	 * @param password The password of the admin
	 */
	public void setPassword(String password) {
		this.password = password;
	}
}
