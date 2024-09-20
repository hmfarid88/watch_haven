<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.io.File"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
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
                                
                                <li style="margin-left: 20px"><a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>
                                <li><a href="#" data-toggle="collapse" data-target="#demo2" >Price Update</a> </li>
                                <li><a href="#" data-toggle="collapse" data-target="#demo3" >Rate Increase</a> </li>
                                <li>
                                    <div style="margin: 10px 0" id="demo2" class="collapse">
                                   <form class=" form-inline" method="POST" action="StockRateUpdate">
                                <select style="width: 250px"  name="mname"  class="form-control input-sm select2"  required="" >
                            <option value="">Select Model</option>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select distinct MODEL, BRAND from stock ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("MODEL")%>"><%= rs.getString("BRAND")%>,<%= rs.getString("MODEL")%></option>
                            <%
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>

                        </select>
                            <input style="max-width: 115px"  type="number" class="form-control input-sm" name="pprice" value="" required="" placeholder="Purchase Price">
                <input style="max-width: 115px" type="number" class="form-control input-sm" name="sprice" value="" required="" placeholder="Sale Price">
                <input type="submit"  class="btn btn-primary btn-sm" value="Ok">
                    </form>
                                    </div>  
                                </li>
                                <li>
                                    <div style="margin: 10px 0" id="demo3" class="collapse">
                                   <form class=" form-inline" method="POST" action="RateIncrease">
                                <select style="width: 250px"  name="mname"  class="form-control input-sm select2"  required="" >
                            <option value="">Select Model</option>
                            <%
                                
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select distinct MODEL, BRAND from stock ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("MODEL")%>"><%= rs.getString("BRAND")%>,<%= rs.getString("MODEL")%></option>
                            <%
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>

                        </select>
                            
                <input style="max-width: 115px" type="number" class="form-control input-sm" name="sprice" value="" required="" placeholder="Sale Price">
                <input type="submit"  class="btn btn-primary btn-sm" value="Ok">
                    </form>
                                    </div>  
                                </li>
                                <li><a data-toggle="collapse" data-target="#ftdiv"  href="#">Add-to-Faulty</a>  </li>
                                <li>
                                    <div style="margin: 10px 5px" id="ftdiv" class="collapse" >
                                        <form method="POST" action="FaultyServlet" class="form-inline"> 
                                            <input type="text" pattern="[0-9]{15}" maxlength="15" minlength="15" class="form-control" size="10px" name="faulty"  placeholder="Input IMEI" value="" required="" >
                                            <input type="submit"  class="btn btn-primary btn-sm" value="Add">
                                        </form>  
                                       
                                    </div>  
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li> <a name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
            
            <br><div id="div_print">
                <center>
                    <h3>Stock Details </h3>
                    <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                    <hr>
                    <table  border="2" id="mobiletable" class=" table-striped table-responsive" width="95%" >
                        <thead>
                            <tr style="background-color: #030303; color: #ffffff">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Brand</th>
                                <th style="text-align: center">Model</th>
                                <th style="text-align: center">Color</th>
                                <th style="text-align: center">IMEI</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">Purchase Price</th>
                                <th style="text-align: center">Sale Price</th>
                                <th style="text-align: center">Vendor</th>
                                <th style="text-align: center">Entry Date</th>
                            </tr>
                        </thead> 
                        <%
                           String demo="Demo";
                            try {
                                con = Ssymphonyy.getConnection();
                                String query = "select BRAND, MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, DATE from stock where MODEL not like '%"+ demo +"%' order by DATE DESC, MODEL ";
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tbody id="myTable">
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("BRAND")%></td>
                            <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                            <td style="text-align: center"><%= rs.getString("COLOR")%></td>
                            <td style="text-align: center"><%= rs.getString("IMEI")%></td>
                            <th style="text-align: center">1</th>
                            <th style="text-align: center"><%= rs.getString("PURCHASE_PRICE")%></th>
                            <th style="text-align: center"><%= rs.getString("SELL_PRICE")%></th>
                            <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                            <td style="text-align: center"><%= rs.getString("DATE")%></td>
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
                        <tfoot>
                            <tr style="background-color: #030303; color: #ffffff">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center">TOTAL</th>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><b></b></td>
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                            </tr>
                        </tfoot>
                        
                   </table>
                </center>
            </div><br>
            <%@include file = "footerpage.jsp" %> 
        </div>
        
        <script src="js/bootstrap.min.js"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
         <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
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
    $('.select2').select2();
    </script>
        <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('table thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        } 
  });
});
        </script>
        <script>
        $(document).ready(function() {
            $('table thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
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
       
        <% } %>
    </body>
</html>
