
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DB.Ssymphonyy"%>
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
        <div id="main" class="container-fluid">
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
                                
                                <li style="margin-left: 10px"><a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>
                                <li id="drop"><a  href="#">Back-to-Stock</a>
                                    <div  id="dropdown" class=" dropdown-menu" >
                                        <a data-toggle="collapse" data-target="#sb" href="#">Phone</a>
                                        <a data-toggle="collapse" data-target="#acsb" href="#">Accessories</a>
                                </div>
                                </li>
                                  <li style="margin-top: 10px">
                                    <div id="sb" class="collapse">
                                        <form method="POST" action="BackStockServlet" class="form-inline">
                                            <input type="text" size="10px" name="backime"  class="form-control"  value="" placeholder="Input IMEI"  required="" autofocus="">
                                           <input type="submit" id="fsend" class="btn btn-primary btn-sm" value="Send">
                                       </form> 
                                       
                                    </div>
                                </li>
                                <li style="margin-top: 10px">
                                    <div id="acsb" class="collapse">
                                        <form method="POST" action="Acce_FaultyBackServlet" class="form-inline">
                                            <input type="text" size="10px" name="backid"  class="form-control"  value="" placeholder="Input Product ID"  required="" autofocus="">
                                           <input type="submit"  class="btn btn-primary btn-sm" value="Send">
                                       </form> 
                                       
                                    </div>
                                </li>                      
                            </ul>
                           <ul class="nav navbar-nav navbar-right">
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                        </div>

                    </nav>
            <center>
                <div class="panel panel-primary" style="width: 100%">
                    
                    <div class="panel-body">
                          <div id="div_print">
                              <center>
                        <h3>Faulty Products</h3>
                      <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                     <hr style="background-color: green">
                     <h4>Mobile Phone</h4>
                     <table class="table-striped" id="mytable" border="2" width="95%" class="table-responsive" >
                         <thead>
                            <tr style="background-color: #030303; color: #ffffff">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Model</th>
                                <th style="text-align: center">Color</th>
                                <th style="text-align: center">IMEI</th>
                                <th style="text-align: center">Purchase Price</th>
                                <th style="text-align: center">Sale Price</th>
                                <th style="text-align: center">Vendor</th>
                                <th style="text-align: center">Stock Date</th>
                                <th style="text-align: center">Faulty Date</th>
                            </tr>
                        </thead> 
                        <%
                            Connection con = null;
                            PreparedStatement ps = null;
                            ResultSet rs=null;
                            try {
                                con = Ssymphonyy.getConnection();
                                String query = "select BRAND, MODEL, COLOR, IMEI, COST_PRICE, SELL_PRICE, VENDOR, STOCK_DATE, DATE from faulty";
                                ps=con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%></td>
                            <td style="text-align: center"><%= rs.getString("COLOR")%></td>
                            <td style="text-align: center"><%= rs.getString("IMEI")%></td>
                            <td style="text-align: center"><%= rs.getFloat("COST_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                            <td style="text-align: center"><%= rs.getString("STOCK_DATE")%></td>
                            <td style="text-align: center"><%= rs.getString("DATE")%></td>
                        </tr>

                        <%
                                }
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                        <tr style="background-color: #030303; color: #ffffff">
                            <th></th>
                            <th></th>
                            <th style="text-align: center">Total</th>

                            <%
                                try {
                                   con = Ssymphonyy.getConnection();
                                   String query = "select  count(IMEI) as qnty, sum(COST_PRICE) as tcost, sum(SELL_PRICE) as tprice from faulty ";
                                   ps=con.prepareStatement(query); 
                                   rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <th style="text-align: center"><%= rs.getInt("qnty")%></th>
                            <th style="text-align: center"><%= rs.getFloat("tcost")%></th>
                            <th style="text-align: center"><%= rs.getFloat("tprice")%></th>
                            
                                <%
                                        }
                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>  
                        </table>
                            <h4>Accessories</h4>
                            <table class="table-striped" id="actabletable" border="2" width="95%" class="table-responsive" >
                             <thead>
                            <tr style="background-color: #030303; color: #ffffff">
                                <th style="text-align: center">SI No</th>
                                <th style="text-align: center">Description</th>
                                <th style="text-align: center">Product ID</th>
                                <th style="text-align: center">Purchase Price</th>
                                <th style="text-align: center">Sale Price</th>
                                <th style="text-align: center">Vendor</th>
                                <th style="text-align: center">Stock Date</th>
                                <th style="text-align: center">Faulty Date</th>
                                                            
                            </tr>
                        </thead>  
                        <%
                           
                            try {
                                con = Ssymphonyy.getConnection();
                                String query = "select PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, STOCK_DATE, DATE from accessor_faulty";
                                ps=con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%></td>
                            <td style="text-align: center"><%= rs.getString("PRODUCT_ID")%></td>
                            <td style="text-align: center"><%= rs.getFloat("COST_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                            <td style="text-align: center"><%= rs.getString("STOCK_DATE")%></td>
                            <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                       
                        </tr>

                        <%
                                }
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                        <tr style="background-color: #030303; color: #ffffff">
                            <th></th>
                           <th style="text-align: center">Total</th>

                            <%
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select  count(PRODUCT_ID) as aaqnty, sum(COST_PRICE) as actcost, sum(SELL_PRICE) as actprice from accessor_faulty ";
                                    ps=con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <th style="text-align: center"><%= rs.getInt("aaqnty")%></th>
                            <th style="text-align: center"><%= rs.getFloat("actcost")%></th>
                            <th style="text-align: center"><%= rs.getFloat("actprice")%></th>
                            
                                <%
                                        }
                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                            <th></th>
                            <th></th>
                            <th></th>
                            </tr>  
                            </table>
                              </center>
                          </div>
                    </div>
                </div>
            </center>
            <%@include file = "footerpage.jsp" %> 
        </div>

        <script src="js/bootstrap.min.js"></script>
        
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
                $('#actabletable tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('#mytable tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>
               
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
