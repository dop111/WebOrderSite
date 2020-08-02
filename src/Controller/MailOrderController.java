package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MailOrderController
 * This servlet submits customer orders.
 */
@WebServlet("/MailOrderController")
public class MailOrderController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MailOrderController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * Submits an order and produces "Order placed!" message or "Order invalid!" message
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Load database driver
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			request.setAttribute("message", "Can't load database driver.");
			request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
		}
		
		Connection con = null;
		try {
			//Set up connection to database
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpartsdatabase?&serverTimezone=UTC", "root", "password");
		} catch (SQLException e) {
			request.setAttribute("message", "Can't connect to database. " + e.getMessage());
			request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
		}
		
		//Get order details from link parameters
		String ItemNumber = request.getParameter("ItemNumber");
		String Amount = request.getParameter("Amount");
		String FirstName = request.getParameter("FirstName");
		String LastName = request.getParameter("LastName");
		String EmailAddress = request.getParameter("EmailAddress");
		String PostCode = request.getParameter("Postcode");
		String StreetAddress = request.getParameter("StreetAddress");
		String City = request.getParameter("City");
		String County = request.getParameter("County");
		
		//Database Query
		String sql = "INSERT INTO orders (ItemNumber,Amount,FirstName,LastName,EmailAddress,Postcode,StreetAddress,City,County,Dispatched) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,FALSE);";

		//create statement
		PreparedStatement stmt;
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, ItemNumber);
			stmt.setString(2, Amount);
			stmt.setString(3, FirstName);
			stmt.setString(4, LastName);
			stmt.setString(5, EmailAddress);
			stmt.setString(6, PostCode);
			stmt.setString(7, StreetAddress);
			stmt.setString(8, City);
			stmt.setString(9, County);
			
			stmt.executeUpdate(); //execute statement
		} catch (SQLException e) {
			request.setAttribute("message", "Invalid Order!");
			request.getRequestDispatcher("/Order.jsp").forward(request, response);
			return;
		}
		
		request.setAttribute("message", "Order placed!");
		request.getRequestDispatcher("/Order.jsp").forward(request, response);
		
	}

}
