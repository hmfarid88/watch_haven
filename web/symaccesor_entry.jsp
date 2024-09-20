<%-- 
    Document   : symaccesor_entry
    Created on : Dec 31, 2017, 2:17:42 AM
    Author     : Polash
--%>

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
         <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
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
                    <li><a href="#" data-toggle="collapse" data-target="#setting"><span class="fa fa-window-restore"> New-Add</span></a></li>
                    <li><a href="details_accessor_stockView.jsp">Stock-Details</a> </li>
                   
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                </ul>
            </div>

        </nav>
        <div class="row">
            <div class="col-sm-6">
                <center>
                    <div class="panel panel-primary" style=" background-color: #CCCCCC">
                        <div class="panel-body">
                            <div id="setting" class="collapse">
                                <div class="panel panel-success">
                                    <div class="panel-heading">Product-Entry</div>
                                    <div class="panel-body">
                                        <div class="col-sm-6">
                                            <h4 class="text-primary"><strong>New-Entry</strong></h4>
                                            <form method="POST" action="accesor_rate_entryProcess.jsp">
                                                <center>
                                                    <label>Product Name :</label>
                                                    <input style=" width: 60%" type="text" class="form-control" value="" name="prodct"  required="" ><br>
                                                    <label>Purchase's Price :</label>
                                                    <input style=" width: 60%" type="number" class="form-control" value="" name="costprice"  required="" ><br>
                                                    <label>Sale Price :</label>
                                                    <input style=" width: 60%" type="number" class="form-control" value="" name="saleprice"  required=""><br><br>
                                                    <input type="submit" class="btn btn-success btn-sm" value="Add">
                                                </center>
                                            </form>
                                        </div>
                                        <div class="col-sm-6">
                                            <h4 class="text-primary"><strong>Update-Price</strong></h4>
                                            <form method="POST" action="Accesor_rate_update.jsp">
                                                <center>
                                                    <label>Select Product :</label><br>
                                                    <select style="width: 60%" class="form-control select2"   name="pro"   required="" >
                                                        <option value=""></option>

                                                        <%
                                                            Connection con = null;
                                                            PreparedStatement ps = null;
                                                            ResultSet rs=null;
                                                            try {
                                                                con = Ssymphonyy.getConnection();
                                                                String query = "select PRODUCT_NAME from accessor_price ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option value="<%= rs.getString("PRODUCT_NAME")%>"><%= rs.getString("PRODUCT_NAME")%></option>
                                                        <%
                                                                }
                                                            } catch (Exception ex) {
                                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                        %>
                                                    </select><br><br>
                                                    <label>Purchase's Price :</label>
                                                    <input style=" width: 60%" type="number" class="form-control" value="" name="costprice"  required="" ><br>
                                                    <label>Sale Price :</label>
                                                    <input style=" width: 60%" type="number" class="form-control" value="" name="saleprice"  required=""><br><br>
                                                    <input type="submit" class="btn btn-info btn-sm" value="Update">
                                                </center>
                                            </form>
                                        </div>
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                           <h4 class="text-primary"><strong>Delete Product Name</strong></h4>
                                            <form method="POST" action="AccesorDeleteServlet">
                                                <center>
                                                    
                                                    <select style="width: 60%" class="form-control select2"   name="pro"   required="" >
                                                        <option value="">Select Product</option>

                                                        <%
                                                            
                                                            try {
                                                                con = Ssymphonyy.getConnection();
                                                                String query = "select PRODUCT_NAME from accessor_price ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option value="<%= rs.getString("PRODUCT_NAME")%>"><%= rs.getString("PRODUCT_NAME")%></option>
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
                                           <input type="submit" class="btn btn-warning btn-sm" value="Delete">
                                                </center>
                                            </form> 
                                                        </div>
                                                    </div>
                                    </div>
                                </div>
                            </div>
                            <h3>Accessories-Entry</h3><hr style="background-color: green">
                            <table class="table" >
                               
                                <tbody>

                                    <tr>

                                        <td>
                                            <form  method="POST" action="AccessorSelectServlet">
                                                <select onchange="this.form.submit()"  name="product"  class="form-control select2"  required="" >
                                                    <option value="">Select Product</option>
                                                    <%
                                                        
                                                        try {
                                                            con = Ssymphonyy.getConnection();
                                                            String query = "select PRODUCT_NAME from accessor_price ";
                                                            ps = con.prepareStatement(query);
                                                            rs = ps.executeQuery();
                                                            while (rs.next()) {
                                                    %>
                                                    <option  value="<%= rs.getString("PRODUCT_NAME")%>">  <%= rs.getString("PRODUCT_NAME")%>  </option>
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

                                        </td>
                                        <td>
                                            <form  method="POST" action="AccModelServlet">
                                                <select onchange="this.form.submit()"   name="mdl" class="form-control select2" required="">
                                                    <option  value="">Select Model</option>
                                                    <%
                                                        try {
                                                            con = Ssymphonyy.getConnection();
                                                            String query = "select MODEL from model_price ";
                                                            ps = con.prepareStatement(query);
                                                            rs = ps.executeQuery();
                                                            while (rs.next()) {
                                                    %>
                                                    <option  value="<%= rs.getString("MODEL")%>">  <%= rs.getString("MODEL")%>  </option>
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

                                        </td>
                                        <td> 
                                            <form method="POST" action="AccVendorServlet">
                                                <select onchange="this.form.submit()"  name="vendor"  class="form-control select2"  required="">
                                                    <option value="">Select Vendor</option>
                                                    <%
                                                        try {
                                                            con = Ssymphonyy.getConnection();
                                                            String query = "select VENDOR_NAME from vendor ";
                                                            ps = con.prepareStatement(query);
                                                            rs = ps.executeQuery();
                                                            while (rs.next()) {
                                                    %>
                                                    <option value="<%= rs.getString("VENDOR_NAME")%>"><%= rs.getString("VENDOR_NAME")%></option>
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

                                        </td>
                                    </tr>
                                </tbody>
                            </table>


                            <form id="acentry"  method="POST" action="AccesorStockServlet">

                                <table class="table" >
                                    <col width="50%">
                                    <col width="50%">
                                    <tbody>
                                        <tr>

                                            <td><label>Product Name :</label></td>
                                            <td> <input type="text"  name="product" id="product" class="form-control"  value="${PRODCT}" required="" ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Purchase's Price:</label></td>
                                            <td><input type="number" name="cost" id="cost" class="form-control"  value="${ACPURCH}" required=""></td>

                                        </tr>
                                        <tr>
                                            <td><label>Sale Price:</label></td>   
                                            <td><input type="number"  name="sellprice" id="sellprice" class="form-control"  value="${ACSALE}" required="" ></td>

                                        </tr>
                                        <tr>
                                            <td><label>Model  :</label></td>
                                            <td> <input type="text" class="form-control" name="model" id="model" value="${MODL}"> </td>

                                        </tr>

                                        <tr>
                                            <td><label>Vendor Name  :</label></td>
                                            <td> <input type="text" name="vname" id="vname" class="form-control"  value="${VNDOR}" required=""> </td>

                                        </tr>
                                        <tr>
                                            <td><label>Product's ID :</label></td>
                                            <td><input type="text" name="proid" id="proid" pattern="[0-9]{8}" maxlength="8" minlength="8" class="form-control"  value="" required="" autofocus="" ></td>

                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <input type="submit" id="acsubmit" class="btn btn-sm btn-primary"  value="Entry">
                                                <input type="reset" class="btn btn-sm btn-primary"  value="Reset">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </form>
                            <script>
                            $(document).ready(function () {
                                $("#acentry").submit(function () {
                                    if (this.beenSubmitted)
                                        return false;
                                    else
                                        this.beenSubmitted = true;
                                });
                            });
                            $(function() {
                            $('#proid').on('keypress', function(e) {
                            if (e.which === 32)
                             return false;
                                 });
                             });
                        </script>
                        </div>
                    </div>
                </center>

            </div>
            <div class="col-sm-6">
                <center><h4><strong>Current Stock</strong></h4>
                    <table border="2" width="50%" style=" background-color: #030303; color: #ffffff">
                        <tr>
                            <th style="text-align: center">Total Quantity</th><th style="text-align: center">Total Amount</th>
                        </tr>
                        <%
                            try {
                                con = Ssymphonyy.getConnection();
                                String query = "select  count(PRODUCT_ID) as tqnty, sum(COST_PRICE) as atcost from accessoriesstock where DATE=CURDATE()";
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {

                        %>
                        <tr>
                            <td style="text-align: center"><%= rs.getInt("tqnty")%> PS</td><td style="text-align: center"><%= rs.getFloat("atcost")%> TK</td>
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
                    </table>
                </center><br>
                <table border="2" id="mobiletable" class=" table-striped table-responsive" width="100%" >
                    <thead>
                        <tr style="background-color: #030303; color: #ffffff">
                            <th style="text-align: center">Description</th>
                            <th style="text-align: center">IMEI</th>
                            <th style="text-align: center">Cost Price</th>
                            <th style="text-align: center">Sale Price</th>
                            <th style="text-align: center">Vendor</th>
                            <th style="text-align: center">Date</th>
                        </tr>
                    </thead> 
                    <tbody id="myTable">
                    <%
                        try {
                            con = Ssymphonyy.getConnection();
                            String query = "select SI_NO, PRODUCT_NAME, MODEL, PRODUCT_ID, COST_PRICE, SELL_PRICE, VENDOR, DATE"
                                    + " from accessoriesstock  where DATE=CURDATE()";
                            ps = con.prepareStatement(query);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                    %>
                    <tr>
                        <td style="text-align: center"><%= rs.getString("PRODUCT_NAME")%> <%= rs.getString("MODEL")%></td>
                        <td style="text-align: center"><%= rs.getString("PRODUCT_ID")%></td>
                        <td style="text-align: center"><%= rs.getFloat("COST_PRICE")%></td>
                        <td style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></td>
                        <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                        <td style="text-align: center"><%= rs.getString("DATE")%></td>
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
                   
                </table>
            </div>
        </div>
        <br>
        <%@include file = "footerpage.jsp" %>
    </div>
    <script>
    $('.select2').select2();
    </script>

    <script src="js/bootstrap.min.js"></script>
    <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
     $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        } 
  });
});
</script>
<script>
        $(document).ready(function() {
            $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        }
    </script>
    <script>
                                history.pushState(null, document.title, location.href);
                                window.addEventListener('popstate', function (event)
                                {
                                    history.pushState(null, document.title, location.href);
                                });
    </script>

    <% }%>
</body>
</html>
