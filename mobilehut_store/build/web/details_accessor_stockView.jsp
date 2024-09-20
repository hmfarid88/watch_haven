
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
            <center>
                <div class="panel panel-primary" style="width: 100%">
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
                                <li><a data-toggle="collapse" data-target="#demo2"  href="#">Price Update</a> </li>
                                <li><a href="#" data-toggle="collapse" data-target="#demo3" >Rate Change</a> </li>
                                <li>
                                    <div style="margin: 10px 0" id="demo2" class="collapse">
                                   <form class=" form-inline" method="POST" action="AccessorUpdate">
                                <select style="width: 250px"  name="pname"  class="form-control input-sm select2"  required="" >
                            <option value="">Select Accessories</option>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select distinct PRODUCT_NAME from accessoriesstock ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("PRODUCT_NAME")%>"><%= rs.getString("PRODUCT_NAME")%></option>
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
                            <input style="max-width: 115px"  type="number" class="form-control input-sm" name="pprice" value="" required="" placeholder="Purhase Price">
                <input style="max-width: 115px" type="number" class="form-control input-sm" name="sprice" value="" required="" placeholder="Sale Price">
                <input type="submit"  class="btn btn-primary btn-sm" value="Ok">
                    </form>
                                    </div>  
                                </li>
                                <li>
                                    <div style="margin: 10px 0" id="demo3" class="collapse">
                                   <form class=" form-inline" method="POST" action="AccRateIncrease">
                                   <input type="text" class="form-control input-sm" name="acname" value="" required="" placeholder="Product Id">
                            
                <input style="max-width: 115px" type="number" class="form-control input-sm" name="sprice" value="" required="" placeholder="Sale Price">
                <input type="submit"  class="btn btn-primary btn-sm" value="Ok">
                    </form>
                                    </div>  
                                </li>
                                 <li><a data-toggle="collapse" data-target="#ftdiv"  href="#">Add-to-Faulty</a>  </li>
                                <li>
                                    <div style="margin: 10px 5px" id="ftdiv" class="collapse" >
                                        <form method="POST" action="accessor_faulty_send.jsp" class="form-inline"> 
                                            <input type="text" class="form-control" size="10px" name="faulty"  placeholder="Product ID" value="" required="" >
                                            <input type="submit" id="add" class="btn btn-primary btn-sm" value="Add">
                                        </form>  
                                    </div>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>

                    <div class="panel-body">

                        <div class="row">
                            <div id="div_print">
                                <center>
                                    <h3>Details Accessories View </h3>
                                    <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                    <hr style="background-color: green">
                                    <table border="2" id="mobiletable" class=" table-striped table-responsive" width="95%" >
                                        <thead>
                                            <tr style="background-color: #030303; color: #ffffff">
                                                <th style="text-align: center">SN</th>
                                                <th style="text-align: center">Product Name</th>
                                                <th style="text-align: center">Product ID</th>
                                                <th style="text-align: center">Vendor</th>
                                                <th style="text-align: center">Qty</th>
                                                <th style="text-align: center">Cost Price</th>
                                                <th style="text-align: center">Sale Price</th>
                                                <th style="text-align: center">Entry Date</th>

                                            </tr>
                                        </thead> 
                                        <tbody id="myTable">
                                        <%
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, DATE "
                                                        + " from accessoriesstock order by DATE DESC,PRODUCT_NAME";
                                                ps=con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <tr>
                                            <td style="text-align: center"></td>
                                            <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%></td>
                                            <td style="text-align: center"><%= rs.getString("PRODUCT_ID")%></td>
                                            <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                                            <th style="text-align: center">1</th>
                                            <th style="text-align: center"><%= rs.getFloat("COST_PRICE")%></th>
                                            <th style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></th>
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
            </center>
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
