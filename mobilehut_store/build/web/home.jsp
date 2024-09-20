<%@page import="Model.CashModel"%>
<%@page import="Controller.ProfitAnalyse"%>
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
        <script src="js/angular.min.js"></script>
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
    <body ng-app="myApp" ng-controller="myCtrl" style=" background-color:#303030; height: 100%">

        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3 style=" color: #ffffff"> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>


    <div id="main" >
      
        <div id="logn"  class="panel panel-primary">            
        
            <nav id="nav" style="margin:0 auto;height: 105px; z-index: 1000; border-color: green" class="navbar navbar-inverse">
                <div  class=" container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>

                    </div>

                    <div class="collapse navbar-collapse" id="myNavbar" style="background-color: green; border-color: green">
                        <ul class="nav navbar-nav">

                            <li id="drop">
                                <a href="#"><button style=" margin: 5px 18px" class="btn btn-info"><span class="fa fa-database fa-2x"></span></button><br><b>Stock View</b></a>
                                <div id="dropdown" class="dropdown-menu" >
                                    <a  href="symstockview.jsp">Mobile Stock</a>
                                    <a  href="accessor_stockView.jsp">Accessories Stock</a>
                                    <a  href="demoStock.jsp">Demo Stock</a>
                                    <a  href="symfaultyview.jsp">Faulty Stock</a>
                                    <a href="m_delete_stock.jsp" >Del Stock(Mobile)</a>
                                    <a href="ac_delete_stock.jsp" >Del Stock(Acce)</a>
                                    <a href="exchangelist.jsp" >Exchanged List</a>
                                    <a  href="#" data-toggle="modal" data-target="#preentry">Previous Entry</a>
                                    <a  href="#" data-toggle="modal" data-target="#prestock">Prev Mobile Stock</a>
                                    <a  href="#" data-toggle="modal" data-target="#preaccstock">Prev Acce Stock</a>
                                </div>
                            </li>
                            <li id="drop">
                                <a href="#"> <button style=" margin: 5px 6px" class="btn btn-danger"><span class=" fa fa-sticky-note fa-2x"></span></button><br> <b>Ledger</b></a>
                                <div  id="dropdown" class=" dropdown-menu">
                                    <a href="symsellview.jsp">Sale Ledger</a>
                                    <a id="pr" href="symprofit.jsp">Profit Ledger</a>
                                    <a href="Monthly_vendorSale.jsp" >Vendor-Sale Ledger</a>
                                    <a href="bank_book.jsp">Bank Ledger</a>
                                    <a href="retailer_ledger.jsp">Retailer Ledger</a>
                                    <a href="monthly_offerlist.jsp">Offer Ledger</a>
                                    <a href="vendor_statement.jsp">Vendor Ledger</a>
                                    <a href="price_drop.jsp">Price-Drop List</a>
                                    <a href="summary_report.jsp">Report Summary</a>
                                </div>
                            </li>
                            <li>
                                <a id="cashbook" href="cash_book.jsp"> <button style=" margin: 5px 20px" class="btn btn-primary"><span class="fa fa-book fa-2x"></span></button><br><b> Cash Book</b></a>
                            </li>


                            <li id="drop">
                                <a href="#"> <button style=" margin: 5px 5px" class="btn btn-warning"><span class="fa fa-search fa-2x"></span></button><br><b>Search</b></a>
                                <div  id="dropdown" class=" dropdown-menu">
                                    <a  data-toggle="collapse" data-target="#dvshow" href="#">Mobile Phone</a>
                                    <a  data-toggle="collapse" data-target="#acdvshow" href="#">Accessories</a>
                                    <a data-toggle="collapse" data-target="#vendorvoucher" href="#">Vendor Invoice</a>
                                    <a data-toggle="collapse" data-target="#nmdivshow" href="#">Prev Invoice</a>
                                    <a href="voucher.jsp">Last Invoice</a>
                                </div>
                            </li>  
                            <li>
                                <div style="margin:25px 6px" id="dvshow" class="collapse">
                                    <form class="form-inline" method="POST" action="search_product.jsp" >
                                        <input type="text" autocomplete="off" class="form-control" size="15px" height="3px" name="imei"   value="" placeholder="Input IMEI" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#dvshow" value="Cancel">
                                    </form>
                                </div>
                            </li>
                            <li>
                                <div style="margin:25px 6px" id="acdvshow" class="collapse">
                                    <form class="form-inline" method="POST" action="ac_search_product.jsp" >
                                        <input type="text" autocomplete="off" class="form-control" size="15px" height="3px" name="imei"   value="" placeholder="Product No" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#acdvshow" value="Cancel">
                                    </form>
                                </div>
                            </li>
                            <li>
                                <div style="margin:25px 6px" id="nmdivshow" class=" collapse" >
                                    <form class="form-inline" method="POST" action="search_customer.jsp" >
                                        <input type="text" class="form-control" size="15px" name="mob" value="" placeholder="Mobile Number" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#nmdivshow" value="Cancel">
                                    </form>
                                </div>
                            </li>
                            <li>
                                <div style="margin:25px 6px" id="vendorvoucher" class=" collapse" >
                                    <form class="form-inline" method="POST" action="searched_vendor_voucher.jsp" >
                                        <input type="text" autocomplete="off" class=" form-control" size="15px" name="invono" value="" placeholder="Invoice No" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#vendorvoucher" value="Cancel">
                                    </form>
                                </div>
                            </li>
                            <li id="drop">
                                <a href="#"><button style=" margin: 5px 5px" class="btn btn-info"> <span class="fa fa-cogs fa-2x"></span></button> <br><b>Settings</b></a>
                                <div  id="dropdown" class=" dropdown-menu">
                                    <a  href="company_info.jsp"><span class="glyphicon glyphicon-info-sign"></span> Company Info</a>
                                    <a  href="userupdate_1.jsp"><span class="glyphicon glyphicon-edit"></span> Edit Account</a>
                                    <a data-toggle="modal" data-target="#vatinfo" href="#"><span class="glyphicon glyphicon-adjust"></span> Add Vat</a>
                                    <a data-toggle="modal" data-target="#admininfo" href="#"><span class="glyphicon glyphicon-user"></span> Admin Portal</a>
                                    <a data-toggle="modal" data-target="#bankinfo" href="#"><span class="glyphicon glyphicon-adjust"></span> Add Bank</a>
                                    <a data-toggle="modal" data-target="#rtinfo" href="#"><span class="glyphicon glyphicon-user"></span> Add Retailer</a>
                                    <a data-toggle="modal" data-target="#dueinfo" href="#"><span class="glyphicon glyphicon-user"></span> Add Due-Person</a>
                                    <a data-toggle="modal" data-target="#costinfo" href="#"><span class="glyphicon glyphicon-blackboard"></span> Cost-Name</a>
                                    <!--<a  href="mail_send.jsp"><span class="glyphicon glyphicon-envelope"></span> Mail Report</a>-->
                                    <a  href="data_backup.jsp"><span class="glyphicon glyphicon-save-file"></span> Data Backup</a>
                                </div>
                            </li>
                           
                        </ul>

                        <ul class="nav navbar-nav navbar-right">

                            <li>
                                <a id="lgn" href="LogoutServlet">  <button style=" margin: 5px 5px" class="btn btn-danger"> <span class="fa fa-sign-out fa-2x"></span></button> <br><b> Logout</b></a></li>
                        </ul> 
                    </div>
                </div>
            </nav>
