<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DB.Ssymphonyy"%>
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
    border: 1px groove green ;
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
            <div class="panel panel-primary" style="background-color: #CCCCCC">
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
                    <div class="row">
                        <h3 class="text-center">Vendor Sale Area</h3>

                        <div style="margin-right: 20px" class="pull-right">  
                            <label>Invoice No :</label>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
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
                            <input type="text"  value="NOV2018${iiedd+1}" readonly="" >
                        </div>
                        <div style="margin-left: 20px" class="pull-left">
                            <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                        </div><br>
                        <hr style="background-color: green"> 
                    </div>
                    <div class="row">

                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3">
                                    <br> 
                                    <form method="POST" action="vendor_sale_entry.jsp">
                                        <div class="input-group">
                                        <label>Input Mobile IMEI :</label><br>
                                        <input type="hidden" name="cid" value="${iiedd+1}">
                                        <input class="form-control input-sm" style=" max-width: 80%" type="text" name="imei" id="imei" value="" required="" autofocus=""  >
                                        <input style=" margin-top: 2%" type="submit" id="vsubmit"  value="OK" class="btn btn-primary btn-xs">
                                        </div>
                                    </form>

                                </div>

                                <br>
                                <div class="col-sm-3">
                                    <form method="POST" action="vendor_sale_entry.jsp" class=" form-inline">

                                        <label>Add Manually :</label><br>
                                        <input type="hidden" name="cid" value="${iiedd+1}">
                                        <select style=" max-width: 80%" class="form-control" onchange="this.form.submit()" name="imei" id="imeee" value="" required="">
                                            <option>Select Mobile IMEI</option>
                                            <%

                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select IMEI, MODEL from stock order by MODEL";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>

                                            <option value="<%= rs.getString("IMEI")%>" ><%= rs.getString("MODEL")%>, <%= rs.getString("IMEI")%></option>
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
                                    <form method="POST" action="vendor_accessor_saleEntry.jsp">
                                        <div class="input-group">
                                        <label>Input Accessories ID :</label><br>
                                        <input type="hidden" name="cid" value="${iiedd+1}">
                                        <input style=" max-width: 80%" class="form-control input-sm" type="text" name="accessorid" id="acimei" value="" required="" >
                                        <input style=" margin-top: 2%" type="submit"  value="OK" class="btn btn-primary btn-xs">
                                        </div>
                                    </form>  
                                </div>
                                <div class="col-sm-3">
                                    <form method="POST" action="vendor_accessor_saleEntry.jsp" class="form-inline">
                                        <label>Add Manually :</label>  <br>
                                        <input type="hidden" name="cid" value="${iiedd+1}">
                                        <select style=" max-width: 80%" class="form-control" onchange="this.form.submit()" name="accessorid"  value="" required="">
                                            <option>Select Product ID</option>
                                            <%
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select PRODUCT_NAME, PRODUCT_ID  from accessoriesstock ";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>
                                            <option value="<%= rs.getString("PRODUCT_ID")%>" ><%= rs.getString("PRODUCT_NAME")%>(<%= rs.getString("PRODUCT_ID")%>) </option>
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
                                <table style=" background-color: #ffffff"  border="1" width="80%" id="myTables" class="table-condensed table-responsive">
                                    <thead>
                                        <tr style=" background-color: #030303; color: #ffffff">
                                            <th class="text-center">SN</th>
                                            <th class="text-center">Products</th>
                                            <th class="text-center">Qty</th>
                                            <th class="text-center">Price</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%

                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select BRAND, MODEL, PRODUCT_ID, COLOR, COST_PRICE from vendor_sale where  CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>  

                                        <tr>
                                            <td style="text-align: center"> </td>
                                            <td>
                                    <center>
                                        <%= rs.getString("BRAND")%> ,<%= rs.getString("MODEL")%> , <%= rs.getString("COLOR")%> , <%= rs.getString("PRODUCT_ID")%>
                                    </center>
                                    </td>
                                    <td>
                                    <center>1</center>
                                    </td>

                                    <td>
                                    <center> <%= rs.getFloat("COST_PRICE")%></center>
                                    </td>
                                    <td><center>
                                        <form method="POST" action="vendorM_sale_rollback.jsp">
                                            <input type="hidden" name="rollback" id="rollback" value="<%= rs.getString("PRODUCT_ID")%>">
                                            <input id="productdel" class="btn btn-danger btn-xs" type="submit" value="Delete">
                                        </form>

                                    </center></td>

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

                                    <%
                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select PRODUCT_NAME, PRODUCT_ID, MODEL, COST_PRICE "
                                                    + " from vendor_accessor_sale where  CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {

                                    %>
                                    <tr>
                                        <td style="text-align: center"> </td>
                                        <td><center><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%>,<%= rs.getString("PRODUCT_ID")%> </center></td>
                                    <td><center>1</center></td>

                                    <td><center><%= rs.getFloat("COST_PRICE")%></center></td>
                                    <td>
                                    <center>
                                        <form method="POST" action="vendor_accesor_sale_rollback.jsp">
                                            <input type="hidden" name="pid" id="pid" value="<%= rs.getString("PRODUCT_ID")%>">
                                            <input id="acproductdel" class="btn btn-danger btn-xs" type="submit" value="Delete">
                                        </form> 

                                    </center>
                                    </td>
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
                                    <tr>
                                        <th></th>
                                        <th style="text-align: center">Total</th>
                                            <%
                                                try {
                                                    con = Ssymphonyy.getConnection();
                                                    String query = "select count(PRODUCT_ID) as pqnty, sum(COST_PRICE)as ptotal "
                                                            + " from vendor_sale where  CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1 ";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("mqty", rs.getInt("pqnty"));
                                                        request.setAttribute("mtotal", rs.getFloat("ptotal"));
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
                                                    String query = "select count(PRODUCT_ID) as aqnty, sum(COST_PRICE)as atotal "
                                                            + " from vendor_accessor_sale where  CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("aqty", rs.getInt("aqnty"));
                                                        request.setAttribute("atotal", rs.getFloat("atotal"));
                                                    }
                                                } catch (Exception ex) {
                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                            %>
                                        <th style="text-align: center">${mqty+aqty} </th>
                                        <th style="text-align: center">${mtotal+atotal} </th>
                                        <th></th>
                                    </tr>
                                    </tbody>
                                </table> 

                            </div>  
                            <br>
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-8">
                                    <fieldset class="scheduler-border">
                                        <legend class="scheduler-border">Vendor-Information</legend>
                                        <form id="vendform" method="POST" action="Vendor_customerServlet" >
                                            <div class="row">
                                               
                                                <input type="hidden" name="cid" value="${iiedd+1}">
                                                <div class="col-sm-3"></div>
                                                <div class="col-sm-6">
                                                  <label><b>Vendor Name :</b></label><br>
                                                  <select id="vname"  name="rtname" class="form-control input-sm" required="">
                                                    <option value="">Select Vendor</option>
                                                    <%
                                                             try {
                                                         con = Ssymphonyy.getConnection();
                                                         String query = "select R_NAME from retailer_info order by R_NAME";
                                                         ps = con.prepareStatement(query);
                                                         rs = ps.executeQuery();
                                                         while (rs.next()) {
                                                    %>
                                                    <option value="<%= rs.getString(1)%>"> <%= rs.getString(1)%></option>
                                                    <%
                                                        }
                                                    } catch (SQLException ex) {
                                                        ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                    %>
                                                </select> 
                                               </div>  
                                               <div class="col-sm-3"></div>
                                            </div> <br>
                                            <div class="row">
                                                <input type="submit" id="okvo" class="btn btn-success btn-sm" value="OK">
                                            </div>
                                        </form>
                                        <script>
                                            $(document).ready(function () {
                                                $("#vendform").submit(function () {
                                                    if (this.beenSubmitted)
                                                        return false;
                                                    else
                                                        this.beenSubmitted = true;
                                                });
                                            });
                                        </script>
                                    </fieldset> 
                                </div>
                                <div class="col-sm-2"></div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
            <%@include file = "footerpage.jsp" %> 
        </center>
    </div>
<script src="js/bootstrap.min.js"></script>
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
        $(document).ready(function () {
            $("#productdel").show(function () {
                $("#hmbtn").hide();
            });
            $("#acproductdel").show(function () {
                $("#hmbtn").hide();
            });
        });
    </script>
    
       
    <% }%>
</body>
</html>
