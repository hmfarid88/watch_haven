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
            <div class="panel panel-primary">
                <nav style="margin: 0 auto" class="navbar navbar-inverse ">
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
                            <li> <a href="symmonthly_mobile_sell.jsp">Monthly-View</a>
                              
                            </li>
                            <li><a data-toggle="collapse" data-target="#mdateview" href="#" >Date-wise-View</a>
                            
                            </li>
                            <li>
                                <div id="mdateview" class="collapse" style="margin:10px 0px">
                                    <form  method="POST" action="datewise_mobile_sale.jsp" class="form-inline">
                                        <input type="date" autocomplete="off" size="10px" class="form-control" name="date1" value="" placeholder="Start Date" required="" >
                                        <label>TO</label> <input type="date" autocomplete="off" class="form-control" size="10px" name="date2" value="" placeholder="End Date" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="View">
                                    </form>
                                </div>
                            </li>
                            <li>
                                <div id="adateview" class="collapse" style="margin:10px 0px">
                                    <form  method="POST" action="datewise_accessor_sale.jsp" class="form-inline">
                                        <input type="date" autocomplete="off" size="10px" class="form-control" name="date1" value="" placeholder="Start Date" required="" >
                                        <label>TO</label> <input type="date" autocomplete="off" class="form-control" size="10px" name="date2" value="" placeholder="End Date" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="View">
                                    </form>
                                </div>
                            </li>
                           
                           </ul>
                       <ul class="nav navbar-nav navbar-right">
                                <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                       </ul>

                    </div>

                </nav>
                <div class="panel-body"> 

                    <div class="row">
                        <div class="col-sm-12">
                            <div id="div_print">
                                <center>
                                    <h3>Sale Report</h3>
                                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                   <table border="2" class=" table-striped table-responsive" width="100%" id="mobiletable" >
                                        <thead>
                                            <tr>
                                                <th style="text-align: center">SN</th>
                                                <th style="text-align: center">Invoice No</th>
                                                <th style="text-align: center">Customer</th>
                                                <th style="text-align: center">Sale Person</th>
                                                <th style="text-align: center">Description</th>
                                                <th style="text-align: center">Price</th>
                                                <th style="text-align: center">Offer</th>
                                                <th style="text-align: center">Nit Price</th>
                                                <th style="text-align: center">Vendor</th>
                                                <th style="text-align: center">Sale Date</th>
                                            </tr>
                                        </thead> 
                                        <tbody>
                                            <%
                                                Connection con = null;
                                                PreparedStatement ps = null;
                                                ResultSet rs=null;
                                                ResultSet rs1=null;
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select PRODUCT_ID, CUSTOMER_ID, INVOICE_NO, BRAND, MODEL, COLOR, PRICE, DISCOUNT, DIS_NOTE, VENDOR, SELL_DATE from mobilesell where SELL_DATE =CURDATE()";
                                                    ps=con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                   int cid=rs.getInt(2);
                                                   String query1="select C_NAME, PHONE_NUMBER, ADDRESS from customerinfo where CUSTOMER_ID="+cid;
                                                   ps=con.prepareStatement(query1);
                                                   rs1=ps.executeQuery();
                                                   while (rs1.next()) {
                                            %>
                                            <tr>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"><%= rs.getString("INVOICE_NO")%></td>
                                                <td style="text-align: center"><%= rs1.getString(1) %>, <%= rs1.getString(2) %></td>
                                                <td style="text-align: center"><%= rs1.getString(3) %></td>
                                                <td style="text-align: center"><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%>, <%= rs.getString("COLOR")%>, <%= rs.getString("PRODUCT_ID")%></td>
                                                <td style="text-align: center"><%= rs.getFloat("PRICE")%></td>
                                                <td style="text-align: center"><%= rs.getFloat("DISCOUNT")%> (<%= rs.getString("DIS_NOTE")%>)</td>
                                                <td style="text-align: center"><%= rs.getFloat("PRICE")-rs.getFloat("DISCOUNT") %></td>
                                                <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                                                <td style="text-align: center"><%= rs.getString("SELL_DATE")%></td>
                                            </tr>

                                            <%
                                                   }
                                                     }
                                                } catch (Exception ex) {
                                                }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                            %>
                                        </tbody>

                                        <tr style="background-color: #cccccc">
                                            <th style="text-align: center"></th>
                                            <th style="text-align: center"></th>
                                            <th style="text-align: center"></th>
                                            <th style="text-align: center"></th>
                                             <%
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select  sum(PRICE) as total, count(PRODUCT_ID) as tqnt, sum(DISCOUNT) as tdis, sum(PRICE-DISCOUNT) as discounted from mobilesell where SELL_DATE=CURDATE() ";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                            <th style="text-align: center">Total: <%= rs.getInt("tqnt")%></th>
                                            <th style="text-align: center"><%= rs.getFloat("total")%></th>
                                            <th style="text-align: center"><%= rs.getFloat("tdis")%></th>
                                            <th style="text-align: center"><%= rs.getFloat("discounted")%></th>
                                                <%
                                                        }
                                                    } catch (Exception ex) {
                                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>
                                            <th style="text-align: center"></th>
                                            <th style="text-align: center"></th>
                                        </tr>

                                    </table><br>
                                   

                                </center>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </center>
            </div>
<%@include file = "footerpage.jsp" %> 

    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>   
      
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
 
     pdf.save("SaleReport.pdf");
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

    
    <script language="javascript">
        var addSerialNumber = function () {
            var i = 0;
            $('#mobiletable tr').each(function (index) {
                $(this).find('td:nth-child(1)').html(index - 1 + 1);
            });
        };

        addSerialNumber();
    </script>
   

    <% }%>
</body>
</html>
