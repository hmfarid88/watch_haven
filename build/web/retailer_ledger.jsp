<%@page import="java.sql.SQLException"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
    <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    <div class="container-fluid">
        <header>
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
                        <li><a href="home.jsp"><span class="fa fa-home"> Home</span></a></li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div id="div_print">
            <center>
                <h3>Retailer Ledger</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>
            <table  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Total Price</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
                
        try {
            con = Ssymphonyy.getConnection();
            String queryretiler="select distinct R_NAME from retailer_info order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
            
            String retailer=rs.getString(1);
            String payment="select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
            ps = con.prepareStatement(payment);
            ps.setString(1, retailer);
            rs1 = ps.executeQuery(); 
            while(rs1.next()){
             
            String totalpricevalu="select sum(COST_PRICE) from vendor_sale where RETAILER=?";
            ps = con.prepareStatement(totalpricevalu);
            ps.setString(1, retailer);
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
            
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%=rs.getString(1) %></td>
                        <th style="text-align: center"><%=rs2.getLong(1) %></th>
                        <th style="text-align: center"><%= rs1.getLong(1) %></th>
                        <th style="text-align: center"><%= rs2.getLong(1)-rs1.getLong(1) %></th>
                        
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= rs.getString(1)%>">
                                <input type="submit" class="btn btn-success btn-sm" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% }}}
 }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                    %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                       
                     </tr> 
                </tfoot>
            </table>
         
        </div>
    </div>
    <div id="payinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Payment Info Update</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="RtpayUpdateServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Payment Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" name="rtpsi" required="">
                                            <option value="">Select Payment</option>
                                           
                                        </select>
                                    </div>
                                    
                                    <div class="col-sm-6">
                                        <label>Set Amount</label>
                                        <input type="number" style=" width: 90%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="GO">
                            </form>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <br><br>
    <%@include file = "footerpage.jsp" %>

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
    <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('table tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
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
 
     pdf.save("RetailerLedger.pdf");
        });
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
    <% }%>
</body>
</html>
