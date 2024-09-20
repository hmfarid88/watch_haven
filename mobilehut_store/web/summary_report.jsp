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
    <body style=" background-color: #030303; color: #ffffff">

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
                                
                           </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                        </div>
                    </nav>
                      <%
                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select COMPANY_NAME from companyinfo";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("company", rs.getString(1));
                                                       
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                <div class="row">
                            <div id="div_print" style=" background-color: #030303; color: #ffffff">
                                <center>
                                    <h3>Report Summary </h3>
                                    <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                    <h4>${company}</h4>
                                    <center><h4><div id="date"> </div> </h4></center>
                                    <table border="2" class=" table-condensed table-responsive" width="40%">
                                   
                                     <%
                                         String demo="Demo";        
                                         try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select count(*) as qty, sum(PURCHASE_PRICE) from stock where MODEL not like '%"+ demo +"%'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("stockqty", rs.getInt(1));
                                                        request.setAttribute("stockvalue", rs.getFloat(2));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select count(*) as qty, sum(PRICE) from mobilesell where SELL_DATE=CURDATE()";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("qty", rs.getInt(1));
                                                        request.setAttribute("value", rs.getFloat(2));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(SELL_PRICE-DISCOUNT) from accessor_sale where DATE=CURDATE()";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("accvalue", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select count(*) as qty from vendor_stock where DATE=CURDATE() and TYPE='Mobile'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("lifting", rs.getInt("qty"));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select AMOUNT from netbalance where DATE !=CURDATE() order by SI_NO DESC LIMIT 1";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("bfcash", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                      <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(AMOUNT) from debitbalance where DATE =CURDATE()";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("cashin", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(AMOUNT) from creditbalance where DATE =CURDATE()";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("cashout", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(AMOUNT) from cashpayment where DATE =CURDATE()";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("cashpay", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(AMOUNT) from cost where DATE =CURDATE()";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("cost", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                      <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select AMOUNT from netbalance where DATE =CURDATE()";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("cash", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select count(*) as qty, sum(PRICE) from mobilesell where YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("totalqty", rs.getInt("qty"));
                                                        request.setAttribute("totalvalue", rs.getFloat(2));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(SELL_PRICE-DISCOUNT) from accessor_sale where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                       request.setAttribute("totalacvalue", rs.getFloat(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(AMOUNT) from bank_transition where TYPE = 'Deposit'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                       request.setAttribute("totaldeposit", rs.getLong(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                     <%
                                     try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select sum(AMOUNT) from bank_transition where TYPE = 'Withdraw'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                       request.setAttribute("totalwith", rs.getLong(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                            <tr>
                                                <td style="text-align: center"><b>Present Stock</b></td><td style="text-align: center"><b>${stockqty} PS | ${stockvalue} TK</b></td>
                                            </tr>       
                                            <tr>
                                                <td style="text-align: center"><b>Lifting Today</b></td><td style="text-align: center"><b>${lifting} PS</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>B/F Cash</b></td><td style="text-align: center"><b>${bfcash} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Phone Sale</b></td><td style="text-align: center"><b>${qty} PS | ${value} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Accessories Sale</b></td><td style="text-align: center"><b>${accvalue} TK</b></td>
                                            </tr>
                                             
                                            <tr>
                                                <td style="text-align: center"><b>Cash Debit</b></td><td style="text-align: center"><b>${cashin} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Cash Credit</b></td><td style="text-align: center"><b>${cashout} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Company Payment</b></td><td style="text-align: center"><b>${cashpay} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Expense</b></td><td style="text-align: center"><b>${cost} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Cash Balance</b></td><td style="text-align: center"><b>${cash} TK</b></td>
                                            </tr>
                                             <tr>
                                                <td style="text-align: center"><b>Bank Balance</b></td><td style="text-align: center"><b>${totaldeposit-totalwith} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Total Qty</b></td><td style="text-align: center"><b>${totalqty} PS</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Total Value</b></td><td style="text-align: center"><b>${totalvalue} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Total Accessories</b></td><td style="text-align: center"><b>${totalacvalue} TK</b></td>
                                            </tr>
                                    
                                            </table><br><br>
                                        </center>
                            </div>
                        </div><br><br>
                                        
    
    <%@include file = "footerpage.jsp" %> 
</div>
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
 
     pdf.save("ReportSummary.pdf");
        });
});
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
       
        <% } %>
    </body>
</html>
