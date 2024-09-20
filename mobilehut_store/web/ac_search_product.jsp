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
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
                    <div class="panel-body"> 

                        <div class="row">
                            <div class="col-sm-12">
                                <div id="div_print">
                                    <center>
                                        <h4>View Searched Product</h4>   
                                        <h5>Search Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </h5>
                                        <hr>
                                        <div id="noproduct"><h4>Sorry No Product Found For This Input</h4></div>
                                        <table border="2" class=" table-condensed table-responsive" width="70%" >
                                            <tbody>
                                                <%
                                                    String imei = request.getParameter("imei");

                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    ResultSet rs1=null;
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select PRODUCT_NAME, PRODUCT_ID, COST_PRICE, SELL_PRICE, DISCOUNT, VENDOR, INVOICE_NO, CUSTOMER_ID,"
                                                                + " STOCK_DATE, DATE  from accessor_sale where PRODUCT_ID='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                            int cid=rs.getInt("CUSTOMER_ID");
                                                  String query2="select C_NAME, PHONE_NUMBER from customerinfo where CUSTOMER_ID=?";
                                                  ps = con.prepareStatement(query2);
                                                  ps.setInt(1, cid);
                                                  rs1 = ps.executeQuery();
                                                  while (rs1.next()) {

                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td>Sold to <%= rs1.getString("C_NAME")%>, <%= rs1.getString("PHONE_NUMBER")%></td></tr>
                                                <tr> <th>Invoice</th> <td><%= rs.getString("INVOICE_NO")%></td></tr>
                                                <tr> <th>Product Name</th> <td><%= rs.getString("PRODUCT_NAME")%></td></tr>
                                                <tr> <th>Product No</th> <td><%= rs.getString("PRODUCT_ID")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("COST_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("SELL_PRICE")%> </td></tr>
                                                <tr> <th>Discount</th> <td><%= rs.getFloat("DISCOUNT")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Stock Date</th> <td><%= rs.getString("STOCK_DATE")%></td></tr>
                                                <tr> <th>Sale Date</th> <td><%= rs.getString("DATE")%></td></tr>

                                                <%
                                                        }}
                                                    } catch (Exception ex) {
                                                    }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>
                                                <%
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select PRODUCT_NAME, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, INVOICE_NO, CUSTOMER_ID,"
                                                                + " STOCK_DATE, DATE  from vendor_accessor_sale where PRODUCT_ID='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                            int cid=rs.getInt("CUSTOMER_ID");
                                                  String query2="select C_NAME, PHONE_NUMBER from customerinfo where CUSTOMER_ID=?";
                                                  ps = con.prepareStatement(query2);
                                                  ps.setInt(1, cid);
                                                  rs1 = ps.executeQuery();
                                                  while (rs1.next()) {
                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td> Vendor Sale to <%= rs1.getString("C_NAME")%>, <%= rs1.getString("PHONE_NUMBER")%></td></tr>
                                                <tr> <th>Invoice</th> <td><%= rs.getString("INVOICE_NO")%></td></tr>
                                                <tr> <th>Product Name</th> <td><%= rs.getString("PRODUCT_NAME")%></td></tr>
                                                <tr> <th>Product No</th> <td><%= rs.getString("PRODUCT_ID")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("COST_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("SELL_PRICE")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Stock Date</th> <td><%= rs.getString("STOCK_DATE")%></td></tr>
                                                <tr> <th>Sale Date</th> <td><%= rs.getString("DATE")%></td></tr>   

                                                <%
                                                        }}
                                                    } catch (Exception ex) {
                                                    }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>

                                                <%
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select  PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR,"
                                                                + " DATE  from accessoriesstock where PRODUCT_ID='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td>Stored in Stock</td></tr>
                                                <tr> <th>Product Name</th> <td><%= rs.getString("PRODUCT_NAME")%></td></tr>
                                                <tr> <th>Model</th> <td><%= rs.getString("MODEL")%></td></tr>
                                                <tr> <th>Product No</th> <td><%= rs.getString("PRODUCT_ID")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("COST_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("SELL_PRICE")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Stock Date</th> <td><%= rs.getString("DATE")%></td></tr>


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
                                                        String query = "select  PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR,"
                                                                + " STOCK_DATE, DATE  from accessor_faulty where PRODUCT_ID='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td>Stored in Faulty Stock</td></tr>
                                                <tr> <th>Product Name</th> <td><%= rs.getString("PRODUCT_NAME")%></td></tr>
                                                <tr> <th>Model</th> <td><%= rs.getString("MODEL")%></td></tr>
                                                <tr> <th>Product No</th> <td><%= rs.getString("PRODUCT_ID")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("COST_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("SELL_PRICE")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Stock Date</th> <td><%= rs.getString("STOCK_DATE")%></td></tr>
                                                <tr> <th>Faulty Date</th> <td><%= rs.getString("DATE")%></td></tr>


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
                                                        String query = "select  PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, NOTE,"
                                                                + " STOCK_DATE, DATE  from acc_stock_del where PRODUCT_ID='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td>Stored In Deleted Stock</td></tr>
                                                <tr> <th>Product Name</th> <td><%= rs.getString("PRODUCT_NAME")%></td></tr>
                                                <tr> <th>Model</th> <td><%= rs.getString("MODEL")%></td></tr>
                                                <tr> <th>Product No</th> <td><%= rs.getString("PRODUCT_ID")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("COST_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("SELL_PRICE")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Delete Note</th> <td><%= rs.getString("NOTE")%></td></tr>
                                                <tr> <th>Stock Date</th> <td><%= rs.getString("STOCK_DATE")%></td></tr>
                                                <tr> <th>Delete Date</th> <td><%= rs.getString("DATE")%></td></tr>


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
                                            $(document).ready(function () {
                                                $("#productshow").show(function () {
                                                    $("#noproduct").hide();
                                                });
                                            });
        </script>
     

<% } %>

    </body>
</html>
