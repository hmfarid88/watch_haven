<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
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
    <body id="">
        <%
            if ((session.getAttribute("admin") == null) || (session.getAttribute("admin") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <div class="container-fluid">
            <header>
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
                                <li><a href="admin_portal.jsp"><span class="fa fa-home"> Home</span></a></li>
                                <li id="drop"> <a href="#">Sale-Return</a>
                                    <div id="dropdown">
                                     <a data-toggle="modal" data-target="#saleback" href="#">Phone</a>
                                     <a data-toggle="modal" data-target="#acsaleback" href="#">Accessories</a>
                                    </div>
                                </li>
                                <li id="drop"><a href="#">Replacement</a>
                                      <div  id="dropdown" class=" dropdown-menu" >
                                        <a data-toggle="modal" data-target="#mreplace" href="#">Mobile</a>
                                        <a data-toggle="modal" data-target="#acreplace" href="#">Accessories</a>
                                      </div>
                                </li>
                                <li id="drop"><a href="#"> Stock-Out</a> 
                                <div id="dropdown">
                                     <a data-toggle="collapse" data-target="#demo" href="#">Phone</a>
                                     <a data-toggle="collapse" data-target="#acdemo" href="#">Accessories</a>
                                    </div>
                                </li>
                        <li>
                            <div style="margin: 10px 0" id="demo" class="collapse">
                                <form method="POST" action="stock_rollback.jsp" class="form-inline"> 
                                    <input type="text" pattern="[0-9]{15}" maxlength="15" minlength="15" size="10px" name="rollback" id="rollback" class="form-control"  placeholder="Input IMEI " value="" required="" >
                                    <input type="text" size="10px" name="note" class="form-control"  placeholder="Note" value="" required="" >
                                    <input type="submit" id="ok" class="btn btn-primary btn-sm" value="OK">
                                </form>  
                            </div>
                        </li>
                         
                                <li>
                                    <div style="margin: 10px 0" id="acdemo" class="collapse" >
                                        <form method="POST" action="accesor_stock_rollback.jsp" class="form-inline"> 
                                            <input type="text" size="10px" name="rollback" id="rollback" class="form-control"  placeholder="Product ID " value="" required="" >
                                              <input type="text" size="10px" name="note" class="form-control"  placeholder="Note" value="" required="" >
                                            <input type="submit" id="ok" class="btn btn-primary btn-sm" value="OK">
                                        </form> 
                                    </div>
                                </li>
                                <li id="drop">
                                    <a href="#"> Ledger-Book </a>
                                    <div  id="dropdown" class=" dropdown-menu">
                                        <a href="proprietor_list.jsp">Proprietor List</a>
                                        <a id="pl" href="proprietor_ledger.jsp">Proprietor Ledger</a>
                                    </div>
                                </li>
                                <li> <a data-toggle="modal" data-target="#propadd" href="#"> Add-Proprietor</a></li>
                                <li><a href="netblcheck.jsp"> Balance Compare</a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a data-toggle="modal" data-target="#ainfo" href="#"> Account Setting</a></li>
                                <li><a id="lout" href="AdminLogoutServlet"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>
            <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Ssymphonyy.getConnection();
                String query="select STATUS from hide_show where ITEM='Profit Ledger'";
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
                String query="select STATUS from hide_show where ITEM='Proprietor Ledger'";
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
                       
            try {
                con = Ssymphonyy.getConnection();
                String query="select STATUS from hide_show where ITEM='Cash Debit'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("cdstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Ssymphonyy.getConnection();
                String query="select STATUS from hide_show where ITEM='Cash Credit'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("ccstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            %>
            <div class="row">
                <div class="col-sm-12">
                 
                      <center>  <h3 style="font-family: fontawesome"><b>Admin Portal</b></h3></center>
                      <div class="row">
                          <div class="col-sm-2"></div>
                          <div class="col-sm-8">
                              <div id="checkbox-container">
                              <table border="1" space="2" class=" table table-bordered table-responsive">
                                  <col width="30%">
                                  <col width="20%">
                                  <col width="50%">
                                  <tr style="background-color: #000; color: #fff">
                                      <th>Item</th>
                                      <th>Status</th>
                                      <th>Action</th>
                                  </tr>
                                  <tr>
                                      <td><label>Profit Ledger</label></td>
                                      <td style="color: green"><b>${plstatus}</b></td>
                                      <td>
                                          <form method="post" action="ProfitShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                    <input type="radio" value="1"  name="profit" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="profit" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                  <tr>
                                      <td><label>Proprietor Ledger</label></td>
                                      <td style="color: green"><b>${prostatus}</b></td>
                                      <td>
                                         <form method="post" action="ProlShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="propritor" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="propritor" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                
                                
                                  <tr>
                                      <td><label>Cash Debit</label></td>
                                      <td style="color: green"><b>${cdstatus}</b></td>
                                      <td>
                                         <form method="post" action="DebitShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="debit" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="debit" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                 <tr>
                                      <td><label>Cash Credit</label></td>
                                      <td style="color: green"><b>${ccstatus}</b></td>
                                      <td>
                                         <form method="post" action="CreditShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="credit" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="credit" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                 
                              </table>
                              </div>
                          </div>
                          <div class="col-sm-2"></div>
                      </div>
                      
                </div>
            </div>
            <div style="margin-top: 20%">
              <%@include file = "footerpage.jsp" %>  
            </div>
       </div>
   <div id="saleback" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Sale Return</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form action="M_SaleBackServlet" method="POST" class="form-inline"> 
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Sold IMEI</label><br>
                                        <input style=" max-width: 80%" type="text" autocomplete="off" class="form-control"  name="soldime" placeholder="Sold IMEI" value="" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                       
                                    </div>
                                </div><br>
                                
                                <div class="row">
                                    <div class="col-sm-12">
                                <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                    </div>
                                    </div>
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
     <div id="acsaleback" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Sale Return</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form action="A_SaleBackServlet" method="POST" class="form-inline"> 
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Sold IMEI</label><br>
                                        <input style=" max-width: 80%" type="text" autocomplete="off" class="form-control"  name="soldime" placeholder="Sold IMEI" value="" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                       
                                    </div>
                                </div><br>
                                
                                <div class="row">
                                    <div class="col-sm-12">
                                <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                    </div>
                                    </div>
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
    <div id="ainfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Account-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Update-Account</legend>
                        <form method="POST" action="AdminPassUpServlet">
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>Current-ID</label>
                                    <input type="text" class="form-control input-sm" name="cid" required="">
                                </div>
                                <div class="col-sm-6">
                                    <label>Current-Password</label>
                                    <input type="password" class="form-control input-sm" name="cpass" required="">
                                </div>
                              
                            </div><br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>New-ID</label>
                                    <input type="text" class="form-control input-sm" name="newid" required="">
                                </div> 
                                <div class="col-sm-6">
                                    <label>New-Password</label>
                                    <input type="password" maxlength="6" minlength="6" class="form-control input-sm" name="newpass" required="">
                                </div>
                            </div><br>
                            <input type="submit" class="btn btn-success btn-sm" value="Update">
                        </form>
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
      <div id="propadd" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Proprietor-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Proprietor</legend>
                        <div class="container-fluid">
                            <form method="POST" action="ProprietorServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Proprietor Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="propname" required="" >
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Mobile Number :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="mnumber" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Address :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="address" required="">
                                    </div>
                                </div><br>
                               
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="OK"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form>
                        </div>
                        
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>  
    <div id="mreplace" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Mobile-Phone Replacement</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form action="M_sale_replace_Servlet" method="POST" class="form-inline"> 
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Sold IMEI</label><br>
                                        <input type="text" pattern="[0-9]{15}" maxlength="15" minlength="15" autocomplete="off" class="form-control"  name="soldime" placeholder="Sold IMEI" value="" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>New IMEI</label><br>
                                        <input type="text" autocomplete="off" pattern="[0-9]{15}" maxlength="15" minlength="15" class="form-control"  name="newime" placeholder="New IMEI " value="" required="" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Discount</label><br>
                                        <input type="text" class="form-control"  name="dis" placeholder="Discount " value="0" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Note</label><br>
                                        <input type="text" class="form-control"  name="disnote" placeholder="Note " value="No" >
                                    </div>
                                </div> <br>
                                <div class="row">
                                    <div class="col-sm-12">
                                <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                    </div>
                                    </div>
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
    <div id="acreplace" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Accessories Replacement</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form action="A_sale_replace_Servlet" method="POST" class="form-inline"> 
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Sold IMEI</label><br>
                                        <input type="text" autocomplete="off" pattern="[0-9]{8}" maxlength="8" minlength="8"  class="form-control"  name="soldime" placeholder="Sold Product" value="" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>New IMEI</label><br>
                                        <input type="text" autocomplete="off" pattern="[0-9]{8}" maxlength="8" minlength="8" class="form-control"  name="newime" placeholder="New Product " value="" required="" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Discount</label><br>
                                        <input type="text" class="form-control"  name="dis" placeholder="Discount " value="0" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Note</label><br>
                                        <input type="text" class="form-control"  name="disnote" placeholder="Note " value="No" >
                                    </div>
                                </div> <br>
                                <div class="row">
                                    <div class="col-sm-12">
                                <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                    </div>
                                    </div>
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
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
       
            <% } %>
    </body>
</html>