<%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Ssymphonyy.getConnection();
                String query="select ACTION from hide_show where ITEM='Profit Ledger'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("plstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Ssymphonyy.getConnection();
                String query="select ACTION from hide_show where ITEM='Proprietor Ledger'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("prostatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            %>
            <%
                                            
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select COMPANY_NAME from companyinfo";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                rs.next();
                                                    request.setAttribute("company", rs.getString("COMPANY_NAME"));
                                                
                                            } catch (Exception ex) {
                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
            <input type="text" style="display: none" id="advalue" value="${plstatus}" >
            <input type="text" style="display: none" id="prostatus" value="${prostatus}" >
            <div id="bdy" style=" background-color:#303030; color: #ffffff" class="panel-body">
                
                <div class="row">
                    <div class="col-sm-12">
<h1 style="font-family: Stylish;  font-size: 4vw; color: red; text-shadow: 2px 2px 3px white;" class="text-uppercase text-center"><b>${company}</b></h1>
                    </div>
                </div>
                <div class="row">

                    <div class="col-sm-3">
                            <center>
                            <h2><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h2>
                            <h2>{{theTime}}</h2>
                            <script type="text/javascript">
                                        document.write("<center><font size=+2 style='color: white;'>");
                                        var day = new Date();
                                        var hr = day.getHours();
                                        if (hr >= 0 && hr < 12) {
                                            document.write("Good Morning!");
                                        } else if (hr === 12) {
                                            document.write("Good Noon!");
                                        } else if (hr >= 12 && hr <= 17) {
                                            document.write("Good Afternoon!");
                                        } else {
                                            document.write("Good Evening!");
                                        }
                                        document.write("</font></center>");
                            </script>
                        </center>
                    
                    </div>

                    <div class="col-sm-6">
                     
                        <br> <br> <div id="div_print" class="row">
                            <%
                                          
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select  sum(PRICE) as total, count(PRODUCT_ID) as tqty from mobilesell where SELL_DATE =CURDATE() ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    rs.next();
                                        request.setAttribute("saletotal", rs.getFloat("total"));
                                        request.setAttribute("tqty", rs.getInt("tqty"));
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
                                    String query = "select  sum(SELL_PRICE-DISCOUNT) as total, count(PRODUCT_ID) as tqty from accessor_sale where DATE =CURDATE() ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    rs.next();
                                        request.setAttribute("asaletotal", rs.getFloat("total"));
                                        request.setAttribute("atqty", rs.getInt("tqty"));
                                    } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %> 
                            <%
                               ResultSet rs1=null;
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String ldeposit="select sum(AMOUNT) from bank_transition where TYPE='Deposit'";
                                    ps = con.prepareStatement(ldeposit);
                                    rs = ps.executeQuery();
                                    rs.next();
                                        request.setAttribute("deposittotal", rs.getLong(1));
                                        String ldeposit2="select sum(AMOUNT) from bank_transition where TYPE='Withdraw'";
                                    ps = con.prepareStatement(ldeposit2);
                                    rs1 = ps.executeQuery();
                                    rs1.next();
                                        request.setAttribute("withtotal", rs1.getLong(1));
                                                                
                                    } catch (Exception ex) {
                                }finally {
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %> 
                            <%
                                String demo="Demo";
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select  sum(PURCHASE_PRICE) as total, count(IMEI) as tqty from stock  where MODEL not like '%"+ demo +"%'";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    rs.next();
                                        request.setAttribute("stocktotal", rs.getFloat("total"));
                                        request.setAttribute("stockqty", rs.getInt("tqty"));
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
                                    String query = "select  sum(COST_PRICE) as total, count(PRODUCT_ID) as tqty from accessoriesstock  ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    rs.next();
                                        request.setAttribute("astocktotal", rs.getFloat("total"));
                                        request.setAttribute("astockqty", rs.getInt("tqty"));
                                    } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %> 
                            <div class="col-sm-4 col-md-4">
                                <button class="btn btn-success btn-block"><h3><strong> Stock Info<br> ${stocktotal}|${stockqty}<br>${astocktotal}|${astockqty} </strong></h3></button>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <button class="btn btn-success btn-block"><h3><strong> Sale Info<br> ${saletotal}|${tqty}<br> ${asaletotal}|${atqty}</strong></h3></button>
                            </div>
                           <%                                
                                ProfitAnalyse pf = new ProfitAnalyse();
                                CashModel cam = pf.NetBalance();
                                Float netblance = cam.getNetbalance();

                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "update netbalance set AMOUNT=? where  DATE=CURDATE() ";
                                    ps = con.prepareStatement(query);
                                    ps.setFloat(1, netblance);
                                    int b = ps.executeUpdate();
                                    if (b > 0) {
                                    } else {
                                        String query1 = "insert into netbalance (AMOUNT, DATE) values (?,CURDATE())";
                                        ps = con.prepareStatement(query1);
                                        ps.setFloat(1, netblance);
                                        ps.executeUpdate();

                                    }
                                } catch (Exception ex) {
                                      }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                            %>
                            <div class="col-sm-4 col-md-4">
                                <%                                    
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query2 = "select AMOUNT from netbalance where  DATE =CURDATE()";
                                        ps = con.prepareStatement(query2);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                            request.setAttribute("nbalance", rs.getFloat("AMOUNT"));
                                        }
                                    } catch (Exception ex) {

                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                                <button class="btn btn-success btn-block"><h3><strong>Balance <br>Cash | Bank <br> ${nbalance} |${deposittotal-withtotal}</strong></h3></button> 

                            </div>

                        </div>
                        <fieldset class="scheduler-border">
                            <legend style=" color: #ffffff" class="scheduler-border">Entry Area</legend>
                            <center>   <br><br>
                                <div class="row">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-6">
                                        <a href="symstockentry.jsp"><button type="button" class="btn btn-success form-control ">Mobile-Entry</button></a><br><br>
                                        <a href="symaccesor_entry.jsp"><button type="button" class="btn btn-success form-control ">Accessories-Entry</button></a><br><br>
                                        <a href="symmobilesell.jsp"><button type="button" class="btn btn-success form-control ">Customer-Sale</button></a><br><br>
                                        <a href="Vendor_sale.jsp"><button type="button" class="btn btn-success form-control ">Vendor-Sale</button></a>
                                    </div>
                                    <div class="col-sm-3"></div>
                                </div>
                             
                            </center>
                        </fieldset>
                    </div>
                    <div class="col-sm-3">

                    </div>

                </div>
                                
            </div>
        </div>
 
    </div> 
   <%@include file = "footerpage.jsp" %>   
   <div id="admininfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                   
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Admin Login</legend>
                        <form method="POST" action="AdminLoginServlet">
                           
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>User ID</label>
                                    <input type="text" class="form-control input-sm" name="userid" required="">
                                </div> 
                                <div class="col-sm-6">
                                    <label>Password</label>
                                    <input type="password" maxlength="6" minlength="6" pattern="[0-9]{6}" class="form-control input-sm" name="password" required="">
                                </div>
                            </div><br>
                            <input type="submit" class="btn btn-success btn-sm" value="GO">
                        </form>
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
   <div id="rtinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Retailer-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Retailer</legend>
                        <div class="container-fluid">
                            <form method="POST" action="RetailerAddServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Retailer Name :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="rtname" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Mobile Number :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="mnumber" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Address :</label>
                                        <input style="width: 95%"  type="text" class="form-control input-sm" value="" name="address" required="">
                                    </div>
                                   
                                </div><br>
                               
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="OK"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form>
                        </div><hr style=" background-color: green">
                        <div class="container-fluid">
                           
                                    <div class="col-sm-6">
                                        <form method="POST" action="RetailerDelServlet">
                                <label>Delete Retailer :</label>
                                <select  class="form-control" name="retailer" required="" >
                                    <option value="">Select-Retailer</option>
                                    <%
                                        try {
            con = Ssymphonyy.getConnection();
            String query = "select R_NAME from retailer_info order by R_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                                    %>
                                                    <option value="<%= rs.getString(1) %>"> <%= rs.getString(1) %></option>
                                                    <%
                                                     }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
%>
                                </select><br>
                                <input type="submit" class="btn btn-danger btn-sm" value="Delete">
                            </form>
                                    </div>       
                            
                        </div>
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
   
    
   <div id="bankinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Bank</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="BankaddServlet">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <label>Bank Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="bankname" required=""><br>
                                        
                                    </div>
                                    <div class="col-sm-4">
                                        <label>POS Charge(%)</label>
                                       <input type="number" step="0.01" style=" width: 80%" class="form-control input-sm" name="rate" required=""> 
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class=" btn btn-success" value="OK">
                                    </div>
                                </div>
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
<div id="preentry" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Previous Entry</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="previousentry.jsp">
                                <label>Select Date</label><br>
                                <input type="date" autocomplete="off" style=" width: 50%" class="form-control" name="date" required=""><br>
                                <input class="btn btn-success btn-sm" type="submit" value="GO">
                            </form>   
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="prestock" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Previous Stock</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="previousstock.jsp">
                                <label>Select Date</label><br>
                                <input type="date" autocomplete="off" style=" width: 50%" class="form-control" name="date" required=""><br>
                                <input class="btn btn-success btn-sm" type="submit" value="GO">
                            </form>   
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="preaccstock" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Previous Stock</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="previous_accessor_stock.jsp">
                                <label>Select Date</label><br>
                                <input type="date" autocomplete="off" style=" width: 50%" class="form-control" name="date" required=""><br>
                                <input class="btn btn-success btn-sm" type="submit" value="GO">
                            </form>   
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="costinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Cost-Name</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CostaddServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Cost Name</label>
                                        <input type="text" style=" width: 70%" class="form-control input-sm" name="fname" required=""><br>
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">
                                    </div>
                                </div>
                            </form><hr style=" background-color: black">
                            <form method="POST" action="CostDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Delete Cost-Name</label>
                                        <select style=" width: 70%" name="costname" class="form-control input-sm" required="">
                                            <option value="">Select Cost</option>
                                         <%   try {
            con = Ssymphonyy.getConnection();
            String query = "select COST_NAME  from cost_name";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()){
                                            %>
                                            <option value="<%= rs.getString("COST_NAME")%>"><%= rs.getString("COST_NAME") %></option>
                                            <% }
           }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}      %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div> 
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
    <div id="dueinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Due Person-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Due Person</legend>
                        <div class="container-fluid">
                            <form method="POST" action="DuePersonAddServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Person Name :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="rtname" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Mobile Number :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="mnumber" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Address :</label>
                                        <input style="width: 95%"  type="text" class="form-control input-sm" value="" name="address" required="">
                                    </div>
                                   
                                </div><br>
                               
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="OK"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form>
                        </div><hr style=" background-color: green">
                        <div class="container-fluid">
                           
                                    <div class="col-sm-6">
                                        <form method="POST" action="due_person_details.jsp">
                                <label>Due Person Edit:</label>
                                <select  class="form-control" name="dueperson" required="" >
                                    <option value="">Select Due-Person</option>
                                    <%
                                        try {
            con = Ssymphonyy.getConnection();
            String query = "select P_NAME from due_person order by P_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                                    %>
                                                    <option value="<%= rs.getString(1) %>"> <%= rs.getString(1) %></option>
                                                    <%
                                                     }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
