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
    <a href="home.html" class="signup-btn">Logout</a><br>

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
        ps.setString(1,"CS253");
        rs = ps.executeQuery();
        if (rs.next()) {
            out.println("<h1>Teacher Information</h1>");
            out.println("<p>Teacher Name: " + rs.getString("teacher_name") + "</p>");
            out.println("<p>Course: " + rs.getString("teacher_id") + "</p>");
            out.println("<p>M.Tech: " + rs.getString("mtech") + "</p>");
            out.println("<p>Email: " + rs.getString("email") + "</p>");
            out.println("<p>Position: " + rs.getString("position") + "</p>");
            out.println("<p>Phd: " + rs.getString("phd") + "</p>");
            out.println("<p>PhoneNumber: " + rs.getString("phone") + "</p>");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>
<hr>
    <h1>Enter Marks and Attendance</h1>
<form name = "myForm" action="insertresult.jsp" method="post" onsubmit="return validateForm()">
    <label for="rollno">Roll No:</label>
    <input type="number" id="rollno" name="rollno" required>
    
    <label for="marks">Marks:</label>
    <input type="number" id="marks" name="marks" required>
    
    <label for="attendance">Attendance:</label>
    <input type="number" id="attendance" name="attendance" required>
    
    <label for="remarks">Remarks:</label>
    <input type="text" id="remarks" name="remarks">
    
    <button class="btn" type="submit">Submit</button>
    <input type="hidden" id="id" name="id" value="cs253"> <!-- Hidden input field -->
</form>
<hr>
<script>
function validateForm() {
    var marks = parseInt(document.getElementById("marks").value);
    var attendance = parseInt(document.getElementById("attendance").value);
    
    // Check if marks and attendance are within valid range
    if (marks < 0 || marks > 100) {
        alert("Marks should be between 0 and 100");
        return false;
    }
    
    if (attendance < 0 || attendance > 100) {
        alert("Attendance should be between 0 and 100");
        return false;
    }
    
    return true; // Form submission allowed if validation passes
}
function deleteRow(rollno) {
    if (confirm("Are you sure you want to delete the row with Roll No: " + rollno + "?")) {
        // AJAX request to delete.jsp
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "delete.jsp?id=cs253", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                // Display success message
                alert("Row with Roll No: " + rollno + " deleted successfully!");
                // Reload page to reflect changes
                window.location.reload();
            }
        };
        xhr.send("rollno=" + rollno);
    }
}

function deleteAll() {
    if (confirm("Are you sure you want to delete all rows?")) {
        // AJAX request to delete.jsp
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "delete.jsp?id=cs253", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                // Display success message
                alert("All rows deleted successfully!");
                // Reload page to reflect changes
                window.location.reload();
            }
        };
        xhr.send("deleteAll=true");
    }
}

</script>

<h2>Contents of Table CS253</h2>
<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>Roll No</th>
                <th>Marks</th>
                <th>Attendance</th>
                <th>Remarks</th>
                <th></th>

            </tr>
        </thead>
        <tbody>
            <% 
                try {
                    String sql = "SELECT * FROM cs253";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("rollno") %></td>
                <td><%= rs.getString("marks") %></td>
                <td><%= rs.getString("attendance") %></td>
                <td><%= rs.getString("remarks") %></td>
                <td><button class="delete-btn" onclick="deleteRow('<%= rs.getString("rollno") %>')">Delete</button></td>
            </tr>
            <% 
                    }
                } catch(Exception e){
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>
<div class="btn-container">
    <button class="delete-btn" onclick="deleteAll()">Delete All</button>
</div>

</body>
</html>
