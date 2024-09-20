<%-- 
    Document   : cost_update
    Created on : Jan 25, 2018, 10:57:06 PM
    Author     : Polash
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Mobile Store</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/jquery-3.1.1.min.js"></script>
        <link rel="icon" type="image/png" href="img/favicon.ico">      
    </head>
    <body>
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <div id="main" class="container"><br><br>

            <div class="row text-center">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="panel panel-primary">
                        <div class="panel-heading">  <h4>Update Cost Info</h4></div>
                        <div class="panel-body">

                            <%
                                int costid = Integer.parseInt(request.getParameter("costid"));
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select SI_NO, COST_NAME, AMOUNT, DATE from cost where SI_NO=?";
                                    ps = con.prepareStatement(query);
                                    ps.setInt(1, costid);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <form method="POST" action="cost_updateProcess.jsp" >
                                <div class="row">
                                    <div class="col-sm-3">
                                        <label>Description</label> 
                                        <input type="hidden" name="id" value="<%= rs.getInt("SI_NO") %>" >
                                        <input type="text" name="descrip" class="form-control  text-center" value="<%= rs.getString("COST_NAME")%>">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Amount</label> 
                                        <input type="number" name="amount" class="form-control text-center" value="<%= rs.getFloat("AMOUNT")%>" >
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Date</label> 
                                        <input type="text"  class="form-control text-center"  value="<%= rs.getString("DATE")%>" readonly="" >
                                    </div>
                                    <%
                                            }
                                        } catch (Exception ex) {
                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                                    %>
                                    <div class="col-sm-3">
                                        <label> Select Date</label>  
                                        <input type="date" class="form-control text-center" autocomplete="off"  name="date"   value="" required="">
                                    </div>
                                </div><br>

                                <input type="submit" class="btn btn-primary" value="Update">

                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>


            </div>
            <%@include file = "footerpage.jsp" %> 
        </div> 

        <script src="js/bootstrap.min.js"></script>
               
        <% } %>
    </body>
</html>