%>
                                </select><br>
                                <input type="submit" class="btn btn-primary btn-sm" value="GO">
                            </form>
                                    </div>       
                            
                        </div>
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="vatinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Vat</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="VatServlet">
                                <div class="row">
                                  
                                    <div class="col-sm-6">
                                        <label>VAT (%)</label>
                                       <input type="number" step="0.01" style=" width: 80%" class="form-control input-sm" name="vatrate" required=""> 
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class=" btn btn-success" value="OK">
                                    </div>
                                </div>
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
  <script src="js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
   <script>
      $(document).ready(function () { 
          var p = document.getElementById('advalue').value;
          var q = document.getElementById('prostatus').value;
          
       if(p == 1){
         $("#pr").show(); 
       }else{
        $("#pr").hide();    
       };
       if(q == 1){
         $("#pl").show(); 
       }else{
        $("#pl").hide();    
       };
       
      });
   </script>
    <script>
                $(document).ready(function () {
                    $("#lgn").click(function () {

                        if (confirm("Are you sure to logout?"))
                            document.forms[0].submit();
                        else
                            return false;
                    });
                });
    </script>

    <script type="text/javascript">
                var myVar = setInterval(function () {
                    myTimer();
                }, 1000);
                var counter = 0;
                function myTimer() {
                    var date = new Date();
                    document.getElementById("demo").innerHTML = date.toISOString();
                };
    </script>
    <script>
                var app = angular.module('myApp', []);
                app.controller('myCtrl', function ($scope, $interval) {
                    $scope.theTime = new Date().toLocaleTimeString();
                    $interval(function () {
                        $scope.theTime = new Date().toLocaleTimeString();
                    }, 1000);

                });

    </script>
   
    <%     }
    %>
</body>
</html>

