
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
                                    <tr>
                                       <td style="width: 130px"> 
                                        <div id="sym">   <img  style=" margin-left: 5px; width: 100px; height: 30px;"  src="img/symphony.png"></div>
                                        <div id="sam">  <img style=" margin-left: 5px; width: 110px; height: 50px;"  src="img/samsung.png"></div>
                                        <div id="vivo"> <img  style=" margin-left: 5px; width: 110px; height: 70px;"  src="img/vivo.png"></div>
                                        <div id="tecno"> <img  style=" margin-left: 5px; width: 110px; height: 40px;"  src="img/tecno.png"></div>
                                        <div id="itel"> <img  style=" margin-left: 5px; width: 110px; height: 50px;"  src="img/itel.png"></div>
                                        <div id="mi"> <img  style=" margin-left: 20px; width: 70px; height: 60px;"  src="img/mi.png"></div>
                                        <div id="realme"> <img  style=" margin-left: 5px; width: 110px; height: 50px;"  src="img/realme.png"></div>
                                        <div id="infinix"> <img  style=" margin-left: 5px; width: 100px; height: 50px;"  src="img/infinix.png"></div>
                                        <div id="huawei"> <img  style=" margin-left: 20px; width: 70px; height: 50px;"  src="img/huawei.png"></div>
                                        <div id="nokia"> <img  style=" margin-left: 5px; width: 100px; height: 60px;"  src="img/nokia.png"></div>
                                        <div id="poco"> <img  style=" margin-left: 5px; width: 100px; height: 30px;"  src="img/poco.png"></div>
                                        <div id="oppo"> <img  style=" margin-left: 5px; width: 100px; height: 40px;"  src="img/oppo.png"></div>
                                        <div id="lava"> <img  style=" margin-left: 5px; width: 100px; height: 40px;"  src="img/lava.png"></div>
                                    </td>
                                        <td style="width: 250px">


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
                                            <p style=" font-size: 18px;margin-top: 5px"><%= rs.getString("COMPANY_NAME")%></p>
                                            <p style="font-size: 10px"><%= rs.getString("ADDRESS")%><br>
                                                <span class="glyphicon glyphicon-phone-alt"></span> <%= rs.getString("PHONE_NUMBER")%><br>
                                                E-mail :<%= rs.getString("EMAIL")%> 

                                            </p>
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

                                            <td style="text-align: center"><%= rs.getString("BRAND")%> <%= rs.getString("MODEL")%>(<%= rs.getString("COLOR")%>) MOBILE<br>IMEI <%= rs.getString("PRODUCT_ID")%> </td>
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
                                      <%
                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select  PRODUCT_NAME, PRODUCT_ID, MODEL, SELL_PRICE, DISCOUNT from accessor_sale where  CUSTOMER_ID='" + ciid + "' ";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                    %>
                                      <tr  style="border-bottom-color: white; font-size: 12px">
                                        <td style="text-align: center; border-left-style: hidden">  </td>
                                        <td style="font-size: 12px"><center><%= rs.getString("PRODUCT_NAME")%>  <%= rs.getString("MODEL")%><br>ID: <%= rs.getString("PRODUCT_ID")%> </center></td>
                                    <td style="font-size: 12px"><center>1</center></td>
                                    <td style="font-size: 12px"><center> <%= rs.getFloat("SELL_PRICE") + rs.getFloat("DISCOUNT")%></center></td>
                                    <td style="font-size: 12px; border-right-style: hidden"><center> <%= rs.getFloat("SELL_PRICE") + rs.getFloat("DISCOUNT")%></center></td>

                                  
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
                                        <tr style="border-top-style: hidden; border-left-style: hidden; border-right-style: hidden; height: 30px"><td style="font-size: 12px">Signature:</td></tr>
                                    </table>
                                <img src="img/nb4.png">

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
         <script>
        $(document).ready(function () {

     var b=  document.getElementById('bd').value;
       if(b == "TECNO" || b == "Tecno"){
         $("#tecno").show(); 
         $("#itel").hide(); 
         $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#infinix").hide(); 
         $("#realme").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide(); 
         $("#lava").hide();
       }else if (b == "ITEL" || b == "Itel"){
        $("#itel").show(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#infinix").hide(); 
         $("#realme").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
       }else if (b == "SAMSUNG" || b == "Samsung"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").show(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#infinix").hide(); 
         $("#realme").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
       }else if (b == "VIVO" || b == "Vivo"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").show(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#infinix").hide(); 
         $("#realme").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
       }else if (b == "SYMPHONY" || b == "Symphony"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").show();
         $("#mi").hide(); 
         $("#infinix").hide(); 
         $("#realme").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
       }else if (b == "MI" || b == "Mi"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").show(); 
         $("#infinix").hide(); 
         $("#realme").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
         }else if (b == "REALME" || b == "Realme"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#realme").show();
         $("#infinix").hide(); 
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
         }else if (b == "INFINIX" || b == "Infinix"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#realme").hide();
         $("#infinix").show(); 
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
         }else if (b == "HUAWEI" || b == "Huawei"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#realme").hide();
         $("#infinix").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").show(); 
         $("#oppo").hide();
         $("#lava").hide();
         }else if (b == "NOKIA" || b == "Nokia"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#realme").hide();
         $("#infinix").hide();
         $("#nokia").show(); 
         $("#poco").hide(); 
         $("#huawei").hide();
         $("#oppo").hide();
         $("#lava").hide();
         }else if (b == "POCO" || b == "Poco"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#realme").hide();
         $("#infinix").hide();
         $("#nokia").hide(); 
         $("#poco").show(); 
         $("#huawei").hide();
         $("#oppo").hide();
         $("#lava").hide();
         }else if (b == "OPPO" || b == "Oppo"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#realme").hide();
         $("#infinix").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide();
         $("#oppo").show();
         $("#lava").hide();
         }else if (b == "LAVA" || b == "Lava"){
        $("#itel").hide(); 
        $("#tecno").hide(); 
        $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#realme").hide();
         $("#infinix").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide();
         $("#oppo").hide();
         $("#lava").show();
        }else{
          $("#itel").hide(); 
          $("#tecno").hide(); 
          $("#sam").hide(); 
         $("#vivo").hide(); 
         $("#sym").hide();
         $("#mi").hide(); 
         $("#infinix").hide(); 
         $("#realme").hide();
         $("#nokia").hide(); 
         $("#poco").hide(); 
         $("#huawei").hide(); 
         $("#oppo").hide();
         $("#lava").hide();
       }
        });
    </script>
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
