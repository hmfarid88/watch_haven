
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
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
            String pid = request.getParameter("soldid");
            Connection con = null;
            PreparedStatement ps = null;

            try {
                con = Ssymphonyy.getConnection();
                String query = "insert into accessoriesstock (PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, DATE) select  PRODUCT_NAME,"
                        + " MODEL, PRODUCT_ID, COST_PRICE, STOCK_RATE, VENDOR, STOCK_DATE from vendor_accessor_sale where PRODUCT_ID=? ";
                ps = con.prepareStatement(query);
                ps.setString(1, pid);
                int a = ps.executeUpdate();
            if(a<1){
              out.println("<h3>Sorry ! Invalid Product ID</h3>");
             }else{
                String query1 = "delete  from vendor_accessor_sale where PRODUCT_ID=? ";
                ps = con.prepareStatement(query1);
                ps.setString(1, pid);
                int b = ps.executeUpdate();
                response.sendRedirect("Monthly_vendorSale.jsp");
            }
            } catch (SQLException ex) {
            }finally {
      try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        %>

      
    </body>
</html>
