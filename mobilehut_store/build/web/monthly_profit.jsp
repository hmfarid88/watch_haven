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
                                        <h3>Monthly Profit Report</h3> 
                                        <center><h4><div id="date"> </div> </h4></center>
                                        <h4><b>Mobile Phone</b></h4>

                                        <table  border="2" width="95%" class="table-condensed table-responsive myTables" >
                                            <thead>
                                                <tr style=" background-color: #030303; color: #ffffff">
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Products</th>
                                                    <th style="text-align: center">Sale Price</th>
                                                    <th style="text-align: center">Purchase Price</th>
                                                    <th style="text-align: center">Unit Profit</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Company Offer</th>
                                                    <th style="text-align: center">Total Profit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select BRAND, MODEL, PRICE, COST_PRICE, count(*) as qty, (PRICE-COST_PRICE) as uprofit, sum(DISCOUNT) as dis"
                                                                + " from mobilesell where YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())  group by MODEL, COST_PRICE, PRICE";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                    
                                                %>

                                                <tr>
                                                    <td style="text-align: center">  </td>
                                                    <td style="text-align: center"><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%> </td>
                                                    <td style="text-align: center"><%= rs.getLong("PRICE")%>  </td>
                                                    <td style="text-align: center"> <%= rs.getLong("COST_PRICE")%> </td>
                                                    <td style="text-align: center"> <%= rs.getLong("uprofit")%> </td>
                                                    <th style="text-align: center"> <%= rs.getInt("qty")%> </th>
                                                    <th style="text-align: center"> <%= rs.getLong("dis")%> </th>
                                                    <th style="text-align: center"><%= (rs.getLong("PRICE")-rs.getLong("COST_PRICE")) * rs.getLong("qty")%> </th>
                                                    
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
                                                        String query = "select sum(PRICE-COST_PRICE) as profit, count(PRODUCT_ID) as tqty, sum(DISCOUNT) as totaldis"
                                                                + " from mobilesell where YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                            
                                                <tr style="background-color: #030303; color: #ffffff">
                                                    <th></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center">TOTAL</th>
                                                    <th style="text-align: center"><%= rs.getInt("tqty") %></th>
                                                    <th style="text-align: center"><%= rs.getLong("totaldis") %></th>
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
                                        <h4><b>Accessories</b></h4>

                                        <table  border="2" width="95%" class="table-condensed table-responsive myacTables" >
                                            <thead>
                                                <tr style=" background-color: #030303; color: #ffffff">
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Products</th>
                                                    <th style="text-align: center">Sale Price</th>
                                                    <th style="text-align: center">Purchase Price</th>
                                                    <th style="text-align: center">Unit Profit</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Discount</th>
                                                    <th style="text-align: center">Total Profit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    
                                                 try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select PRODUCT_NAME, SELL_PRICE, COST_PRICE, sum(DISCOUNT) as dss, count(*) as aqty, SELL_PRICE-COST_PRICE as auprofit"
                                                                + " from accessor_sale where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) group by PRODUCT_NAME, COST_PRICE, SELL_PRICE";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {

                                                %>

                                                <tr>
                                                    <td style="text-align: center">  </td>
                                                    <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%></td>
                                                    <td style="text-align: center"><%= rs.getLong("SELL_PRICE")%>  </td>
                                                    <td style="text-align: center"><%= rs.getLong("COST_PRICE")%> </td>
                                                    <td style="text-align: center"><%= rs.getLong("auprofit")%> </td>
                                                    <th style="text-align: center"><%= rs.getInt("aqty")%> </th>
                                                    <th style="text-align: center"><%= rs.getLong("dss")%> </th>
                                                    <th style="text-align: center"><%= (rs.getLong("auprofit")* rs.getLong("aqty"))-rs.getLong("dss") %> </th>

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
                                                        String query = "select sum(SELL_PRICE-COST_PRICE) as aprofit, sum(DISCOUNT) as ttdis, count(PRODUCT_ID) as atqty"
                                                                + " from accessor_sale where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                            <tr style="background-color: #030303; color: #ffffff">
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center">TOTAL</th>
                                                    <th style="text-align: center"><%= rs.getInt("atqty") %></th>
                                                    <th style="text-align: center"><%= rs.getLong("ttdis") %></th>
                                                    <th style="text-align: center"><%= rs.getLong("aprofit")-rs.getLong("ttdis") %></th>
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
                                        <h4><b>Net Profit</b></h4>
                                        <table  border="2" id="sumtable" width="95%" class="table-condensed table-responsive" >
                                            <thead>
                                                <tr style=" background-color: #030303; color: #ffffff">
                                                    <th Style="text-align: center">Item</th>
                                                    <th Style="text-align: center">Quantity</th>
                                                    <th Style="text-align: center">Total Sale Price</th>
                                                    <th Style="text-align: center">Total Purchase Price</th>
                                                    <th Style="text-align: center">Total Profit</th>
                                                    <th Style="text-align: center">In (%)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th Style="text-align: center">Mobile Phone</th>
                                                        <%                                                            
                                                            try {
                                                                con = Ssymphonyy.getConnection();
                                                                String query = "select sum(PRICE) as saleprice, sum(COST_PRICE) as cost, count(PRODUCT_ID) as tqty"
                                                                        + " from mobilesell where YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE()) ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                                    request.setAttribute("mqnt", rs.getInt("tqty"));
                                                                    request.setAttribute("msale", rs.getFloat("saleprice"));
                                                                    request.setAttribute("mcost", rs.getFloat("cost"));
                                                        %>
                                                    <td Style="text-align: center"><%= rs.getInt("tqty")%></td>
                                                    <td Style="text-align: center"><%= rs.getFloat("saleprice")%></td>
                                                    <td Style="text-align: center"><%= rs.getFloat("cost")%></td>
                                                    <td Style="text-align: center"><%= rs.getFloat("saleprice") - rs.getFloat("cost")%></td>
                                                    <td Style="text-align: center"><%= ((rs.getFloat("saleprice") - rs.getFloat("cost"))*100)/rs.getFloat("cost") %> %</td>
                                                    <%                  }
                                                        } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                                                    %>
                                                </tr>
                                                <tr>
                                                    <th Style="text-align: center">Accessories</th>
                                                        <%                                                            
                                                            try {
                                                                con = Ssymphonyy.getConnection();
                                                                String query = "select sum(SELL_PRICE) as asaleprice, sum(COST_PRICE) as acost, sum(DISCOUNT) as acsordis, count(PRODUCT_ID) as atqty"
                                                                        + " from accessor_sale where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                                    request.setAttribute("aqnt", rs.getInt("atqty"));
                                                                    request.setAttribute("asale", rs.getFloat("asaleprice"));
                                                                    request.setAttribute("acost", rs.getFloat("acost"));
                                                                    request.setAttribute("acsordis", rs.getFloat("acsordis"));

                                                        %>

                                                    <td Style="text-align: center"><%= rs.getInt("atqty")%></td>
                                                    <td Style="text-align: center"><%= rs.getFloat("asaleprice")%></td>
                                                    <td Style="text-align: center"><%= rs.getFloat("acost")%> </td>
                                                    <td Style="text-align: center"><%= rs.getFloat("asaleprice") - (rs.getFloat("acost")+rs.getFloat("acsordis"))%></td>
                                                    <td Style="text-align: center"><%= ((rs.getFloat("asaleprice") - (rs.getFloat("acost")+rs.getFloat("acsordis")))*100)/rs.getFloat("acost") %> %</td>
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
                                       
                                                <tr>

                                                    <th Style="text-align: center">Total</th>
                                                    <td Style="text-align: center">${mqnt+aqnt}</td>
                                                    <td Style="text-align: center">${msale+asale}</td>
                                                    <td Style="text-align: center">${mcost+acost}</td>
                                                    <td Style="text-align: center">${(msale+asale)-(mcost+acost+acsordis)}</td>
                                                    <td Style="text-align: center">${(((msale+asale)-(mcost+acost+acsordis))*100)/(mcost+acost)} %</td>
                                                </tr> 
                                                <tr>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-left-style: hidden; border-right-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-left-style: hidden; border-right-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-right-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-left-style: hidden; border-right-style: hidden "><u>( - ) Total Cost :</u> </th>


                                                    <th  style=" text-align: center;border-bottom-style: hidden; border-right-style: hidden">
                                                        <%
                                                            con = Ssymphonyy.getConnection();
                                                            try {

                                                                String query = "select sum(AMOUNT) as tcost from cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                                request.setAttribute("tcost", rs.getFloat("tcost"));
                                                        %> 

                                                        <%
                                                                }
                                                            } catch (Exception ex) {
                                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                        %>  
                                                        <%
                                                            con = Ssymphonyy.getConnection();
                                                            try {

                                                                String query = "select sum(AMOUNT) as pcost from profit_cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                                request.setAttribute("pcost", rs.getFloat("pcost"));
                                                        %> 

                                                        <u>${tcost+pcost}</u>
                                                        <%
                                                                }
                                                            } catch (Exception ex) {
                                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                        %>  
                                                    </th>

                                                </tr>

                                                <tr>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-left-style: hidden; border-right-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-left-style: hidden; border-right-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-right-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden"></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden;border-left-style: hidden"><u>Net Profit : </u></th>
                                                    <th style=" text-align: center; border-bottom-style: hidden; border-left-style: hidden; border-right-style: hidden"><u>${((msale+asale)-(mcost+acost+acsordis))-(tcost+pcost)}</u> | (<u>${(((msale+asale)-(mcost+acost+acsordis))-(tcost+pcost))*100/(mcost+acost)} </u> %)</th>

                                                </tr>
                                   
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
        <script>
        window.onload = function () {
        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                            ;
        var date = new Date();

        document.getElementById('date').innerHTML = months[date.getMonth()] + ' ' + date.getFullYear();
                                                };
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
