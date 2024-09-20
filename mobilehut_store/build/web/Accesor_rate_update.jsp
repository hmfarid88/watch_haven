<%-- 
    Document   : rate_update
    Created on : Jan 21, 2018, 11:28:59 PM
    Author     : Polash
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
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
            String accor = request.getParameter("pro");
            Float costprice = Float.parseFloat(request.getParameter("costprice"));
            Float selprice = Float.parseFloat(request.getParameter("saleprice"));
            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = Ssymphonyy.getConnection();
                String query = "update accessor_price set  PURCHES_PRICE='" + costprice +"', SALE_PRICE='"+ selprice +"' where  PRODUCT_NAME='" + accor + "' ";
                ps = con.prepareStatement(query);
                int a = ps.executeUpdate();
                if (a > 0) {
                    response.sendRedirect("symaccesor_entry.jsp");
                } else {
                    out.println("Data is not Updated");
                }

            } catch (Exception ex) {

            }finally {
      try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        %>
    </body>
</html>
