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
            String rollback = request.getParameter("faulty");
            Connection con = null;
            PreparedStatement ps = null;

            try {
                con = Ssymphonyy.getConnection();
                String query = "insert into accessor_faulty (PRODUCT_NAME, MODEL,PRODUCT_ID, COST_PRICE, SELL_PRICE,"
                        + " VENDOR, STOCK_DATE, DATE) select PRODUCT_NAME, MODEL,PRODUCT_ID, COST_PRICE, SELL_PRICE,"
                        + " VENDOR, DATE, CURDATE() from accessoriesstock where PRODUCT_ID=?";
                ps = con.prepareStatement(query);
                ps.setString(1, rollback);
                int a = ps.executeUpdate();
                if(a>0){
                String query2 = "delete from accessoriesstock  where  PRODUCT_ID=?";
                ps = con.prepareStatement(query2);
                ps.setString(1, rollback);
                ps.executeUpdate();
                response.sendRedirect("details_accessor_stockView.jsp");
                }else{
                    out.println("Invalid Product ID");
                }
              
            } catch (SQLException ex) {
            }finally {
      try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        %>
    </body>
</html>
