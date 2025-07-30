<%@page import="mypackage.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
String rollno = request.getParameter("rollno");
String marks = request.getParameter("marks");
String attendance = request.getParameter("attendance");
String remarks = request.getParameter("remarks");
String id = request.getParameter("id");

try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();
    String sql = "insert into students." + id + " values('" + rollno + "','" + marks + "','" + attendance + "','" + remarks + "')";
    st.executeUpdate(sql);

    // Redirect to the JSP named after the id value
    String redirectUrl = id + ".jsp";
    response.sendRedirect(redirectUrl);

    // Display success message if needed
    out.println("<script>");
    out.println("alert('Successful');");
    out.println("</script>");
} catch (Exception e) {
    out.println(e);
}
%>
</body>
</html>
