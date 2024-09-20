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
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>

        <div id="main" class="container">
            <center>
                <div class="panel panel-primary" style=" width: 60%">
                    <br> <a style="margin-left: 2%" href="home.jsp" class="btn btn-sm btn-success pull-left"><span class="glyphicon glyphicon-home"></span> Home</a>
                    <div class="panel-body">


                        <h2>User Update Form</h2><hr>
                       
                            <%
                                String uid = request.getParameter("olduid");
                                String psword = request.getParameter("oldpsword");
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select EMAIL, USER_ID, PASSWORD from userinfo where USER_ID='" + uid + "' and PASSWORD='" + psword + "' and USER_NAME='User' ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                    
                                     request.setAttribute("email", rs.getString("EMAIL"));
                                         request.setAttribute("userid", rs.getString("USER_ID"));
                                           request.setAttribute("pasword", rs.getString("PASSWORD"));
                                    
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                           
                            %>
                            <form method="POST" action="userupdate_process.jsp" class="form-inline text-center">
                            <label style="width: 150px">Old User Id:</label>
                       
                            <input type="text" class="form-control" name="olduid" value="${userid}" readonly="" >
                            <br>  <br>

                            <label style="width: 150px">Old Password:</label>
                            <input type="text" class="form-control" name="oldpsword" value="${pasword}" readonly="" >
                            <br>  <br>

                            <label style="width: 150px">User's Email:</label>
                            <input type="email"  class="form-control" name="email" value="${email}"  required="">
                            <br>  <br>
                            
                            <label style="width: 150px">New User ID:</label>
                            <input type="text"  class="form-control" name="newuid" value="" required="">
                            <br>  <br>


                            <label style="width: 150px">New Password:</label>
                            <input type="password"  class="form-control" name="newpsword" value="" required="">


                            <br>  <br>
                            <button type="submit" class="btn btn-primary">Update</button>


                        </form>
                    </div>
                </div> 
            </center>
            <%@include file = "footerpage.jsp" %> 
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
