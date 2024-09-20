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
            String brand = request.getParameter("brand");
            String model = request.getParameter("mdl");
            Float costprice = Float.parseFloat(request.getParameter("costprice"));
            Float selprice = Float.parseFloat(request.getParameter("saleprice"));
            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = Ssymphonyy.getConnection();
                String query = "update model_price set  PURCHASE_PRICE=?, SALE_PRICE=? where BRAND=? and  MODEL=? ";
                ps = con.prepareStatement(query);
                ps.setFloat(1,costprice );
                ps.setFloat(2,selprice );
                ps.setString(3, brand);
                ps.setString(4, model);
                int a = ps.executeUpdate();
                if (a > 0) {
                    response.sendRedirect("model_colorEntry.jsp");
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
