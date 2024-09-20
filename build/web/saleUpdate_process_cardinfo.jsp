<%-- 
    Document   : saleUpdate_process
    Created on : Jan 27, 2018, 3:18:25 PM
    Author     : Polash
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
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

            int id = Integer.parseInt(request.getParameter("cid"));
            String caccno = request.getParameter("accno");
            String cardno = request.getParameter("cardno");
            Float crdamount = Float.parseFloat(request.getParameter("crdamount"));
            Float total = Float.parseFloat(request.getParameter("total"));
            Connection con = null;
            PreparedStatement ps = null;

            try {
                con = Ssymphonyy.getConnection();
                String query = "update paymentinfo set CARD_RECV='" + crdamount + "',CASH_RECV='" + total + "'-'" + crdamount + "',  CARD_ACC_NO='" + caccno + "', CARD_NO='" + cardno + "' where CUSTOMER_ID='" + id + "'";
                ps=con.prepareStatement(query);
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
