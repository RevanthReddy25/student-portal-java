package mypackage;
import java.sql.*;
@SuppressWarnings("unused")
public class ConnectionProvider {
	public static Connection getCon() {
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/students","root","revanth25");
		return con;
	}
	catch(Exception e){
		System.out.println(e);
		return null;
	}
}
}