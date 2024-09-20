
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
                          <li><a data-toggle="collapse" data-target="#datediv101" href="#">Details-View</a></li>
                                <li style="margin-top: 10px">
                                    <div id="datediv101" class="collapse">
                                        <form action="Datewise_vendor_statement.jsp" method="POST" class="form-inline">
                                            <input type="hidden" name="vendor" value="${param.vendor}">
                                            <input type="date" autocomplete="off" size="10px" class="form-control" name="date1" value="" required="" placeholder="Start Date" >
                                            <label>TO</label> <input type="date" autocomplete="off" size="10px" class="form-control" name="date2" value="" required="" placeholder="End Date" >
                                            <input type="submit" class="btn btn-primary btn-sm" value="View">
                                        </form> 

                                    </div>
                                </li>
                                <li><a data-toggle="collapse" data-target="#datediv1010" href="#">Date Wise-View</a></li>
                                <li style="margin-top: 10px">
                                    <div id="datediv1010" class="collapse">
                                        <form action="Datewise_vendorstatement.jsp" method="POST" class="form-inline">
                                            <input type="hidden" name="vendor" value="${param.vendor}">
                                            <input type="date" autocomplete="off" size="10px" class="form-control" name="date1" value="" required="" placeholder="Start Date" >
                                            <label>TO</label> <input type="date" autocomplete="off" size="10px" class="form-control" name="date2" value="" required="" placeholder="End Date" >
                                            <input type="submit" class="btn btn-primary btn-sm" value="View">
                                        </form> 

                                    </div>
                                </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                             <li style="margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
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
                                    <center><h4><div id="date"> </div> </h4></center>
                                    <hr>
                                    <table border="2" class=" table-striped table-responsive" width="90%" id="mobiletable" >
                                        <thead>
                                            <tr style="background-color: #CCCCCC">
                                                <th style="text-align: center">SN</th>
                                                <th style="text-align: center">Date</th>
                                                <th style="text-align: center">Qty</th>
                                                <th style="text-align: center">Amount</th>
                                                <th style="text-align: center">Payment</th>
                                                <th style="text-align: center">Balance</th>
                                            </tr>
                                        </thead> 
                                        <tbody id="myTable">
                                            <%
                                                
                                                String vendor = request.getParameter("vendor");
                                                Connection con = null;
                                                PreparedStatement ps = null;
                                                ResultSet rs=null;
                                                ResultSet rs1=null;
                                                ResultSet rs2=null;
                                                ResultSet rs3=null;
                                                ResultSet rs4=null;
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String date="select DATE from vendor_stock where VENDOR='" + vendor + "' and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())"
                                                            + "UNION select DATE from cashpayment where PAYMENT_NAME='" + vendor + "' and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE";
                                                    ps=con.prepareStatement(date);
                                                    rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                        String date1=rs.getString("DATE");
                                                        String qty="select  count(*) as qty, sum(PURCHASE_PRICE) as value from vendor_stock  where VENDOR='" + vendor + "' and DATE='"+ date1 +"'";
                                                        ps=con.prepareStatement(qty);
                                                        rs1 = ps.executeQuery();
                                                        rs1.next();
                                                        String payment="select  sum(AMOUNT) as ttamount from cashpayment  where PAYMENT_NAME='" + vendor + "' and DATE='"+ date1 +"'";
                                                        ps=con.prepareStatement(payment);
                                                        rs2 = ps.executeQuery();
                                                        rs2.next();
                                                        String total="select sum(PURCHASE_PRICE) from vendor_stock  where VENDOR='" + vendor + "' and DATE<='"+ date1 +"'";
                                                        ps=con.prepareStatement(total);
                                                        rs3 = ps.executeQuery();
                                                        rs3.next();
                                                        String balance="select  sum(AMOUNT) from cashpayment  where PAYMENT_NAME='" + vendor + "' and DATE<='"+ date1 +"'";
                                                        ps=con.prepareStatement(balance);
                                                        rs4 = ps.executeQuery();
                                                        rs4.next();
                                            %>
                                            <tr>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                <th style="text-align: center"><%=rs1.getInt("qty") %></th>
                                                <th style="text-align: center"><%= rs1.getFloat("value") %></th>
                                                <th style="text-align: center"><%= rs2.getFloat("ttamount") %></th>
                                                <th style="text-align: center"><%= rs3.getLong(1)-rs4.getLong(1) %></th>
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
                                                 <th style="text-align: center">TOTAL</th>
                                                 <td style="text-align: center"></td>
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
     <script>
        window.onload = function () {
        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                            ;
        var date = new Date();

        document.getElementById('date').innerHTML = months[date.getMonth()] + ' ' + date.getFullYear();
                                                };
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
