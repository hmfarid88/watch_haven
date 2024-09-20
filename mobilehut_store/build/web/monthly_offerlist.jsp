
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
                                <li><a data-toggle="modal" data-target="#datewiseoffer" href="#"><span class="fa fa-calendar"></span> Datewise</a></li>
                              
                            <li><a data-toggle="collapse" data-target="#demo2"  href="#"><span class="fa fa-transgender "></span> Offer-Receive</a> </li>
                                <li>
                                    <div style="margin: 10px 0" id="demo2" class="collapse">
                                   <form class=" form-inline" method="POST" action="OfferReceiv">
                                <select   name="brand"  class="form-control input-sm"  required="" >
                            <option value="">Select Brand</option>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select distinct BRAND from mobilesell where DISCOUNT>0";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("BRAND")%>"><%= rs.getString("BRAND")%></option>
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
                            <input style="max-width: 115px"  type="number" class="form-control input-sm" name="amount" value="" required="" placeholder="Amount">
                            <input type="submit"  class="btn btn-primary btn-sm" value="Ok">
                    </form>
                                    </div>  
                                </li>
                                <li><a href="offer_recevDetails.jsp"><span class="fa fa-list-alt"></span> Receive-Details</a></li>
                            </ul>
                           <ul class="nav navbar-nav navbar-right">
                               <li style=" margin: 15px 60px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
                    <div class="panel-body"> 

                        <div class="row">
                            <div class="col-sm-12">
                                <div id="div_print">
                                    <center>
                                        <h3>Brand Wise Offer List</h3>
                    
                                         <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                       
                                        <table border="2" class=" table-striped table-responsive" width="100%" id="mobiletable" >
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Brand Name</th>
                                                    <th style="text-align: center">Offer Name</th>
                                                    <th style="text-align: center">Qty</th>
                                                    <th style="text-align: center">Offer Amount</th>
                                                    <th style="text-align: center">Receive</th>
                                                    <th style="text-align: center">Balance</th>
                                                </tr>
                                            </thead> 
                                             <tbody id="myTable">
                                                <%
                                                    
                                                    ResultSet rs1=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select BRAND, DIS_NOTE, count(PRODUCT_ID), sum(DISCOUNT) from mobilesell where DISCOUNT>0  group by BRAND";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                        String brand=rs.getString("BRAND");
                                                            String query1="select sum(AMOUNT) from offer_recev where BRAND=?";
                                                            ps=con.prepareStatement(query1);
                                                            ps.setString(1, brand);
                                                            rs1=ps.executeQuery();
                                                            rs1.next();
                                                %>
                                                <tr>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"><%= rs.getString("BRAND")%></td>
                                                    <td style="text-align: center"><%= rs.getString("DIS_NOTE")%></td>
                                                    <th style="text-align: center"><%= rs.getInt(3) %></th>
                                                    <th style="text-align: center"><%= rs.getFloat(4)%></th>
                                                    <th style="text-align: center"><%= rs1.getFloat(1) %></th>
                                                    <th style="text-align: center"><%= rs.getFloat(4)-rs1.getFloat(1) %></th>
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
                                                        <td style="text-align: center"></td>
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
   <div id="datewiseoffer" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Date Wise Offer</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="datewise_offerlist.jsp">
                                <label>Select Date</label><br>
                                <input type="date" autocomplete="off" style="width: 70%" class="form-control" name="date1" value="" placeholder="Start Date" required="" >
                                <label>TO</label> <input type="date" autocomplete="off" class="form-control" style="width: 70%" name="date2" value="" placeholder="End Date" required="" ><br>
                                <input class="btn btn-success btn-sm" type="submit" value="GO">
                            </form>   
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
          <%@include file = "footerpage.jsp" %> 
        </div>

        <script src="js/bootstrap.min.js"></script>
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
                $('#mobiletable tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>
        
        <% } %>
    </body>
</html>
