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
        <title>One Zero One</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="icon" type="image/png" sizes="32x32" href="img/favicon-32x32.png">
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
                                <ul class="nav navbar-nav navbar-right">
                              
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                            </div>

                        </nav>
                        <center>
                            
                            <div class="col-sm-12">
                                <br>

                                <div id="div_print">
                                    <center>
                                        <h3>Date Wise Profit Report</h3> 
                                       <h4>Date: ${param.date1} To ${param.date2} </h4>
                                       
                                         <table  border="2" width="95%" class="table-condensed table-responsive myTables" >
                                            <thead>
                                                <tr style=" background-color: #030303; color: #ffffff">
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Products</th>
                                                    <th style="text-align: center">Sale Price</th>
                                                    <th style="text-align: center">Purchase Price</th>
                                                    <th style="text-align: center">Offer</th>
                                                    <th style="text-align: center">Unit Profit</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Total Profit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    String date1 = request.getParameter("date1");
                                                    String date2 = request.getParameter("date2");
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select BRAND, MODEL, PRICE, COST_PRICE, count(*) as qty, (PRICE-COST_PRICE) as uprofit, sum(DISCOUNT) as dis"
                                                                + " from mobilesell where SELL_DATE between '" + date1 + "'  and '" + date2 + "'  group by MODEL, COST_PRICE, PRICE";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                    
                                                %>

                                                <tr>
                                                    <td style="text-align: center">  </td>
                                                    <td style="text-align: center"><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%> </td>
                                                    <td style="text-align: center"><%= rs.getLong("PRICE")%>  </td>
                                                    <td style="text-align: center"> <%= rs.getLong("COST_PRICE")%> </td>
                                                    <th style="text-align: center"> <%= rs.getLong("dis")%> </th>
                                                    <td style="text-align: center"> <%= rs.getLong("uprofit")%> </td>
                                                    <th style="text-align: center"> <%= rs.getInt("qty")%> </th>
                                                    <th style="text-align: center"><%= (rs.getLong("PRICE")-rs.getLong("COST_PRICE")) * rs.getLong("qty")-rs.getLong("dis")%> </th>
                                                    
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
                                            
                                            </tbody>
                                            <tfoot>
                                            <%                                                    
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(PRICE-COST_PRICE-DISCOUNT) as profit, count(PRODUCT_ID) as tqty, sum(DISCOUNT) as totaldis"
                                                                + " from mobilesell where SELL_DATE between '" + date1 + "'  and '" + date2 + "'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                            request.setAttribute("profit", rs.getFloat("profit"));
                                                            request.setAttribute("dis", rs.getFloat("totaldis"));
                                                %>
                                            
                                                <tr style="background-color: #030303; color: #ffffff">
                                                    <th></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center">TOTAL</th>
                                                    <th style="text-align: center"><%= rs.getLong("totaldis") %></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"><%= rs.getInt("tqty") %></th>
                                                    <th style="text-align: center"><%= rs.getLong("profit") %></th>
                                                </tr>
                                                 <%                                                            }
                                                        } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                    %>
                                            </tfoot>
                                        </table>
                                        
                                        <br>
                                                                              
                                                        <%
                                                            con = Ssymphonyy.getConnection();
                                                            try {

                                                                String query = "select sum(AMOUNT) as tcost from cost where DATE between '" + date1 + "'  and '" + date2 + "'";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                                request.setAttribute("tcost", rs.getFloat("tcost"));
                                                      
                                                                }
                                                            } catch (Exception ex) {
                                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                        %>  
                                                        
                                                        <h4 style=" margin-left: 80%"><b>Nit Profit</b> = ${profit-dis-tcost}</h4>
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
