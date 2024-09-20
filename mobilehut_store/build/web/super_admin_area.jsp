<%-- 
    Document   : userupdate
    Created on : Oct 17, 2017, 2:21:31 AM
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
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body>
       
        <%
            if ((session.getAttribute("superadmin") == null) || (session.getAttribute("superadmin") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="super_admin.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>

    <div id="main" class="container"><br>
        <a id="lgn" href="LogoutServlet">  <b> Logout</b></a>
            <center>    <br>    <br>    <br>
                <div class="panel panel-primary" style=" width: 60%">
                
                    <div class="panel-body">
                  
                        <h3>Expiration Date</h3><hr>
                       
                            <%
                               
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select EX_DATE from userinfo where USER_NAME='User'";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                     request.setAttribute("exdate", rs.getString("EX_DATE"));
                                    
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                           
                            %>
                            <form method="POST" action="Ex_DateUpdate" class="form-inline text-center">
                            <label style="width: 150px">Expire Date:</label>
                       
                            <input type="text" class="form-control" value="${exdate}" readonly="" >
                            <br>  <br>

                            <label style="width: 150px">Extend Date:</label>
                            <input type="date" class="form-control" name="date" value=""  required="">
                            <br>  <br>

                            <button type="submit" class="btn btn-primary">Extend</button>

                        </form>
                    </div>
                </div> 
           
           <div class="panel panel-primary" style=" width: 60%">
                
               <div class="panel-body">
                   <h3>Message Limit</h3><hr>
                   <form method="POST" action="MsgLimitUpdate" class="form-inline text-center">
                            <label>Start Date:</label>
                       
                            <input type="date" class="form-control" name="stdate" value="" required="">
                            
                            <label>End Date:</label>
                            <input type="date" class="form-control" name="endate" value=""  required="">
                            <br> <br>
                            <label>Quantity:</label>
                            <input type="number" class="form-control" name="qty" value=""  required="">
                            <br>  <br>
                            <button type="submit" class="btn btn-success">Update</button>

                        </form>
               </div>
           </div>
                             </center>
        </div>


        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
   
     <script>
            history.pushState(null, document.title, location.href);
            window.addEventListener('popstate', function (event)
            {
                history.pushState(null, document.title, location.href);
            });
        </script>

        <% } %>
    </body>
</html>
