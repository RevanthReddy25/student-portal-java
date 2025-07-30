package mypackage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Teacherservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Teacherservlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out= response.getWriter();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/students","root","revanth25");
			String str1 = request.getParameter("teacher_id");
			String str2 = request.getParameter("password");
			PreparedStatement ps =con.prepareStatement("select teacher_id from teachers where teacher_id=? and password=?");
			ps.setString(1, str1);
			ps.setString(2, str2);
			ResultSet rs =ps.executeQuery();
			if (rs.next()) {
				switch(str1) {
				
				case "cs251":
					RequestDispatcher rd=request.getRequestDispatcher("cs251.jsp?teacher_id"+str1);
					rd.forward(request, response);
					break;
					
				case "cs252":
					RequestDispatcher rd1=request.getRequestDispatcher("cs252.jsp?teacher_id"+str1);
					rd1.forward(request, response);
					break;
					
				case "cs253":
					RequestDispatcher rd2=request.getRequestDispatcher("cs251.jsp?teacher_id"+str1);
					rd2.forward(request, response);
					break;
					
				case "cs254":
					RequestDispatcher rd3=request.getRequestDispatcher("cs251.jsp?teacher_id"+str1);
					rd3.forward(request, response);
					break;
					
				case "cs255":
					RequestDispatcher rd4=request.getRequestDispatcher("cs251.jsp?teacher_id"+str1);
					rd4.forward(request, response);
					break;
					
				case "cs256":
					RequestDispatcher rd5=request.getRequestDispatcher("cs251.jsp?teacher_id"+str1);
					rd5.forward(request, response);
					break;
					
				case "cs257":
					RequestDispatcher rd6=request.getRequestDispatcher("cs251.jsp?teacher_id"+str1);
					rd6.forward(request, response);
					break;
					
				default:
					out.println("<script>");
		            out.println("alert('LOGIN FAILED!');");
		            out.println("window.location.href='teacherlogin.html';");
		            out.println("</script>");
				}
				
				}
			else {
				out.println("<script>");
	            out.println("alert('LOGIN FAILED!');");
	            out.println("window.location.href='teacherlogin.html';");
	            out.println("</script>");
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
