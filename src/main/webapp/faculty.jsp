<%@page import="mypackage.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty</title>
    <style>
        body {
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif,sans-serif;
            margin: 0; 
            color:#EEEEEE;
            background-image: repeating-linear-gradient(0deg, rgb(6, 6, 6) 0px, rgb(6, 6, 6) 1px,transparent 1px, transparent 21px),repeating-linear-gradient(90deg, rgb(6, 6, 6) 0px, rgb(6, 6, 6) 1px,transparent 1px, transparent 21px),linear-gradient(90deg, hsl(144,0%,9%),hsl(144,0%,9%));
            background-color: cover;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
        }
        p {
        	text-align:center;
            font-size: 18px;
        }
	</style>
</head>
<body>
<% 
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/students", "root", "revanth25");

        // Retrieve teacher information for all courses
        String[] courses = {"CS251", "CS252", "CS253", "CS254", "CS255", "CS256", "CS257"};
        for (String course : courses) {
            String sql = "SELECT * FROM teachers WHERE teacher_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, course);
            rs = ps.executeQuery();
            if (rs.next()) {
                out.println("<h1>Teacher Information for Course " + course + "</h1>");
                out.println("<p>Teacher Name: " + rs.getString("teacher_name") + "</p>");
                out.println("<p>Course: " + rs.getString("teacher_id") + "</p>");
                out.println("<p>M.Tech: " + rs.getString("mtech") + "</p>");
                out.println("<p>Email: " + rs.getString("email") + "</p>");
                out.println("<p>Position: " + rs.getString("position") + "</p>");
                out.println("<p>Phd: " + rs.getString("phd") + "</p>");
                out.println("<p>PhoneNumber: " + rs.getString("phone") + "</p>");
            }
        }
    } catch(Exception e){
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>