<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher Homepage</title>
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
        .image {
            width: 50%;
            height: 100vh;
        }
        .login {
            width: 50%;
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color:#EEEEEE;
        }
        .btn-container {
            text-align: center;
            margin-top: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap; /* Allow buttons to wrap to next line if needed */
        }
        .btn {
            display: inline-block;
            background-color: #008170;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin: 10px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #ffffff;
            color: black;
        }
        .signup-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ff6600;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .signup-btn:hover {
            background-color: #e65c00;
        }
        p {
        	text-align:center;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="btn-container">
        <a href="insertnewresult.html?teacher_id=<%= request.getParameter("teacher_id") %>" class="btn">Insert New Result</a>
        <a href="displayStudents.jsp?teacher_id=<%= request.getParameter("teacher_id") %>" class="btn">Display Students</a>
        <a href="studentInfo.jsp?teacher_id=<%= request.getParameter("teacher_id") %>" class="btn">Student Info</a>
    </div>
    <a href="logout.jsp" class="signup-btn">Logout</a><br>
<% 
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/students", "root", "revanth25");

            // Retrieve teacher information
            String teacher_id = request.getParameter("teacher_id");
            String sql = "SELECT * FROM teachers WHERE teacher_id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, teacher_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                out.println("<p>Teacher Name: " + rs.getString("teacher_name") + "</p>");
				out.println("<p>Course: " + rs.getString("teacher_id") + "</p>");
                out.println("<p>M.Tech: " + rs.getString("mtech") + "</p>");
                out.println("<p>Email: " + rs.getString("email") + "</p>");
                out.println("<p>Position: " + rs.getString("position") + "</p>");
                out.println("<p>Phd: " + rs.getString("phd") + "</p>");
                out.println("<p>PhoneNumber: " + rs.getString("phone") + "</p>");
            }
        } catch(Exception e){
}
%>

</body>
</html>
