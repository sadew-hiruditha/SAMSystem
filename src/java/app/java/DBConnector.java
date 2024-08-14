
package app.java;

/**
 *
 * @author Sadew
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

public class DBConnector {

    private static final String URL = "jdbc:mysql://localhost:3306/attendance_db";
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Connection con = null;
        try {
            java.lang.Class.forName(DRIVER); // Use fully qualified name
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace(); 
            throw e; 
        }
        if(con !=null){
            
        }
        return con;
    }
}
