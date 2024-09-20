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
                String query = "update mobilesell set SELL_DATE=? where CUSTOMER_ID=? ";
                ps=con.prepareStatement(query);
                ps.setString(1, date);
                ps.setInt(2, id);
                int a=ps.executeUpdate();

            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

            try {
                con = Ssymphonyy.getConnection();
                String query = "update accessor_sale set DATE=? where CUSTOMER_ID=? ";
                ps=con.prepareStatement(query);
                ps.setString(1, date);
                ps.setInt(2, id);
                int b=ps.executeUpdate();

            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

            try {
                con = Ssymphonyy.getConnection();
                String query = "update paymentinfo set DATE=? where CUSTOMER_ID=? ";
                ps=con.prepareStatement(query);
                ps.setString(1, date);
                ps.setInt(2, id);
               int c= ps.executeUpdate();
             
            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

            try {
                con = Ssymphonyy.getConnection();
                String query = "update customerinfo set DATE=? where CUSTOMER_ID=? ";
                ps=con.prepareStatement(query);
                ps.setString(1, date);
                ps.setInt(2, id);
                int d=ps.executeUpdate();
                response.sendRedirect("voucher.jsp");
            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        %>


    </body>
</html>
