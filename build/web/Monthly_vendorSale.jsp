
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
                                <li><a data-toggle="collapse" data-target="#ddiv" href="#">Date-Wise-View</a></li>
                                <li style="margin-top: 10px"><div id="ddiv" class="collapse">
                                        <form action="datewise_vendorSale.jsp" method="POST" class="form-inline">
                                            <input type="date" autocomplete="off" size="10px" class="form-control"  name="date1" value="" required="" placeholder="Start Date" >
                                            <label>to</label> <input type="date" autocomplete="off" size="10px" class="form-control" name="date2" value="" required="" placeholder="End Date" >
                                            <input type="submit" class="btn btn-primary btn-sm" value="View">
                                        </form> 
                                    </div>
                                </li>
                               
                                <li id="drop"><a href="#">Add-to-Stock</a>
                                      <div  id="dropdown" class=" dropdown-menu" >
                                        <a data-toggle="collapse" data-target="#faultyview" href="#">Mobile Phone</a>
                                        <a data-toggle="collapse" data-target="#accfaultydiv" href="#">Accessories</a>
                                      </div>
                                </li>
                                <li>
                                <div id="faultyview" class="collapse" style="margin:10px 10px">
                                    <form action="VendorM_sale_delete.jsp" method="POST" class="form-inline"> 
                                        <input type="text" class="form-control" size="10px" name="imei" placeholder="Sold IMEI" value="" required="" data-toggle="tooltip" data-placement="bottom" title="Should be same price's product" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#faultyview" value="Cancel">
                                    </form> 
                                   
                                </div>
                            </li>
                            <li>
                                <div id="accfaultydiv" class="collapse" style="margin:10px 10px">
                                    <form action="VendorA_sale_delete.jsp" method="POST" class="form-inline"> 
                                        <input type="text" class="form-control" size="10px" name="soldid" placeholder="Sold Product ID" value="" required="" data-toggle="tooltip" data-placement="bottom" title="Should be same price's product" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#accfaultydiv" value="Cancel">
                                    </form> 
                                   
                                </div>
                            </li>
                                                        
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
                    <div class="panel-body"> 

                        <div class="row">
                            <div class="col-sm-12">
                                <div id="div_print">
                                    <center>
                                        <h3>Vendor Sale</h3>
                                     <center><h4><div id="date"> </div> </h4></center>
                                        <hr>
                                        <h4>Mobile Phone</h4>
                                        <table border="2" class=" table-striped table-responsive" width="100%" id="mobiletable" >
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Invoice No</th>
                                                    <th style="text-align: center">Vendor</th>
                                                    <th style="text-align: center">Description</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Price</th>
                                                    <th style="text-align: center">Date</th>
                                                </tr>
                                            </thead> 
                                            <tbody id="myTable">
                                                <%
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    ResultSet rs1=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select  PRODUCT_ID, CUSTOMER_ID, INVOICE_NO, BRAND, MODEL, COLOR, COST_PRICE, SELL_DATE from vendor_sale where YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE()) order by  SELL_DATE ";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                       int cid=rs.getInt(2);
                                                   String query1="select C_NAME, PHONE_NUMBER from customerinfo where CUSTOMER_ID=?";
                                                   ps=con.prepareStatement(query1);
                                                   ps.setInt(1, cid);
                                                   rs1=ps.executeQuery();
                                                   while (rs1.next()) {    
                                                %>
                                                <tr>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"><%= rs.getString("INVOICE_NO")%></td>
                                                    <td style="text-align: center"><%= rs1.getString(1) %>, <%= rs1.getString(2) %></td>
                                                    <td style="text-align: center"><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%>, <%= rs.getString("COLOR")%>, <%= rs.getString("PRODUCT_ID")%></td>
                                                    <th style="text-align: center">1</th>
                                                    <th style="text-align: center"><%= rs.getFloat("COST_PRICE")%></th>
                                                    <td style="text-align: center"><%= rs.getString("SELL_DATE")%></td>
                                                    
                                                </tr>

                                                <%
                                                      }  }
                                                    } catch (Exception ex) {
                                                    }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>
                                            </tbody>
                                            <tfoot>
                                                <tr style="background-color: #CCCCCC">
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center">TOTAL</th>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"></td>
                                                    <th style="text-align: center"></th>
                                                </tr>
                                            </tfoot>
                                           
                                        </table><br>
                                        
                                        <table border="1" width="30%" >
                                            <tr>
                                                <td style="text-align: center"><h4>Accessories</h4></td><td><input style="width: 70%; margin-left: 15%" class="form-control input-sm" id="acInput" type="text" placeholder="Search..."> </td>
                                            </tr>
                                        </table><br>
                                        <table border="2" class=" table-striped table-responsive" width="100%" id="actable" >
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Invoice No</th>
                                                    <th style="text-align: center">Customer</th>
                                                    <th style="text-align: center">Description</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Sale Price</th>
                                                    <th style="text-align: center">Sale Date</th>
                                                </tr>
                                            </thead> 
                                            <tbody id="myTables1">
                                                <%
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select PRODUCT_NAME, PRODUCT_ID,  MODEL, COST_PRICE, INVOICE_NO, CUSTOMER_ID, DATE from vendor_accessor_sale where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE DESC";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                            int cid=rs.getInt(6);
                                                   String query1="select C_NAME, PHONE_NUMBER from customerinfo where CUSTOMER_ID="+cid;
                                                   ps=con.prepareStatement(query1);
                                                   rs1=ps.executeQuery();
                                                   while (rs1.next()) {
                                                %>
                                                <tr>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"><%= rs.getString("INVOICE_NO")%></td>
                                                    <td style="text-align: center"><%= rs1.getString(1) %>, <%= rs1.getString(2) %></td>
                                                    <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%>, <%= rs.getString("PRODUCT_ID")%></td>
                                                    <th style="text-align: center">1</th>
                                                    <th style="text-align: center"><%= rs.getFloat("COST_PRICE")%></th>
                                                    <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                </tr>

                                                <%
                                                      }  }
                                                    } catch (Exception ex) {
                                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>
                                            </tbody>
                                            <tfoot>
                                                <tr style="background-color: #CCCCCC">
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center">TOTAL</th>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"></td>
                                                    <th style="text-align: center"></th>
                                                </tr>
                                            </tfoot>
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
        <script src="js/jquery-3.1.1.min.js"></script>
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
<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        } 
  });
});
</script>
<script>
        $(document).ready(function() {
            $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
    
        function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        }
        });
    </script>                      
<script>
$(document).ready(function(){
  $("#acInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTables1 tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('#actable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#actable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#actable tfoot td').eq(index).text(total);
        } 
  });
});
</script>
<script>
        $(document).ready(function() {
            $('#actable thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#actable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#actable tfoot td').eq(index).text(total);
        }
    </script>                      
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('#mobiletable tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('#actable tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>
      <script>
        window.onload = function () {
        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                            ;
        var date = new Date();

        document.getElementById('date').innerHTML = months[date.getMonth()] + ' ' + date.getFullYear();
                                                };
        </script>        
        <% } %>
    </body>
</html>
