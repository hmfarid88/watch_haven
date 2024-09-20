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
        <script src="js/jquery-3.1.1.min.js"></script>
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

                <div class="panel panel-primary" style="width: 100%; background-color: #CDCBCB">


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
                                <li><a href="totalStock.jsp">Details</a> </li>
                                 
                                <li><a href="requisition.jsp">Requisition</a> </li> 
                                <li><a id="pdf" href="#"> PDF</a></li>
                                <li><a data-toggle="modal" data-target="#exchange" href="#">Exchange</a></li>
                           </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>


                    <div class="panel-body">

                        <div class="row">
                            <center>
                                <div class="col-sm-4"></div>
                                <div class="col-sm-2">
                                    <%
                                            String demo="Demo";    
                                            Connection con = null;
                                            PreparedStatement ps = null;
                                            ResultSet rs=null;
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select count(IMEI) as qnt, sum(PURCHASE_PRICE) as totlprice from stock where MODEL not like '%"+ demo +"%'";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                             request.setAttribute("qty", rs.getInt("qnt"));
                                             request.setAttribute("tlprice", rs.getInt("totlprice"));
                                                }
                                            } catch (Exception ex) {  
                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                        <label>Stock Quantity : </label><input type="text" size="5px" class="text-center form-control" value="${qty} ps " readonly="">  
                                </div>
                                <div class="col-sm-2">
                                    <label>Stock Amount :  </label><input type="text" size="15px" class="text-center form-control" value="TK. ${tlprice} "  readonly="">
                                </div>
                                <div class="col-sm-4"></div>
                                  
                            </center>
                        </div>
                                <div class="row">
                            <div id="div_print">
                                <center>
                                    <h3>Stock Summary </h3>
                                    <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                    <hr style="background-color: green">
                                    <table border="2" id="mobiletable" class=" table-condensed table-responsive" width="90%" >
                                      
                                        <thead>
                                            <tr style="background-color: #030303; color: #ffffff">
                                                <th style="text-align: center">SN</th>
                                                <th style="text-align: center">Model</th>
                                                <th style="text-align: center">Qty</th>
                                                <th style="text-align: center">Unit Cost Price</th>
                                                <th style="text-align: center">Total Cost Price</th>
                                                <th style="text-align: center">Unit Sale Price</th>
                                                <th style="text-align: center">Total Sale Price</th>
                                                <th style="text-align: center">Mark</th>

                                            </tr>
                                        </thead> 
                                        <tbody id="myTable">
                                        <%
                                            
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select BRAND, MODEL, count(*) as ime, PURCHASE_PRICE, SELL_PRICE from stock where MODEL not like '%"+ demo +"%'  group by BRAND, MODEL";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <tr class="txt">
                                            <td style="text-align: center"></td>
                                            <td style="text-align: center"><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%></td>
                                            <th style="text-align: center"><%= rs.getInt("ime")%></th>
                                            <td id="comma" style="text-align: center"><%= rs.getFloat("PURCHASE_PRICE")%></td>
                                            <th style="text-align: center"><%= rs.getFloat("PURCHASE_PRICE")*rs.getInt("ime") %></th>
                                            <td style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></td>
                                            <th style="text-align: center"><%= rs.getFloat("SELL_PRICE")*rs.getInt("ime")%></th>
                                            <td style="text-align: center"></td>
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
                                                <th style="text-align: center">TOTAL</th>
                                                <td style="text-align: center"><b></b></td>
                                                <th style="text-align: center"></th>
                                                <td style="text-align: center"><b></b></td>
                                                <th style="text-align: center"></th>
                                                <td style="text-align: center"><b></b></td>
                                                <th style="text-align: center"></th>
                                            </tr>
                                        </tfoot>
                                            </table>
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
                                </center>
                            </div>
                        </div>
                    </div>

                </div>
            </center>
            <%@include file = "footerpage.jsp" %> 
<div id="exchange" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Mobile-Phone Exchange</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form action="PhoneExchangeServlet" method="POST" class="form-inline"> 
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Stock IMEI</label><br>
                                        <input type="text" pattern="[0-9]{15}" style="width: 90%" maxlength="15" minlength="15" autocomplete="off" class="form-control"  name="stockimei"  value="" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Exchange IMEI</label><br>
                                        <input type="text" autocomplete="off" style="width: 90%" pattern="[0-9]{15}" maxlength="15" minlength="15" class="form-control"  name="eximei"  value="" required="" >
                                    </div>
                                    
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Color</label><br>
                                        <select  name="color" style="width: 90%" class="form-control" required="">
                                                        <option  value="">Select Color</option>
                                                        <%
                                                            try {
                                                                con = Ssymphonyy.getConnection();
                                                                String query = "select COLOR from color_entry ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option  value="<%= rs.getString("COLOR")%>"> <%= rs.getString("COLOR")%></option>

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
                                     </div>
                                    <div class="col-sm-6">
                                        <label>Retailer</label><br>
                                        <input type="text" class="form-control" style="width: 90%"  name="retailer"  value="" required="" >
                                    </div>
                                </div>
                                                        <br>
                                <div class="row">
                                    <div class="col-sm-12">
                                <input type="submit" class="btn btn-primary btn-sm" value="Exchange">
                                    </div>
                                    </div>
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
        </div>
        <script src="js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
        <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
        <script>
            $(document).ready(function () {
                var c=document.getElementById('comma').value;
        document.write(c.toLocaleString("en-IN"));       
//        document.toLocaleString('en-IN');
            });
        </script>   
        <script>
            history.pushState(null, document.title, location.href);
            window.addEventListener('popstate', function (event)
            {
                history.pushState(null, document.title, location.href);
            });
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
        <script language="javascript">
    	$('#pdf').click(function () {
    var HTML_Width = $("#div_print").width();
 var HTML_Height = $("#div_print").height();
 var top_left_margin = 15;
 var PDF_Width = HTML_Width+(top_left_margin*2);
 var PDF_Height = (PDF_Width*1.5)+(top_left_margin*2);
 var canvas_image_width = HTML_Width;
 var canvas_image_height = HTML_Height;
 
 var totalPDFPages = Math.ceil(HTML_Height/PDF_Height)-1;
 
 
 html2canvas($("#div_print")[0],{allowTaint:true}).then(function(canvas) {
 canvas.getContext('2d');
 
 console.log(canvas.height+"  "+canvas.width);
 
 
 var imgData = canvas.toDataURL("image/jpeg", 1.0);
 var pdf = new jsPDF('p', 'pt',  [PDF_Width, PDF_Height]);
     pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin,canvas_image_width,canvas_image_height);
 
 
 for (var i = 1; i <= totalPDFPages; i++) { 
 pdf.addPage(PDF_Width, PDF_Height);
 pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
 }
 
     pdf.save("StockSummary.pdf");
        });
});
</script>

        <% } %>
    </body>
</html>
