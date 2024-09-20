<%-- 
    Document   : search_product
    Created on : Jan 19, 2018, 11:34:50 PM
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
                <div class="panel panel-primary">
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
                               
                                <li style="margin-left: 20px"> <a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>

                            </ul>
                             <ul class="nav navbar-nav navbar-right">
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                        </div>

                    </nav>
                    <div class="panel-body"> 

                        <div class="row">
                            <div class="col-sm-12">
                                <div id="div_print">
                                    <center>
                                        <h4>View Searched Customer</h4>   
                                        <h5>Search Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </h5>
                                        <hr>
                                        <div id="falsediv"><h3 style="color:red">Sorry, No Customer Found For This Input !</h3></div>
                                        <table border="2" class=" table-condensed table-responsive" width="70%" >
                                            <tbody>
                                                <tr>
                                                    <th style="text-align: center">Customer Name</th>
                                                    <th style="text-align: center">Phone Number</th>
                                                    <th style="text-align: center">Address</th>
                                                    <th style="text-align: center">Sale Date</th>
                                                    <th style="text-align: center">Invoice</th>
                                                </tr>
                                                <%
                                                    String mobilenumber = request.getParameter("mob");

                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select CUSTOMER_ID, C_NAME, PHONE_NUMBER, ADDRESS, DATE from customerinfo where PHONE_NUMBER='" + mobilenumber + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();

                                                        while (rs.next()) {
//                                                            
                                                %>
                                                <tr id="customershow">
                                                    <td style="text-align: center" class="text-uppercase"><%= rs.getString("C_NAME")%></td>
                                                    <td style="text-align: center"><%= rs.getString("PHONE_NUMBER")%></td>
                                                    <td style="text-align: center"><%= rs.getString("ADDRESS")%></td>
                                                    <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                    <td style="text-align: center">
                                                        <form method="POST" action="searched_invoice.jsp">
                                                            <input type="hidden" name="selldate" value="<%= rs.getString("DATE") %>" >
                                                            <input type="hidden" name="cid" value="<%= rs.getString("CUSTOMER_ID") %>" >
                                                            <input type="submit" value="Invoice">
                                                        </form>
                                                    </td>
                                                </tr>
                                                <%
                                                        }

                                                    } catch (Exception ex) {
                                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>


                                            </tbody>
                                        </table>

                                    </center>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </center>
            <%@include file = "footerpage.jsp" %> 
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
        <script language="javascript">
            function printdiv(printpage)
            {
                var headstr = "<html><head><title></title></head><body>";
                var footstr = "</body>";
                var newstr = document.all.item(printpage).innerHTML;
                var oldstr = document.body.innerHTML;
                document.body.innerHTML = headstr + newstr + footstr;
                window.print();
                document.body.innerHTML = oldstr;
                return false;
            }
        </script>
        <script>
                                                    $(document).ready(function () {
                                                        $("#customershow").show(function () {
                                                            $("#falsediv").hide();
                                                        });
                                                    });
        </script>

<%  } %>
    </body>
</html>
