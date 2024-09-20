
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
                                    <h3>Vendor Statement</h3>
                                    <h4>Vendor Name: ${param.vendor}</h4>
                                    <center><h4>Date : ${param.date1} To ${param.date2}</h4></center>
                                    <hr>
                                    <table border="2" class=" table-striped table-responsive" width="90%" id="mobiletable" >
                                        <thead>
                                            <tr style="background-color: #CCCCCC">
                                                <th style="text-align: center">SN</th>
                                                <th style="text-align: center">Date</th>
                                                <th style="text-align: center">Product</th>
                                                <th style="text-align: center">Qty</th>
                                                <th style="text-align: center">Price</th>
                                                
                                            </tr>
                                        </thead> 
                                        <tbody id="myTable">
                                            <%
                                                String date1=request.getParameter("date1");
                                                String date2=request.getParameter("date2");
                                                String vendor = request.getParameter("vendor");
                                                Connection con = null;
                                                PreparedStatement ps = null;
                                                ResultSet rs=null;
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select  PRODUCT, PRODUCT_ID, PURCHASE_PRICE, DATE from vendor_stock where VENDOR='" + vendor + "' and DATE between '"+ date1 +"' and '"+ date2 +"' order by DATE";
                                                    ps=con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>
                                            <tr>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                <td style="text-align: center"><%= rs.getString("PRODUCT")%>, <%= rs.getString("PRODUCT_ID")%></td>
                                                <th style="text-align: center">1</th>
                                                <th style="text-align: center"><%= rs.getFloat("PURCHASE_PRICE")%></th>
                                                
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
                                             <tr style="background-color: #CCCCCC">
                                                 <th style="text-align: center"></th>
                                                 <th style="text-align: center"></th>
                                                 <th style="text-align: center">TOTAL</th>
                                                 <td style="text-align: center"></td>
                                                 <td style="text-align: center"></td> 
                                                 
                                             </tr>
                                            </tfoot>
                                    </table><br>
                                    <h4>Payment List</h4>
                                    <table border="2" class=" table-striped table-responsive" width="90%" id="paymenttable" >
                                        <thead>
                                            <tr style="background-color: #CCCCCC">
                                                <th style="text-align: center">SN</th>
                                                <th style="text-align: center">Date</th>
                                                <th style="text-align: center">Amount</th>
                                            </tr>
                                        </thead> 
                                        <tbody>
                                            <%
                                               
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select  AMOUNT, DATE  from cashpayment where PAYMENT_NAME='" + vendor + "' and  DATE between '"+ date1 +"' and '"+ date2 +"' order by DATE";
                                                    ps=con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>
                                            <tr>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                <th style="text-align: center"><%= rs.getFloat("AMOUNT")%></th>
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
                                            <tr style="background-color: #cccccc">
                                                <th style="text-align: center"></th>
                                                <th style="text-align: center">TOTAL</th>
                                                <td style="text-align: center"></td>
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
        $(document).ready(function() {
            $('#paymenttable thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#paymenttable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#paymenttable tfoot td').eq(index).text(total);
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
            $('#paymenttable tr').each(function (index) {
                $(this).find('td:nth-child(1)').html(index - 1 + 1);
            });
        };

        addSerialNumber();
    </script>
    <% }%>
</body>
</html>
