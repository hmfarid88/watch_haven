
<%@page import="java.sql.Statement"%>
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

            int cid =Integer.parseInt( request.getParameter("cid"));
            String invo = "NOV2018";
            String invoice = invo + cid;
            String id = request.getParameter("accessorid");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs1=null;

            try {
                con = Ssymphonyy.getConnection();
                String query1 = "select count(*) from accessoriesstock where PRODUCT_ID=? ";
                ps=con.prepareStatement(query1);
                ps.setString(1, id);
                rs = ps.executeQuery();
                rs.next();
                int p = rs.getInt(1);
                if (p < 1) {
                    out.println("<h3>Sorry! This Product is not in stock.</h3>");
                } else {
                    String query = "select  PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, DATE from accessoriesstock where PRODUCT_ID=?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, id);
                    rs1 = ps.executeQuery();
                    rs1.next();

                        String proname = rs1.getString("PRODUCT_NAME");
                        String productid = rs1.getString("PRODUCT_ID");
                        String model = rs1.getString("MODEL");
                        Float costprice = rs1.getFloat("COST_PRICE");
                        Float sellprice = rs1.getFloat("SELL_PRICE");
                        String vendor = rs1.getString("VENDOR");
                        String stockdate=rs1.getString("DATE");

                        String query2="insert into vendor_accessor_sale (PRODUCT_NAME, PRODUCT_ID, MODEL, COST_PRICE, STOCK_RATE, SELL_PRICE,"
                                + " VENDOR, INVOICE_NO, CUSTOMER_ID, STOCK_DATE, DATE) values (?,?,?,?,?,?,?,?,?,?,CURDATE())";
                                ps = con.prepareStatement(query2);
                                ps.setString(1, proname);
                                ps.setString(2, productid);
                                ps.setString(3, model);
                                ps.setFloat(4, costprice);
                                ps.setFloat(5, sellprice);
                                ps.setFloat(6, sellprice);
                                ps.setString(7, vendor);
                                ps.setString(8, invoice);
                                ps.setInt(9, cid);
                                ps.setString(10, stockdate);
                                int b=ps.executeUpdate();
                                if(b>0){
                        String query3="delete from accessoriesstock where  PRODUCT_ID=?";
                        ps = con.prepareStatement(query3);
                        ps.setString(1, id);
                        ps.executeUpdate();
                        response.sendRedirect("Vendor_sale.jsp");
                                }else{
                                    out.println("Sale is not completed");
                                }
                    
                }
            } catch (SQLException ex) {

            }finally {
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        %>
    </body>
</html>
