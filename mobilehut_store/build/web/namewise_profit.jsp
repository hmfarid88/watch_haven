
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
        <div id="main" class="container-fluid">
            <center>
                <div class="panel panel-primary">
                    <div class="panel-body">
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
                                 <li style="margin-left: 20px"><a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>
                                   
                                </ul>
                                <ul style="margin: 15px 20px" class="nav navbar-nav navbar-right">

                                    <li> <button name="b_print" type="button" class= "btn btn-primary btn-sm"   onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</button></li>
                                </ul>

                            </div>

                        </nav>
                        <center>
                           
                            <div class="col-sm-12">
                                <br>

                                <div id="div_print">
                                    <center>
                                        <h3>Name-Wise Profit</h3> 
                                        <h4>Date: ${param.date1} To ${param.date2} </h4>
                                          <hr>
                                        <h4>Product Name : ${proname}</h4>

                                        <table  border="2" width="95%" class="table-striped table-responsive myTables " >
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Description</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Sale Price</th>
                                                    <th style="text-align: center">Discount</th>
                                                    <th style="text-align: center">Purchase Price</th>
                                                    <th style="text-align: center">Unit Profit</th>
                                                    <th style="text-align: center">Total Profit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%  
                                                    String date1 = request.getParameter("date1");
                                                    String date2 = request.getParameter("date2");
                                                    String proname = request.getParameter("proname");
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select MODEL, COLOR, PRICE, COST_PRICE, count(PRODUCT_ID) as qty, PRICE-COST_PRICE as uprofit, sum(DISCOUNT) as dis"
                                                                + " from mobilesell where MODEL LIKE '%"+ proname +"%' and  SELL_DATE between '" + date1 + "'  and '" + date2 + "' group by MODEL, COLOR, PRICE";
                                                        ps = con.prepareStatement(query);
                                                         rs= ps.executeQuery();
                                                        while (rs.next()) {

                                                %>

                                                <tr>
                                                    <td style="text-align: center">  </td>
                                                    <td style="text-align: center"><%= rs.getString("MODEL")%>, <%= rs.getString("COLOR")%> </td>
                                                    <td style="text-align: center"> <%= rs.getInt("qty")%> </td>
                                                    <td style="text-align: center"><%= rs.getFloat("PRICE")%>  </td>
                                                    <td style="text-align: center"> <%= rs.getFloat("dis")%> </td>
                                                    <td style="text-align: center"> <%= rs.getFloat("COST_PRICE")%> </td>
                                                    <td style="text-align: center"> <%= rs.getFloat("uprofit")%> </td>
                                                    <td style="text-align: center"><%= rs.getFloat("uprofit") * rs.getFloat("qty")%> </td>

                                                    <%
                                                            }
                                                        } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                                                    %>
                                                </tr>

                                                <%            
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(PRICE) as saleprice, sum(COST_PRICE) as cost, count(PRODUCT_ID) as tqty, sum(DISCOUNT) as totaldis"
                                                                + " from mobilesell where MODEL LIKE '%"+ proname +"%' and  SELL_DATE between '" + date1 + "'  and '" + date2 + "'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {


                                                %>

                                                <tr style="background-color: #cccccc">
                                                    <th></th>
                                                    <th style="text-align: center">Total :</th>
                                                    <th style="text-align: center"><%= rs.getInt("tqty")%></th>
                                                    <th style="text-align: center"><%= rs.getFloat("saleprice")%></th>
                                                    <th style="text-align: center"><%= rs.getFloat("totaldis")%></th>
                                                    <th style="text-align: center"><%= rs.getFloat("cost")%></th>
                                                    <th></th>
                                                    <th style="text-align: center"><%= rs.getFloat("saleprice") - rs.getFloat("cost")%></th>

                                                    <%                                                            }
                                                        } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                                                    %>
                                                </tr>
                                            </tbody>
                                        </table>
                                        
                                    </center>
                                </div>

                            </div>
                           
                        </center>


                    </div>
                </div>
            </center>
        </div>
        <%@include file = "footerpage.jsp" %> 


        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-3.1.1.min.js"></script>
       
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
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('.myTables tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('.myacTables tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>

        <% } %>
    </body>
</html>
