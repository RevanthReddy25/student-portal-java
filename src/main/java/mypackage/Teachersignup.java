package mypackage;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class Teachersignup
 */
public class Teachersignup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Teachersignup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        PrintWriter out = response.getWriter();
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/students", "root", "revanth25");
	        String str1 = request.getParameter("teacher_id");
	        String str2 = request.getParameter("oldpassword");
	        String str3 = request.getParameter("password");
	        String str4 = request.getParameter("confirm_password");

	        // Fetch the password from the database for the given teacher ID
	        PreparedStatement ps = con.prepareStatement("SELECT password FROM teachers WHERE teacher_id = ?");
	        ps.setString(1, str1);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            String passwordFromDB = rs.getString("password");

	            // Check if the old password input matches the password stored in the database
	            if (str2.equals(passwordFromDB)) {
	                // Check if the new password and confirm password match
	                if (str3.equals(str4)) {
	                    // Update the password in the database
	                    PreparedStatement updatePs = con.prepareStatement("UPDATE teachers SET password = ? WHERE teacher_id = ?");
	                    updatePs.setString(1, str3); // New password
	                    updatePs.setString(2, str1); // Teacher ID
	                    updatePs.executeUpdate();

	                    // Forward to a success page
	                    RequestDispatcher rd = request.getRequestDispatcher("info.html");
	                    rd.forward(request, response);
	                } else {
	                    out.println("<script>");
	                    out.println("alert('MISMATCH OF PASSWORDS !');");
	                    out.println("window.location.href='Teachersignup.html';");
	                    out.println("</script>");
	                }
	            } else {
	                out.println("<script>");
	                out.println("alert('INCORRECT OLD PASSWORD !');");
	                out.println("window.location.href='Teachersignup.html';");
	                out.println("</script>");
	            }
	        } else {
	            out.println("<script>");
	            out.println("alert('TEACHER ID NOT FOUND !');");
	            out.println("window.location.href='Teachersignup.html';");
	            out.println("</script>");
	        }
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
}