
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
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
            String rollback = request.getParameter("pid");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Ssymphonyy.getConnection();
                String cid="select count(*) as data from customerinfo where CUSTOMER_ID IN (select CUSTOMER_ID from vendor_accessor_sale where PRODUCT_ID='"+ rollback +"')";
            ps = con.prepareStatement(cid);
            rs=ps.executeQuery();
            rs.next();
            int x=rs.getInt("data");
            if(x>0){
             out.println("<h3>Sorry! You are not allowed to delete this sale</h3>");
            }else{
                String query1 = "insert into accessoriesstock (PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE,"
                        + " VENDOR, DATE) select PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, STOCK_RATE,"
                        + " VENDOR, STOCK_DATE from vendor_accessor_sale where PRODUCT_ID=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, rollback);
                int b = ps.executeUpdate();
                if(b>0){
                String query2 = "delete from vendor_accessor_sale  where PRODUCT_ID=?";
                ps = con.prepareStatement(query2);
                ps.setString(1, rollback);
                ps.executeUpdate();
                response.sendRedirect("Vendor_sale.jsp");
}
            }  } catch (SQLException ex) {

            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        %>
    </body>
</html>
