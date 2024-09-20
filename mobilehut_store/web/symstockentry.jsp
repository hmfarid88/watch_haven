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
    <div class="container-fluid">
        <div class="panel panel-primary" style="background-color: #CCCCCC" >
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
                        
                        <li style="margin-left: 50px"><a href="home.jsp" ><span class="fa fa-home"></span> Home</a></li>
                        <li> <a href="model_colorEntry.jsp" ><span class="fa fa-cog"></span> Settings</a></li>
                        <li><a href="totalStock.jsp"><span class="fa fa-sticky-note"></span> Stock-Details</a> </li>
                        
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                        
                    </ul>
                </div>

            </nav>
            <div class="panel-body">

                <div class="container">
                    <div class="row">
        
                        <div class="col-sm-6">
                            <center>

                                <h2>Mobile-Stock-Entry</h2><hr style="background-color: green">


                                <table class="table" >
                                   
                                    <tbody>

                                        <tr>
                                              <td>
                                                <form  method="POST" action="Brand_Servlet">
                                                    <select onchange="this.form.submit()"  name="brand"  class="form-control select2"  required="" >
                                                        <option value="">Brand</option>
                                                        <%
                                                            Connection con = null;
                                                            PreparedStatement ps = null;
                                                            ResultSet rs=null;
                                                            try {
                                                                con = Ssymphonyy.getConnection();
                                                                String query = "select BRAND_NAME from brand_name";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option  value="<%= rs.getString("BRAND_NAME")%>">  <%= rs.getString("BRAND_NAME")%>  </option>
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
                                                <form  method="POST" action="Model_Price_Servlet">
                                                    <select onchange="this.form.submit()"  name="mdl"  class="form-control select2"  required="" >
                                                        <option value="">Model</option>
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
                                                <form  method="POST" action="Color_showServlet">
                                                    <select onchange="this.form.submit()"   name="color" class="form-control select2" required="">
                                                        <option  value="">Color</option>
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
                                                </form>
                                               
                                            </td>
                                            <td> 
                                                <form method="POST" action="Vendor_ShowServlet">
                                                    <select onchange="this.form.submit()"  name="vendor"  class="form-control select2"  required="">
                                                        <option value="">Vendor</option>
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

                                   <form id="entryform"  method="POST" action="MstockServlet" >
                                   <table class="table" >
                                        <col width="50%">
                                        <col width="50%">
                                        <tbody>
                                            <tr>
                                                <td><label>BRAND NAME :</label></td>
                                                <td> <input type="text" name="brand" id="brand"  value="${BRAND}"  class="form-control" required="" ></td>
                                            </tr>
                                            <tr>
                                                <td><label>MODEL  NO :</label></td>
                                                <td> <input type="text" name="model" id="model"  value="${MODEL}"  class="form-control" required="" ></td>
                                            </tr>
                                            <tr>
                                                <td><label>PURCHASE'S  PRICE:</label></td>
                                                <td><input type="number" name="pprice" id="pprice"  value="${PURCH}" class="form-control" required="" ></td>

                                            </tr>
                                            <tr>
                                                <td><label>SALE PRICE:</label></td>   
                                                <td><input type="number" name="sprice" id="sprice"  value="${SALE}" class="form-control" required="" ></td>

                                            </tr>

                                            <tr>
                                                <td><label>COLOR  :</label></td>
                                                <td> <input type="text" name="color" id="clor" value="${COLOR}" class="form-control" required="" ></td>

                                            </tr>
                                            <tr>
                                                <td><label>VENDOR NAME  :</label></td>
                                                <td> <input type="text" name="vname" id="vname" value="${VENDOR}" class="form-control" required="" ></td>

                                            </tr>

                                            <tr>
                                                <td><label>IMEI :</label></td>
                                                <td><input type="text" pattern="[0-9]{15}" maxlength="15" minlength="15" name="imei" id="imei" value="" autofocus="" class="form-control" required="" ></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td><input type="submit"  class="btn btn-sm btn-primary" id="submit"  value="Entry">
                                                    <input type="reset" class="btn btn-sm btn-primary"  value="Reset"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </form>
                                                <script>
                $(document).ready(function () {
                    $("#submit").click(function () {

                        if (confirm("Are you sure to Entry?"))
                            document.forms[5].submit();
                        else
                            return false;
                    });
                });
    </script>
                         <script>
                            $(document).ready(function () {
                                $("#entryform").submit(function () {
                                    if (this.beenSubmitted)
                                        return false;
                                    else
                                        this.beenSubmitted = true;
                                });
                            });
                            $(function() {
                            $('#imei').on('keypress', function(e) {
                            if (e.which === 32)
                             return false;
                                 });
                             });
                        </script>
                            </center>
                        </div>
                        <div id="div_print" class="col-sm-6"><br><br>

                            <div class="row">
                                <center>
                                    <div class="col-sm-2"></div>
                                    <div class="col-sm-4">
                                        <%
                                            
                                            try {
                                                 
                                                con = Ssymphonyy.getConnection();                                              
                                                String query = "select count(IMEI) as qnt, sum(PURCHASE_PRICE) as totlprice from stock where DATE=CURDATE()";
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
                                        <label>Stock Quantity : </label><input style="background-color: #030303; color: #ffffff" type="text" size="5px" class="text-center form-control" value="${qty} PS " readonly="">  
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Stock Amount :  </label><input style="background-color: #030303; color: #ffffff" type="text" size="15px" class="text-center form-control" value=" ${tlprice} TK"  readonly="">
                                    </div>
                                    <div class="col-sm-2"></div>
                                </center>
                            </div><br>
                            <div  class="row">

                                <center>

                                    <table border="2" id="mobiletable" class=" table-striped table-responsive" width="100%" >
                                        <thead>
                                            <tr style="background-color: #030303; color: #ffffff">
                                                <th style="text-align: center">Model</th>
                                                <th style="text-align: center">Color</th>
                                                <th style="text-align: center">IMEI</th>
                                                <th style="text-align: center">P Price</th>
                                                <th style="text-align: center">S Price</th>
                                                <th style="text-align: center">Entry Date</th>

                                            </tr>
                                        </thead> 
                                        <tbody id="myTable">
                                        <%
                                            try {
                                                con = Ssymphonyy.getConnection();                           
                                                String query = "select BRAND, MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, DATE from stock where  DATE=CURDATE()";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <tr>

                                            <td style="text-align: center"><%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%></td>
                                            <td style="text-align: center"><%= rs.getString("COLOR")%></td>
                                            <td style="text-align: center"><%= rs.getString("IMEI")%></td>
                                            <td style="text-align: center"><%= rs.getFloat("PURCHASE_PRICE")%></td>
                                            <td style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></td>
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
                                </center>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file = "footerpage.jsp" %> 
    </div>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
    
    <script>
    $('.select2').select2();
    </script>
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
