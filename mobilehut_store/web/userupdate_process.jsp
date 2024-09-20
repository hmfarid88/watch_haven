<%-- 
    Document   : userupdate_process
    Created on : Jan 26, 2018, 9:38:41 PM
    Author     : Polash
--%>

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
            String olduserid = request.getParameter("olduid");
            String oldpassword = request.getParameter("oldpsword");
            String email = request.getParameter("email");
            String userid = request.getParameter("newuid");
            String password = request.getParameter("newpsword");
            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = Ssymphonyy.getConnection();
                String query = "update userinfo set  EMAIL='" + email + "', USER_ID='" + userid + "', PASSWORD='" + password + "' where  USER_ID='" + olduserid + "' and PASSWORD='" + oldpassword + "' and USER_NAME='User' ";
                ps = con.prepareStatement(query);
                int a = ps.executeUpdate();
                if (a > 0) {
                    response.sendRedirect("userupdate_1.jsp");
                } else {
                    out.println("Data is not Updated");
                }
            } catch (SQLException ex) {              
            }finally {
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        %>
    </body>
</html>
