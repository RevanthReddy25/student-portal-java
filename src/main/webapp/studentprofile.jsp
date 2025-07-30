<%@ page import="java.sql.*" %>
<%@ page import="mypackage.ConnectionProvider" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
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
        .table-container {
		    max-width: 800px;
		    margin: 20px auto;
		}
		
		table {
		    width: 100%;
		    border-collapse: collapse;
		}
		
		thead {
		    background-color: #008170;
		    color: white;
		}
			
		th, td {
		    padding: 8px;
		    text-align: left;
		    border-bottom: 1px solid #ddd;
		}
		
		tr:hover {
		    background-color: rgba(0, 129, 112, 0.5); 
		}
		.delete-btn {
            background-color: #ff6600;
            color: #fff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .delete-btn:hover {
            background-color: #e65c00;
        }
        
    </style>
</head>
<body>
        <a href="home.html" class="signup-btn">Logout</a>
<% 
    String rollno = request.getParameter("rollno");
	out.println("<h1 style=\"text-align:center\">" + rollno + "</h1>");
%>
    <div class="btn-container">
        <a href="tt.html" class="btn">Timetable</a>
        <a href="faculty.jsp" class="btn">Faculty</a>
    </div>

<div class="table-container">
    <h2>Student Profile</h2>
    <table>
        <thead>

        <tr>
            <th>Subject</th>
            <th>Marks</th>
            <th>Attendance</th>
            <th>Remarks</th>
        </tr>
        </thead>
        <tbody>

        <% 
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                con = ConnectionProvider.getCon();

                String[] tables = {"cs251", "cs252", "cs253", "cs254", "cs255", "cs256", "cs257"};
                for (String table : tables) {
                    String query = "SELECT * FROM students." + table + " WHERE rollno = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, rollno);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        String marks = rs.getString("marks");
                        String attendance = rs.getString("attendance");
                        String remarks = rs.getString("remarks");
                        out.println("<tr>");
                        out.println("<td>" + table + "</td>");
                        out.println("<td>" + marks + "</td>");
                        out.println("<td>" + attendance + "</td>");
                        out.println("<td>" + remarks + "</td>");
                        out.println("</tr>");
                    }
                }
            } catch(Exception e){
                out.println("Error: " + e.getMessage());
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
        </tbody>
    </table>
</div>
</body>
</html>
