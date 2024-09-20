/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DB;
import java.sql.*;
public class Ssymphonyy {
  
    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/fahad_telecom",
                    "root", "");
            
           return con;
        } catch (Exception ex) {
            
            System.out.println("Database.getConnection() Error -->" + ex.getMessage());

        }
        return null;
    }

    public static void close(Connection con) {
        try {
            if(con != null){
           con.close();
           con = null;
        }
        } catch (Exception ex) {
         ex.printStackTrace();  
        }
    }

}

  

