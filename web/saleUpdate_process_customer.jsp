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
            
            int cid=Integer.parseInt(request.getParameter("cid"));
            String cname = request.getParameter("cname");
            String cnumber = request.getParameter("cnumber");
            String caddress = request.getParameter("caddress");
            
            Connection con = null;
            PreparedStatement ps = null;
            
        try {
                con = Ssymphonyy.getConnection();
                String query = "update customerinfo set C_NAME=?, PHONE_NUMBER=?,  ADDRESS=? where CUSTOMER_ID=? ";
                ps=con.prepareStatement(query);
                ps.setString(1, cname);
                ps.setString(2, cnumber);
                ps.setString(3, caddress);
                ps.setInt(4, cid);
                ps.executeUpdate();
                response.sendRedirect("voucher.jsp");
            } catch (Exception ex) {

            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        %>
        
        
        
    </body>
</html>
