<%@ page import="mypackage.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%
String rollno = request.getParameter("rollno");
String deleteAll = request.getParameter("deleteAll");
String id = request.getParameter("id");


try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();
    if (deleteAll != null && deleteAll.equals("true")) {
        // Delete all rows
        String sql = "DELETE FROM "+id;
        st.executeUpdate(sql);
    } else if (rollno != null && !rollno.isEmpty()) {
        // Delete row with specified Roll No
        String sql = "DELETE FROM "+id+" WHERE rollno = '" + rollno + "'";
        st.executeUpdate(sql);
    }
    // Respond with 200 OK status
    response.setStatus(200);
} catch (Exception e) {
    // Respond with error status and message
    response.setStatus(500);
    response.getWriter().write("Error: " + e.getMessage());
}
%>
