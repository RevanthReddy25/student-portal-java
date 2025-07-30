<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    try {
        PrintWriter newout = response.getWriter();
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
                    out.println("<script>");
                    out.println("alert('Password updated successfully');");
                    out.println("window.location.href='home.html';");
                    out.println("</script>");
                } else {
                    out.println("<script>");
                    out.println("alert('MISMATCH OF PASSWORDS !');");
                    out.println("window.location.href='teachersignup.html';");
                    out.println("</script>");
                }
            } else {
                out.println("<script>");
                out.println("alert('INCORRECT OLD PASSWORD !');");
                out.println("window.location.href='teachersignup.html';");
                out.println("</script>");
            }
        } else {
            out.println("<script>");
            out.println("alert('TEACHER ID NOT FOUND !');");
            out.println("window.location.href='teachersignup.html';");
            out.println("</script>");
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
