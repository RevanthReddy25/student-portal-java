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

public class studentservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
    public studentservlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter out= response.getWriter();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/students","root","revanth25");
            String str1 = request.getParameter("rollno");
            String str2 = request.getParameter("password");
            PreparedStatement ps =con.prepareStatement("select rollno from login where rollno=? and pas=?");
            ps.setString(1, str1);
            ps.setString(2, str2);
            ResultSet rs =ps.executeQuery();
            if (rs.next()) {
                RequestDispatcher rd=request.getRequestDispatcher("studentprofile.jsp?rollno"+str1);
                rd.forward(request, response);
            } else {
                out.println("<script>");
                out.println("alert('LOGIN FAILED!');");
                out.println("window.location.href='studentlogin.html';");
                out.println("</script>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
