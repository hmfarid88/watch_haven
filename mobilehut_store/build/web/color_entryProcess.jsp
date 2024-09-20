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
            String color = request.getParameter("color");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Ssymphonyy.getConnection();
                String query1 = "select count(*) from color_entry where COLOR=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, color);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt(1);
                if (a > 0) {
                    out.println("<h3>Sorry ! This Color is Exist, Input another Color</h3>");
                } else {
                    String query = "insert into color_entry (COLOR)  values (?)";
                    ps = con.prepareStatement(query);
                    ps.setString(1, color);
                    int b = ps.executeUpdate();

                    if (b > 0) {

                  response.sendRedirect("model_colorEntry.jsp");
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
