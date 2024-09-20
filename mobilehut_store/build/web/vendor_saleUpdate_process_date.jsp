<%-- 
    Document   : saleUpdate_process
    Created on : Jan 27, 2018, 3:18:25 PM
    Author     : Polash
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <%
            int id=Integer.parseInt(request.getParameter("cid"));
            String date = request.getParameter("date1");

            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = Ssymphonyy.getConnection();
                
                String query = "update vendor_sale set SELL_DATE='" + date + "' where CUSTOMER_ID='" + id + "'";
                ps=con.prepareStatement(query);
                ps.executeUpdate();

            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

            try {
                con = Ssymphonyy.getConnection();
               
                String query = "update vendor_accessor_sale set DATE='" + date + "' where CUSTOMER_ID='" + id + "'";
                ps=con.prepareStatement(query);
                ps.executeUpdate();

            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

            try {
                con = Ssymphonyy.getConnection();
                
                String query = "update customerinfo set DATE='" + date + "' where CUSTOMER_ID='" + id + "'";
                ps=con.prepareStatement(query);
                ps.executeUpdate();
                response.sendRedirect("vendor_voucher.jsp");
            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        %>


    </body>
</html>
