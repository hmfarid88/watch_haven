/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DB.Ssymphonyy;
import Model.CidModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Polash
 */
public class CustomerId {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs=null;
    public CidModel Voucer() {
        CidModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "SELECT MAX(CUSTOMER_ID) as ID from customerinfo GROUP BY CUSTOMER_ID";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                cm = new CidModel();
                cm.setCid(rs.getInt("ID"));
            }
        } catch (SQLException ex) {
            
        }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
}

        return cm;
    }
}
