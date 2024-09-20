<%-- 
    Document   : cost_updateProcess
    Created on : Jan 26, 2018, 12:29:55 AM
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

            int costid = Integer.parseInt(request.getParameter("id"));
            String costname = request.getParameter("descrip");
            Float amount = Float.parseFloat(request.getParameter("amount"));
            String date = request.getParameter("date");
            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = Ssymphonyy.getConnection();
                String query = "update cost set COST_NAME=?, AMOUNT=?, DATE=? where SI_NO=?";
                ps = con.prepareStatement(query);
                ps.setString(1, costname);
                ps.setFloat(2, amount);
                ps.setString(3, date);
                ps.setInt(4, costid);
                int a = ps.executeUpdate();
                if (a > 0) {
                    response.sendRedirect("monthly_cost_view.jsp");
                } else {
                    out.println("<h3>Sorry Update is not Success !</h3>");
                }
            } catch (Exception ex) {
            }finally {
     try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        %>
    </body>
</html>
