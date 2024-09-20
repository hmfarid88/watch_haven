
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

            int cid =Integer.parseInt(request.getParameter("cid"));
            String invo = "NOV2018";
            String invoice = invo + cid;
            String ime = request.getParameter("imei");

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs1=null;
            try {
                con = Ssymphonyy.getConnection();
                String query1 = "select count(*) from stock where IMEI=? ";
                ps=con.prepareStatement(query1);
                ps.setString(1, ime);
                rs = ps.executeQuery();
                rs.next();
                int p = rs.getInt(1);
                if (p < 1) {
                    out.println("<h3>Sorry! This Product is not in stock.</h3>");
                } else {
                    String query = "select  BRAND, MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, DATE from stock where IMEI=?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, ime);
                    rs1 = ps.executeQuery();
                    rs1.next();
                        String brand = rs1.getString("BRAND");
                        String model = rs1.getString("MODEL");
                        String color = rs1.getString("COLOR");
                        String imei = rs1.getString("IMEI");
                        Float costprice = rs1.getFloat("PURCHASE_PRICE");
                        Float stockrate = rs1.getFloat("SELL_PRICE");
                        Float price = rs1.getFloat("SELL_PRICE");
                        String vendor = rs1.getString("VENDOR");
                        String date = rs1.getString("DATE");

                        String query2 = "insert into vendor_sale (PRODUCT_ID, CUSTOMER_ID, INVOICE_NO, BRAND,"
                                + "MODEL, COLOR, COST_PRICE, STOCK_RATE, PRICE, VENDOR, STOCK_DATE, SELL_DATE) values (?,?,?,?,?,?,?,?,?,?,?,CURDATE())";
                        ps = con.prepareStatement(query2);
                        ps.setString(1, imei);
                        ps.setInt(2, cid);
                        ps.setString(3, invoice);
                        ps.setString(4, brand);
                        ps.setString(5, model);
                        ps.setString(6, color);
                        ps.setFloat(7, costprice);
                        ps.setFloat(8, stockrate);
                        ps.setFloat(9, price);
                        ps.setString(10, vendor);
                        ps.setString(11, date);
                        int b =ps.executeUpdate();
                        if(b>0){
                           String query3 = "delete from stock where IMEI=?";
                        ps = con.prepareStatement(query3);
                        ps.setString(1, imei);
                        ps.executeUpdate();
                        response.sendRedirect("Vendor_sale.jsp"); 
                        }else{
                            out.println("Sale is not completed !");
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
