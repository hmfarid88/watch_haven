
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
        <title>Watch Haven</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
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
        <div id="main" class="container">
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
                        
                        <li style="margin-left: 20px"> <a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                </div>

            </nav>


            <div class="row">

                <div class="col-sm-4"></div>
                <div class="col-sm-4"><br>

                    <div id="div_print"><br>
                        <center>
                            <div class="panel" style="width: 370px; height: 528px; border-color: black" >
                                <table>
<!--                                    <tr>
                                       <td> 
                                        <div>   <img  style="margin-top: 2px; width: 250px; height: 70px;"  src="img/101.1.png"></div>
                                        
                                    </td>
                                    </tr>-->
                                    <tr>
                                        <td>


                                            <%
                                                String ciid = request.getParameter("cid");
                                                Connection con = null;
                                                PreparedStatement ps = null;
                                                ResultSet rs=null;
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select distinct COMPANY_NAME, ADDRESS, PHONE_NUMBER, EMAIL from companyinfo ";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>
                                    <center>
                                        <p style="font-size: 20px"><%= rs.getString("COMPANY_NAME")%></p>     
                                        <p style="font-size: 10px"><%= rs.getString("ADDRESS")%><br>
                                                <span class="glyphicon glyphicon-phone-alt"></span> <%= rs.getString("PHONE_NUMBER")%><br>
                                                E-mail :<%= rs.getString("EMAIL")%> 

                                            </p>
                                    </center>
                                            <%
                                                    }
                                                } catch (Exception ex) {
                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                            %>
                                        </td>
                                    </tr>
                                </table>
                                <p style=" font-size: 15px"><u><strong>Invoice/Bill</strong></u></p>
                                <table style=" margin-left: 5px"  width="100%" class="table-responsive">

                                    <tr style=" border-bottom-style: hidden; font-size: 11px">
                                        <td style="border-right-style: hidden" width="50%"><label>DATE: </label> 
                                            ${param.selldate}
                                        </td>

                                        <td><label>INVOICE NO:</label>

                                            NOV2018${param.cid}

                                        </td>
                                    </tr>
                                    <tr style=" border-bottom-style: hidden; font-size: 11px">
                                        <td style="border-right-style: hidden">
                                          
                                            <%
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select C_NAME,PHONE_NUMBER, ADDRESS from customerinfo where CUSTOMER_ID='" + ciid + "'";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                 request.setAttribute("address", rs.getString("ADDRESS"));
                                            %>
                                         <p class="text-uppercase"><strong>NAME:  <%= rs.getString("C_NAME")%></strong></p>

                                        </td>
                                        <td><label>PHONE:</label>
                                            <%= rs.getString("PHONE_NUMBER")%>
                                        </td>
                                    </tr>
                                    <tr style="font-size: 11px">
                                        <td style="border-right-style: hidden">
                                        
                                        </td>
                                        <td></td>
                                 
                                    <%
                                            }
                                        } catch (Exception ex) {
                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                       </tr>
                                </table>
                                <table style=" margin-left: 5px"  width="100%" class="table-responsive">
                                    <tr style="font-size: 11px"> <td> <p class="text-uppercase"><strong>ADDRESS: </strong> ${address} </p></td></tr>
                                </table>

                                <table style="height: 150px"  border="1" width="100%" class="myTables"  cellspace="2px" >
                                    <thead>
                                        <tr style="font-size: 12px" height="20%">
                                            <th style=" border-left-style: hidden"><center>SN</center></th>
                                    <th><center>Description</center></th>
                                    <th><center>Qnt</center></th>
                                    <th><center>Unit</center></th>
                                    <th style="border-right-style: hidden"><center>Total</center></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                 
                                        <%
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select  PRODUCT_ID, BRAND, MODEL, COLOR, STOCK_RATE, PRICE from mobilesell where  CUSTOMER_ID='" + ciid + "'";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                                request.setAttribute("brand", rs.getString("BRAND"));   
                                        %>
                                   <tr  style="border-bottom-color: white; font-size: 12px">
                                            <td style="text-align: center; border-left-style: hidden">  </td>

                                            <td style="text-align: center"><%= rs.getString("BRAND")%> <%= rs.getString("MODEL")%>(<%= rs.getString("COLOR")%>) <br>Product's No: <%= rs.getString("PRODUCT_ID")%> </td>
                                            <td><center>1</center></td>
                                    <td><center><%= rs.getFloat("STOCK_RATE")%></center></td> 
                                <td style=" border-right-style: hidden"><center><%= rs.getFloat("STOCK_RATE")%></center></td> 

                                   <%
                                            }
                                        } catch (Exception ex) {
                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                    </tr>
                                    <input type="text" style="display: none"  id="bd" value="${brand}" >
 <%
                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select  sum(STOCK_RATE-PRICE) from mobilesell where  CUSTOMER_ID='" + ciid + "'";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                request.setAttribute("differ", rs.getFloat(1));
                                    %>
                                     <%
                                        }
                                    } catch (Exception ex) {

                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                                     
                                   </tr>
                                    </tbody>
                                </table>
                                <div style="text-align: right; margin-right: 5px; font-size: 12px">
                                    <label>Total:</label>
                                    <%
                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select TOTAL, VAT, GRAND_TOTAL, DISCOUNT, CARD_RECV, CASH_RECV   from paymentinfo where  CUSTOMER_ID='" + ciid + "'";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                        request.setAttribute("tootal",rs.getFloat("TOTAL") );
                                        request.setAttribute("vaat",rs.getFloat("VAT") );
                                        request.setAttribute("gtootal",rs.getFloat("GRAND_TOTAL") );
                                        request.setAttribute("ditootal",rs.getFloat("DISCOUNT") );
                                        request.setAttribute("cdtootal",rs.getFloat("CARD_RECV") );
                                        request.setAttribute("cctootal",rs.getFloat("CASH_RECV") );
                                      }
                                        } catch (Exception ex) {                       
                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "SELECT VAT_RATE FROM vat";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("vatrate", rs.getInt("VAT_RATE"));
                                                    }
                                                } catch (Exception ex) {

                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>

                                    ${tootal+differ}<br>
                                    <label>Offer:</label>
                                      ${ditootal}                                    
                                    <br>
                                    <label>Vat (${vatrate}%) :</label>
                                     ${vaat}  <br>
                                    <label>Grand Total:</label>${gtootal+differ}

                                </div>  

                                <table border="1" width="100%" >
                                    <tr style=" font-size: 12px">

                                        <td style=" border-left-style: hidden"  width="50%"><label>Card Pay:</label> ${cdtootal} Tk </td>

                                        <td style="text-align:right; font-size: 11px; border-right-style: hidden"><label>Cash Pay:</label> ${cctootal+differ} Tk </td><td style="width: 5px;border-right-style: hidden"></td>

                                    </tr>
                                </table>
                                    <table border="1" width="100%" >
                                        <tr style="border-top-style: hidden; border-left-style: hidden; border-right-style: hidden; height: 20px"><td style="font-size: 12px">Signature:</td></tr>
                                    </table>
                                        <p style=" font-family: cursive ; font-size: 10px">" সকল পণ্য দেখে শুনে ও বুঝে ক্রয় করুন, বিকৃত পণ্য ফেরত যোগ্য নয় "</p>

                            </div>
                        </center>
                    </div>
                </div>
                <div class="col-sm-4"></div>                  
            </div>                
            <%@include file = "footerpage.jsp" %> 
        </div>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
     <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('.myTables tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
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
