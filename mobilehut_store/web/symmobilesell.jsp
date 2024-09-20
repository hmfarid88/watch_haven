
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
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
         <style>
            fieldset.scheduler-border {
    border: 1px groove white ;
    padding: 0 1.4em 1.4em 1.4em ;
    margin: 0 0 1.5em 0;
    -webkit-box-shadow:  0px 0px 0px 0px #000;
    box-shadow:  0px 0px 0px 0px #000;
}

legend.scheduler-border {
    width:inherit; 
    padding:0 10px; /* To give a bit of padding on the left and right */
    border-bottom:none;
}
        </style>
    </head>
    <body style=" background-color: #303030">


        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    
    <div id="main" class="container-fluid">

        <center>
            <div class="panel panel-primary" style="background-color: #303030; color: #ffffff">
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
                            
                            <li id="hmbtn" style="margin-left: 20px"><a href="home.jsp" ><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        </ul>
                    </div>
                </nav>
                
                  <div class="panel-body">
                    <h3 class="text-center">Product Sale Area</h3>
                    <div class="row">
                        <div style="margin-right: 10%" class=" pull-right">  
                            <label>Invoice No :</label>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "SELECT MAX(CUSTOMER_ID) AS ID FROM customerinfo GROUP BY CUSTOMER_ID";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("iid", rs.getInt("ID"));
                                    }
                                } catch (Exception ex) {

                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                            %>
                            <input type="text" style="color:#030303"  value="NOV2018${iid+1}" readonly="" >
                        </div>
                        <div style="margin-left: 10%" class=" pull-left">
                            <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                        </div>
                    </div>
                    <hr style="background-color: green"> 
                    <div class="row">
                        <div class="col-sm-1">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">Prev Sale</button>
                        </div>
                        <div class="col-sm-10">
                            <div class="row">
                                <div class="col-sm-3">
                                    <br> 
                                    <form id="saleform" method="POST" action="SellEntryServlet" class=" form-inline">
                                        <label style="margin-right: 25%">Mobile IMEI</label>
                                        <div class=" input-group">
                                        <input type="hidden" name="cid" value="${iid+1}">
                                        <input type="text" style=" max-width: 80%"  class="form-control input-sm" name="imei" id="imei" value="" required="" autofocus="" >
                                        <input style=" margin-top: 2%" type="submit" id="submit"  value="OK" class="btn btn-primary btn-xs">
                                        </div>
                                    </form>

                                </div>

                                <br>
                                <div class="col-sm-3">
                                    <form id="saleform" method="POST" action="SellEntryServlet">
                                       <input type="hidden" name="cid" value="${iid+1}">
                                        <label>Add Manually</label><br>
                                        <select style=" max-width: 70%" class="form-control input-sm"  onchange="this.form.submit()"  name="imei" value=""  required="">
                                            <option>Select Mobile</option>
                                            <%                                                
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select BRAND, IMEI, MODEL from stock order by MODEL ";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>

                                            <option  value="<%= rs.getString("IMEI")%>" ><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%> (<%= rs.getString("IMEI")%>)</option>
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

                                    </form>

                                </div>
                                <div class="col-sm-3">
                                    <form id="saleform" method="POST" action="AccessorSaleServlet" class=" form-inline">
                                        <label style="margin-right: 25%">Accessories ID</label> 
                                        <div class=" input-group">
                                        <input type="hidden" name="cid" value="${iid+1}">
                                        <input style=" max-width: 80%" class="form-control input-sm" type="text" name="accessorid" id="acimei"  value="" required="" >
                                        <input style=" margin-top: 2%" type="submit"  value="OK" class="btn btn-primary btn-xs">
                                         </div>
                                    </form>
                                </div>
                                <div class="col-sm-3">
                                    <form id="saleform" method="POST" action="AccessorSaleServlet">
                                        <label>Add Manually</label>  <br>
                                         <input type="hidden" name="cid" value="${iid+1}">
                                         <select style=" max-width: 70%" class="form-control input-sm" onchange="this.form.submit()" name="accessorid"  value="" required="">
                                            <option>Select Product</option>
                                            <%
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select PRODUCT_NAME, PRODUCT_ID from accessoriesstock order by PRODUCT_NAME";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>
                                            <option value="<%= rs.getString("PRODUCT_ID")%>" ><%= rs.getString("PRODUCT_NAME")%>( <%= rs.getString("PRODUCT_ID")%>) </option>
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
                                    </form>

                                </div>

                            </div>
                            <div class="row">
                                <br>
                                <table style="border-color: #ffffff; background-color: #303030"   border="1" width="100%" id="myTables" class="table-responsive ">
                                    <thead>
                                        <tr>
                                            <th class="text-center">SN</th>
                                            <th class="text-center">Products</th>
                                            <th class="text-center">Qty</th>
                                            <th class="text-center">Rate</th>
                                            <th class="text-center">Offer</th>
                                            <th class="text-center">Sub Total</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%
                                            ResultSet rs01=null;
    try {
        con = Ssymphonyy.getConnection();
        String query = "select  BRAND, MODEL, PRODUCT_ID, COLOR, PRICE, DISCOUNT, DIS_NOTE from mobilesell where CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1 ";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
        while (rs.next()) {
            String brand = rs.getString("BRAND");
            String model = rs.getString("MODEL");
            String queryqty = "select count(*) from stock where BRAND='" + brand + "' and MODEL='" + model + "'";
            ps = con.prepareStatement(queryqty);
            rs01=ps.executeQuery();
            rs01.next();

                                        %>  

                                        <tr>
                                            <td style="text-align: center"> </td>
                                            <td>
                                    <center>
                                        <%= rs.getString("BRAND")%> ,<%= rs.getString("MODEL")%> , <%= rs.getString("COLOR")%> , <%= rs.getString("PRODUCT_ID")%><br>
                                        (Remaining Stock <%= rs01.getInt(1)  %> Ps)
                                    </center>
                                    </td>
                                    <td>
                                    <center>1</center>
                                    </td>
                                    <td Style="width:70px ">
                                    <center>
                                        <form id="mrateform" method="POST" action="MrateupdateServlet">
                                            <input type="hidden" name="imei" id="imi" value="<%= rs.getString("PRODUCT_ID")%>">
                                            <input type="number" Style="width:70px; text-align: center; color: black" required="" name="price" id="price" onchange="myFunction2())" value= "<%= rs.getFloat("PRICE") %>"  >
                                        </form>

                                    </center>
                                    </td>

                                    <td style="width: 70px">
                                    <center>
                                        <form id="disform" method="POST" action="MdiscountServlet" class=" form-inline">
                                            <input type="hidden" name="imei" id="imeei" value="<%= rs.getString("PRODUCT_ID")%>">
                                            <input type="number" style="color: black" Style="width:70px;text-align: center" name="discount" id="discount" value="<%= rs.getFloat("DISCOUNT") %>" required="">
                                            <input type="text" name="note" style="color: black" title="Discount Note" Style="width:70px;text-align: center" value="<%= rs.getString("DIS_NOTE") %>" onchange="myFunction()" placeholder="Note" >
                                            <input type="submit" class="btn btn-success btn-xs" value="OK">
                                        </form>

                                    </center>
                                    </td>
                                    <td>
                                    <center> <%= rs.getFloat("PRICE") - rs.getFloat("DISCOUNT")%></center>
                                    </td>
                                    <td><center>
                                        <form method="POST" action="MsalerolbackServlet">
                                            <input type="hidden" name="rollback" id="rollback" value="<%= rs.getString("PRODUCT_ID")%>" >
                                            <input id="productdel" class="btn btn-danger btn-xs" type="submit" value="Delete">
                                        </form>

                                    </center></td>

                                    <%
                                            }
                                        } catch (Exception ex) {
                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (rs01 != null) rs01.close(); rs01=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                    </tr>

                                    <%
                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select PRODUCT_NAME, PRODUCT_ID, MODEL, SELL_PRICE, DISCOUNT, DIS_NOTE "
                                                    + " from accessor_sale where  CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                            String product=rs.getString("PRODUCT_NAME");
                                            String queryqty = "select count(*) from accessoriesstock where PRODUCT_NAME='" + product + "'";
                                            ps = con.prepareStatement(queryqty);
                                            rs01=ps.executeQuery();
                                            rs01.next();
                                    %>
                                    <tr>
                                        <td style="text-align: center"> </td>
                                        <td><center><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%>,<%= rs.getString("PRODUCT_ID")%><br>
                                        (Remaining Stock   <%=rs01.getInt(1)  %> Ps)
                                    </center></td>
                                    <td><center>1</center></td>
                                    <td style="width: 70px; text-align: center ">
                                    <center>
                                    <%= rs.getFloat("SELL_PRICE") %>
                                    </center>
                                    </td>
                                    <td style="width: 70px; text-align: center ">
                                    <center>
                                        <form id="acdisform" method="POST" action="AdiscountupdateServlet" class=" form-inline">
                                            <input type="hidden" name="discountid"  value="<%= rs.getString("PRODUCT_ID")%>">
                                            <input type="number" Style="width:70px; text-align: center; color: black " name="disamount" id="disamount" value="<%= rs.getFloat("DISCOUNT") %>"  required="">
                                            <input type="text" title="Discount Note" name="note" Style="width:70px;text-align: center; color: black" value="<%= rs.getString("DIS_NOTE") %>" onchange="acmyFunction()" placeholder="Note" >
                                            <input type="submit" class="btn btn-success btn-xs" value="OK">
                                        </form>

                                    </center>
                                    </td>
                                    <td><center><%= rs.getFloat("SELL_PRICE")-rs.getFloat("DISCOUNT") %></center></td>
                                    <td>
                                    <center>
                                        <form method="POST" action="AsalerolbackServlet">
                                            <input type="hidden" name="pid" value="<%= rs.getString("PRODUCT_ID")%>" >
                                            <input id="acproductdel" type="submit" class="btn btn-danger btn-xs" value="Delete">
                                        </form> 

                                    </center>
                                    </td>
                                    <%
                                            }
                                        } catch (Exception ex) {

                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (rs01 != null) rs01.close(); rs01=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                    </tr>
                                    </tbody>
                                </table> 

                            </div>  
                            <br>

                        </div>
                        <div class="col-sm-1"></div>
                    </div>
<script>

function myFunction2() {
    var xx = document.getElementById("price").value;
    if(xx !==""){
        $("#mrateform").submit();
    }else{
        return false;
    }
}

function acmyFunction2() {
    var yy = document.getElementById("acprice").value;
    if(yy !==""){
        $("#arateform").submit();
    }else{
        return false;
    }
}
</script>
                                     <div class="row">
                                        <div class="col-sm-4"></div>
                                        <div class="col-sm-4">
                                            <center>
                                                <h4 style=" text-align: center; color: orangered"><strong>${nofind} </strong></h4>
                                                <form method="POST" action="CustomerFindServlet" class=" form-inline">
                                                    <input type="text" class="form-control input-sm" name="phone" value="" placeholder="Input Mobile Number" required="" > 
                                                    <button type="submit" class=" btn btn-success btn-sm" ><span class=" fa fa-search"> </span></button>
                                                </form>
                                            </center>
                                        </div>  
                                        <div class="col-sm-4"></div>
                                    </div>                   
                       <div class="row">  
                        <form id="saleform" method="POST" action="PaymentServlet" name="myForm" >
                            <div class="col-sm-3">
                                <label>Payment Type</label><br>
                                        <input type="radio" name="paytype" value="Cash" checked="checked" required=""> Cash
                                        <input id="card" type="radio" name="paytype" value="Card" required=""> Card
                                <h4>Card Information</h4>
                                <table style="border-color: #ffffff"  border="1" width="97%" class="table-responsive" >
                                    <tbody>
                                        <tr>
                                            <td width="50%"><label> Bank Name:</label></td>
                                            <td>
                                                <select  name="bank" id="bankname" class="form-control input-sm">
                                                   <option value="">Select Bank</option> 
                                                   <%
                                                  try {
            con = Ssymphonyy.getConnection();
            String query = "select BANK_NAME from bank_name order by BANK_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                                   %>
                                                   <option value="<%= rs.getString("BANK_NAME") %>"><%= rs.getString("BANK_NAME") %></option>
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label>Card-No:</label></td>
                                            <td><input type="text" class="form-control input-sm" id="cardno"  name="cardno" value="" ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Amount:</label></td>
                                            <td><input type="number" class="form-control input-sm" id="cardvalue" name="cardamount" value="0" > </td>
                                        </tr>
                                    </tbody>  
                                </table>
                            </div>
                            <div class="col-sm-6">

                                <fieldset class="scheduler-border">
                                    <legend style=" color: #ffffff"  class="scheduler-border">Customer-Information</legend>
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <label> Name :</label><br>
                                            <input type="text" class="form-control input-sm text-uppercase" name="customername" value="${cname}" required="" >
                                        </div>  
                                        <div class="col-sm-4">
                                            <label>Phone :</label><br>
                                            <input type="text" class="form-control input-sm" name="mobilenumber" value="${cphone}" required="" >
                                        </div>
                                        <div class="col-sm-4">
                                            <label>Address :</label><br>
                                            <input type="text" class="form-control input-sm text-uppercase" name="address" value="${caddress}">
                                        </div>
                                    </div> 
                                </fieldset>

                            </div>

                            <div class="col-sm-3">
                                <h4>Payment Information</h4>
                                <div class="row">
                                    <table style="border-color: #ffffff" border="1" width="95%" class="table-responsive" >
                                        <tr>
                                            <td width="50%"><label>Total-Product:</label></td>
                                            <%
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "SELECT COUNT(PRODUCT_ID) AS MQNT FROM mobilesell where CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("mqnt", rs.getInt("MQNT"));
                                                    }
                                                } catch (Exception ex) {

                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "SELECT COUNT(PRODUCT_ID) AS ACQNT FROM accessor_sale where CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("aqnt", rs.getInt("ACQNT"));
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
                                            <td><input type="text"  class="form-control input-sm" name="qunt" value="${mqnt+aqnt}" readonly=""  ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Total-Price:</label></td>
                                            <%
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "SELECT SUM(PRICE) AS MOBTOTAL, sum(DISCOUNT) as dis FROM mobilesell where  CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("mototal", rs.getInt("MOBTOTAL"));
                                                        request.setAttribute("modis", rs.getInt("dis"));
                                                    }
                                                } catch (Exception ex) {

                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "SELECT SUM(SELL_PRICE) AS ACTOTAL, sum(DISCOUNT) acdis FROM accessor_sale where CUSTOMER_ID= (select max(CUSTOMER_ID) from customerinfo)+1";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("acctotal", rs.getInt("ACTOTAL"));
                                                        request.setAttribute("accdis", rs.getInt("acdis"));
                                                    }
                                                } catch (Exception ex) {

                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                            %>
                                            <td><input type="text" class="form-control input-sm" name="total"  value="${mototal+acctotal}" readonly="" ></td>

                                        </tr>

                                        <tr>
                                            <td><label>Offer:</label></td>
                                            <td><input type="text"  class="form-control input-sm"  name="totaldis" value="${modis+accdis}" readonly=""  ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Vat (${vatrate}%):</label></td>
                                            <td><input type="text"  class="form-control input-sm"  name="vat" value="${(mototal*vatrate)/100}" readonly=""  ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Grand Total :</label></td>
                                       
                                            <td><input type="text"  class="form-control input-sm"  value="${(mototal+acctotal)-(modis+accdis)+(mototal*vatrate)/100}" readonly="" ></td>
                                        </tr>

                                    </table>
                                        <%
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "SELECT MAX(CUSTOMER_ID) AS ID FROM customerinfo";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("iiedd", rs.getInt("ID"));
                                    }
                                } catch (Exception ex) {

                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>
                            <input type="hidden" name="customerid" value="${iiedd+1}" >
                             
                                </div>
                            </div>
                             <div class="row">
                                 <div class="col-sm-12">
                                     <center> <input type="submit" id="okvo" class="btn btn-success" value="OK" ></center>
                                 </div> 
                             </div>
                        </form> 
                        <script>
                            $(document).ready(function () {
                                $("#saleform").submit(function () {
                                    if (this.beenSubmitted)
                                        return false;
                                    else
                                        this.beenSubmitted = true;
                                });
                            });
                        </script>
                    </div>
                 </div>
                
            </div>
            <!--modal area-->
            <div id="myModal" class="modal fade" role="modal-dialog ">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div style=" background-color: lightgreen" class="modal-header">
                            <button style=" color: black" type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Previous 20 Sale Records</h4>
                        </div>
                        <div class="modal-body">
                            <h4><u>Mobile</u></h4>
                            <table border="1" width="100%" class=" table-condensed table-responsive" >
                                <tr style="background-color: #CCCCCC">
                                    <th style=" text-align: center">Invoice</th>
                                    <th style=" text-align: center">Description</th>
                                    <th style=" text-align: center">Price</th>
                                    <th style=" text-align: center">Discount</th>
                                    <th style=" text-align: center">Sale Date</th>

                                </tr>
                                <tr>
                                    <%

                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select PRODUCT_ID, INVOICE_NO, MODEL, COLOR, PRICE, DISCOUNT, SELL_DATE from mobilesell  order by CUSTOMER_ID desc limit 20";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                request.setAttribute("pid", rs.getString("PRODUCT_ID"));
                                                request.setAttribute("invoice", rs.getString("INVOICE_NO"));
                                                request.setAttribute("model", rs.getString("MODEL"));
                                                request.setAttribute("color", rs.getString("COLOR"));
                                                request.setAttribute("price", rs.getFloat("PRICE"));
                                                request.setAttribute("dis", rs.getFloat("DISCOUNT"));
                                                request.setAttribute("seldate", rs.getString("SELL_DATE"));


                                    %>

                                    <td style=" text-align: center">${invoice}</td>
                                    <td style=" text-align: center">${model}, ${color}, ${pid}</td>
                                    <td style=" text-align: center">${price}</td>
                                    <td style=" text-align: center">${dis}</td>
                                    <td style=" text-align: center">${seldate}</td>

                                </tr>
                                <%                   }
                                    } catch (Exception ex) {

                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                            </table>                     
                            <h4><u>Accessories</u></h4>
                            <table border="1" width="100%" class=" table-condensed table-responsive" >
                                <tr style="background-color: #CCCCCC">
                                    <th style=" text-align: center">Invoice</th>
                                    <th style=" text-align: center">Description</th>
                                    <th style=" text-align: center">Price</th>
                                    <th style=" text-align: center">Discount</th>
                                    <th style=" text-align: center">Sale Date</th>

                                </tr>
                                <tr>
                                    <%
                                        try {

                                            con = Ssymphonyy.getConnection();
                                            String query = "select PRODUCT_NAME, MODEL, SELL_PRICE, DISCOUNT, INVOICE_NO, DATE from accessor_sale  order by CUSTOMER_ID desc limit 20";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                request.setAttribute("pname", rs.getString("PRODUCT_NAME"));
                                                request.setAttribute("acmodel", rs.getString("MODEL"));
                                                request.setAttribute("slprice", rs.getFloat("SELL_PRICE"));
                                                request.setAttribute("acdis", rs.getFloat("DISCOUNT"));
                                                request.setAttribute("acinvoice", rs.getString("INVOICE_NO"));
                                                request.setAttribute("acseldate", rs.getString("DATE"));


                                    %>

                                    <td style=" text-align: center">${acinvoice}</td>
                                    <td style=" text-align: center">${pname}, ${acmodel}</td>
                                    <td style=" text-align: center">${slprice}</td>
                                    <td style=" text-align: center">${acdis}</td>
                                    <td style=" text-align: center">${acseldate}</td>

                                </tr>
                                <%                   }
                                    } catch (Exception ex) {
                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success btn-sm" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>

            <%@include file = "footerpage.jsp" %> 
        </center>
    </div>
        <script>
            $(document).ready(function () {
             $('input[type=radio]').change(function () {
                if ($('#card').is(':checked')) {
                    document.getElementById("cardvalue").required = true;
                    document.getElementById("bankname").required = true;
                    document.getElementById("cardno").required = true;
                } else {
                    document.getElementById("cardvalue").required = false;
                    document.getElementById("bankname").required = false;
                    document.getElementById("cardno").required = false;
                }
            });
          
        });
     
      </script>
                       <script>
                            $(document).ready(function () {        
                            $(function() {
                            $('#imei').on('keypress', function(e) {
                            if (e.which === 32)
                             return false;
                                 });
                             });
                             $(function() {
                            $('#acimei').on('keypress', function(e) {
                            if (e.which === 32)
                             return false;
                                 });
                             });
                             });
                       </script>
<script>
        $(document).ready(function () {
            $("#productdel").show(function () {
                $("#hmbtn").hide();
            });
            $("#acproductdel").show(function () {
                $("#hmbtn").hide();
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $("#okvo").hide();
            $("#productdel").show(function () {
                $("#hmbtn").hide();
                $("#okvo").show();
            });
            $("#acproductdel").show(function () {
                $("#hmbtn").hide();
                $("#okvo").show();
            });
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
        var addSerialNumber = function () {
            var i = 0;
            $('#myTables tr').each(function (index) {
                $(this).find('td:nth-child(1)').html(index - 1 + 1);
            });
        };
        addSerialNumber();
    </script>
    

    <script src="js/bootstrap.min.js"></script>
     
    <% }%>
</body>
</html>
