 <%-- 
    Document   : userupdate
    Created on : Oct 17, 2017, 2:21:31 AM
    Author     : Polash
--%>

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

                        <h2>Input Information</h2><hr>
                        <form method="POST" action="userupdate.jsp" class="form-inline text-center">


                            <label style="width: 120px">Old User Id:</label>
                            <input type="text" class="form-control" name="olduid" value="" required="">
                            <br>  <br>


                            <label style="width: 120px">Old Password:</label>
                            <input type="password" class="form-control" name="oldpsword" value="" required="">
                            <br>  <br>

                            
                            <button type="submit" class="btn btn-primary">GO</button>
                          

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
