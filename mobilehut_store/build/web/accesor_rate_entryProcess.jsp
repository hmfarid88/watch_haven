<%-- 
    Document   : color_entryProcess
    Created on : Jan 26, 2018, 1:53:32 AM
    Author     : Polash
--%>

<%@page import="java.sql.ResultSet"%>
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
            String prodct = request.getParameter("prodct");
            Float costprice = Float.parseFloat(request.getParameter("costprice"));
            Float saletprice = Float.parseFloat(request.getParameter("saleprice"));
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Ssymphonyy.getConnection();
                String query1 = "select count(*) from accessor_price where PRODUCT_NAME=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, prodct);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt(1);
                if (a > 0) {
                    out.println("<h3>Sorry ! This Model is Exist, Input another Model</h3>");
                } else {
                    String query = "insert into accessor_price (PRODUCT_NAME, PURCHES_PRICE, SALE_PRICE)  values (?,?,?)";
                    ps = con.prepareStatement(query);
                    ps.setString(1, prodct);
                    ps.setFloat(2, costprice);
                    ps.setFloat(3, saletprice);
                    int b = ps.executeUpdate();
                    if (b > 0) {
                        response.sendRedirect("symaccesor_entry.jsp");
                    } else {
                        out.println("Sorry! Entry is not Success");
                    }
                }
            } catch (SQLException ex) {
            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        %>
    </body>
</html>
