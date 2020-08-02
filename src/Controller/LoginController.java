package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DataBase.AdminAccount;

/**
 * Servlet implementation class LoginController
 * A class that controls logging in for Admins.
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private AdminAccount account;
	private Connection con;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * The method either forwards the user to the login restricted page or produces an error message
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//Load database driver
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			request.setAttribute("message", "Can't load database driver.");
			request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
		}
		
		con = null;
		try {
			//Set up connection to database
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/carpartsdatabase?&serverTimezone=UTC", "root", "password");
		} catch (SQLException e) {
			request.setAttribute("message", "Can't connect to database. " + e.getMessage());
			request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
		}
		
		//validate login
		String AdminName = request.getParameter("adminName");
		String password = request.getParameter("password");
		
		account = new AdminAccount(con);
		
		try {
			if (account.login(AdminName, password)) {
				request.getRequestDispatcher("/LoginSuccessful.jsp").forward(request, response);
			}
			else {
				request.setAttribute("message", "Login credentials not recognised.");
				request.getRequestDispatcher("/AdminLogin.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			request.setAttribute("message", e.getMessage());
			request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
		}
		
		try {
				//close connection
				con.close();
			} catch (SQLException e) {
				request.setAttribute("message", e.getMessage());
				request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
		}
	}

}
