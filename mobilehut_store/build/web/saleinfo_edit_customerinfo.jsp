<%-- 
    Document   : saleinfo_edit
    Created on : Jan 27, 2018, 1:43:23 AM
    Author     : Polash
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
        
        <style>
            fieldset.scheduler-border {
                border: 1px groove green ;
                padding: 0 1.4em 1.4em 1.4em ;
                margin: 0 0 1.5em 0;
                -webkit-box-shadow:  0px 0px 0px 0px #000;
                box-shadow:  0px 0px 0px 0px #000;
            }

            legend.scheduler-border {
                width:inherit; 
                padding:0 10px; /* To give a bit of padding on the left and right */
                border-bottom:none;
            }
        </style>
    </head>
    <body>


        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <div id="main" class="container" >
            <nav style="margin: 0 auto" class="navbar navbar-inverse">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                       
                        <li style=" margin-left: 20px"> <a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>
                    </ul>
                    <ul  class="nav navbar-nav navbar-right">

                        <li> <a href="voucher.jsp"><span class="fa fa-backward"></span> Back</a></li>

                    </ul> 

                </div>

            </nav>
            <br>

            <div class="col-sm-2"></div>
            <div class="col-sm-8">
                <div class="panel panel-primary">
                    <div class="panel-heading"><h3>Sale Info Update</h3></div> 
                    <div class="panel-body">
                        <form method="POST" action="saleUpdate_process_customer.jsp" >


                            <%
                                
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select CUSTOMER_ID, C_NAME, PHONE_NUMBER, ADDRESS from customerinfo where CUSTOMER_ID=(select max(CUSTOMER_ID) from paymentinfo)";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("cid", rs.getInt("CUSTOMER_ID"));
                                        request.setAttribute("cname", rs.getString("C_NAME"));
                                        request.setAttribute("number", rs.getString("PHONE_NUMBER"));
                                        request.setAttribute("address", rs.getString("ADDRESS"));
                                    }
                                } catch (Exception ex) {                            
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>
                            <div class="row">
                                <div class="col-sm-1"></div>
                                <div class="col-sm-10">
                                    <fieldset class="scheduler-border">
                                        <legend class="scheduler-border">Customer-Information</legend>

                                        <div class="col-sm-4">
                                            <label>Customer Name:</label>
                                            <input type="hidden" name="cid" value="${cid}" >
                                            <input type="text" class="form-control" name="cname" value="${cname}" required="" >
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Mobile Number:</label>
                                            <input type="text" class="form-control" name="cnumber" value="${number}" required="" >
                                        </div>
                                        <div class="col-sm-4">

                                            <label>Address:</label>
                                            <input type="text" class="form-control" name="caddress" value="${address}" >
                                        </div>
                                    </fieldset>
                                </div>
                                <div class="col-sm-1"></div>
                            </div>
                            
                            
                            <div class="row text-center">
                                <input type="submit" class="btn btn-success" value="Update">
                            </div>
                        </form>
                    </div> 
                </div>

            </div>
            <div class="col-sm-2"></div>
        </div>

        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-3.1.1.min.js"></script>
        
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
