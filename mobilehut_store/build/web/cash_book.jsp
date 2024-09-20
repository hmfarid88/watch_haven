
<%@page import="Model.CashModel"%>
<%@page import="Controller.ProfitAnalyse"%>
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
    <body style="background-color: #030303">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    <div id="main" class="container-fluid" style="background-color: #030303; ">
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
                   
                    <li style="margin-left: 10px"> <a href="home.jsp"><span class="fa fa-home"></span> Home</a></li>
                    <li id="drop" >
                        <a href="#" >Voucher</a>
                        <div id="dropdown" class="dropdown-menu">
                            <a  href="Monthly_Debit_voucher.jsp">Debit Voucher</a>
                            <a  href="Monthly_Credit_voucher.jsp">Credit Voucher</a>
                            <a  href="Monthly_Payment_voucher.jsp" >Payment Voucher</a>
                            <a  href="monthly_cost_view.jsp" >Cost Voucher</a>
                            <a  href="monthly_vat_view.jsp" >Vat Voucher</a>
                            <a  href="profit_cost_view.jsp" >Profit-Cost Voucher</a>
                            <a  href="monthly_card_transition.jsp" >Card Transaction</a>
                            <a  href="due_ledger.jsp" >Due Ledger</a>
                        </div>
                    </li>
                    <li><a  data-toggle="collapse" data-target="#datecash" href="#">Prev Cash-Book</a></li>
                    <li>
                        <div style="margin: 10px 15px" id="datecash" class="collapse">
                            <form method="POST" action="datewise_cashbook.jsp" class="form-inline">
                                <input type="date" autocomplete="off" size="10px" class="form-control" name="date1" value="" placeholder="Select Date" required="" >
                                <input type="submit" class="btn btn-primary btn-sm" value="Ok">
                            </form>
                        </div>
                    </li>
                    <li><a  data-toggle="collapse" data-target="#prevbl" href="#">Prev Balance</a></li>
                    <li>
                       <div style="margin: 10px 15px" id="prevbl" class="collapse">
                     <form method="POST" action="Net_balance_list.jsp" class="form-inline" >
                        <input type="date" autocomplete="off" size="10px" class="form-control"  name="date1" value="" placeholder="Start Date" required="" >
                        To <input type="date" autocomplete="off" size="10px" class="form-control" name="date2" value="" placeholder="End Date" required="" >
                        <input type="submit" class="btn btn-primary" value="Ok">
                    </form>
                       </div>
                    </li>
                    <li><a data-toggle="modal" data-target="#cardinfo" href="#">Add Card-Pay</a></li>
                          
                         
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
                String query="select ACTION from hide_show where ITEM='Cash Debit'";
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
                String query="select ACTION from hide_show where ITEM='Cash Credit'";
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
        <input type="text" style="display: none" id="cdstatus" value="${cdstatus}" >
      <input type="text" style="display: none" id="ccstatus" value="${ccstatus}" >
        <div class="col-sm-2" style="background-color: #030303; color: #ffffff; height: 600px  "  >
            <br>
            <div id="cd">
            <input  type="button" data-toggle="collapse" data-target="#myDIV" class="form-control btn btn-success"  value="Cash Debit"><br> <br>
            <div id="myDIV" class="collapse">
                <center>
                    <form id="debitform" method="POST" action="DebitCreditServlet">
                        <label> Debit Name :</label>
                        <input type="text" class="form-control" name="debitby" id="debitby" value="" required  placeholder="Debit Name">
                        <label>Amount :</label>
                        <input type="number" class="form-control" name="debit" id="debit" value="" required  placeholder="Amount">
                        <br>
                        <input type="submit" id="debitok" class="btn btn-primary" value="Ok">
                    </form>
                    <script>
                        $(document).ready(function () {
                            $("#debitform").submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
                    </script>
                    <br>
                </center>
            </div>
            </div>
            <div id="cc">
            <input  data-toggle="collapse" data-target="#myDIV2" type="button" class="form-control btn btn-success" value="Cash Credit"> <br> <br>
            <div id="myDIV2" class="collapse" >
                <center>                 
                    <form id="creditdorm" method="POST" action="Credit_BalanceServlet">
                        <label> Credit Name :</label>
                        <input type="text" class="form-control" name="creditby" id="creditby" value="" required="" placeholder="Credit Name">
                        <label>Amount :</label>
                        <input type="number" class="form-control" name="credit" id="credit" value="" required="" placeholder="Amount" >
                        <br>
                        <input type="submit" id="creditok" class="btn btn-primary" value="Ok">
                    </form>
                    <script>
                        $(document).ready(function () {
                            $("#creditdorm").submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
                    </script>
                    <br>
                </center>
            </div>
            </div>
           <input data-toggle="collapse" data-target="#myDIV22" type="button" class="form-control btn btn-success" value="Retailer Payment"> <br> <br>
            <div id="myDIV22" class="collapse" >
                <center>                 
                    <form id="retpay" method="POST" action="RetailerpayServlet">
                        <label> Retailer Name :</label>
                        <select   name="rtname" id="paymentname" class="form-control"  required="" >
                            <option value="">Select Retailer</option>
                            <%
                               
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select distinct R_NAME from retailer_info ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("R_NAME")%>"><%= rs.getString("R_NAME")%></option>
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

                        <label>Amount :</label>
                        <input type="number" class="form-control" name="amount" id="credit" value="" required="" placeholder="Amount" >
                        <br>
                        <input type="submit" id="creditok" class="btn btn-primary" value="Ok">
                    </form>
                    <script>
                        $(document).ready(function () {
                            $("#retpay").submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
                    </script>
                    <br>
                </center>
            </div>
            <input data-toggle="collapse" data-target="#myDIV3" type="button" class="form-control btn btn-success"  value=" Company Payment"><br><br>

            <div id="myDIV3" class="collapse" >
                <center>
                    <form id="payform" method="POST" action="Cash_PaymentServlet">
                        <label> Company Name :</label>
                        <select   name="paymentname" id="paymentname" class="form-control"  required="" >
                            <option value="">Select Vendor</option>
                            <%
                                
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select distinct VENDOR from vendor_stock ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("VENDOR")%>"><%= rs.getString("VENDOR")%></option>
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

                        <label>Amount :</label>
                        <input type="number" class="form-control" name="payamount" id="payamount" value="" required="" placeholder="Amount">

                        <br>
                        <input type="submit" id="payok" class="btn btn-primary" value="Ok">
                    </form>
                     <script>
                        $(document).ready(function () {
                            $("#payform").submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
                    </script>
                </center>
                <br>
            </div>
            <input data-toggle="collapse" data-target="#myDIV4" type="button" class="form-control btn btn-success"  value=" Cost Entry"><br><br>
            <div id="myDIV4" class="collapse" >
                <center>
                    <form id="costform" method="POST" action="CostEntreServlet">
                        <label>Cost Name :</label>
                         <select  name="costname" id="costname" class="form-control input-sm" required="">
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
                                        </select>
                       
                        <label>Note :</label>
                        <input type="text" class="form-control" name="note" id="amount" value="" required="" placeholder="Note">

                                        <label>Amount :</label>
                        <input type="text" class="form-control" name="amount" id="amount" value="" required="" placeholder="Amount">

                        <br>
                        <input type="submit" id="costok" class="btn btn-primary"  value="Ok">
                    </form>
                    <script>
                        $(document).ready(function () {
                            $("#costform").submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
                    </script>
                </center>
                <br>
            </div>
           <input data-toggle="collapse" data-target="#myDIV44" type="button" class="form-control btn btn-success"  value="Profit Cost"><br><br>
            <div id="myDIV44" class="collapse" >
                <center>                 
                    <form id="profitcost" method="POST" action="ProfitCostServlet">
                        <label> Cost Name :</label>
                        <input type="text" class="form-control" name="profitcost" id="pcost" value="" required="" placeholder="Cost Name">
                        <label>Amount :</label>
                        <input type="number" class="form-control" name="amount" id="pcostamount" value="" required="" placeholder="Amount" >
                        <br>
                        <input type="submit" id="creditok" class="btn btn-primary" value="Ok">
                    </form>
                    <script>
                        $(document).ready(function () {
                            $("#profitcost").submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
                    </script>
                    <br>
                </center>
            </div>
            <input type="button" data-toggle="modal" data-target="#bnktrnsi" class="form-control btn btn-success"  value="Bank Transaction"><br><br>
            <!--<input type="button" data-toggle="modal" data-target="#propitercost" class="form-control btn btn-success"  value="Propritor Transaction"><br><br>-->
             <input data-toggle="modal" data-target="#duetransaction" type="button" class="form-control btn btn-success"  value=" Due Transaction">
        </div>
       <div class="col-sm-10">

            <div id="div_print" style="color: #ffffff; background-color: #030303">
                <center> <h3>Cash Book</h3>
                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                </center>
                <center>
                    <table  border="2" width="90%" class=table-responsive" >
                        <thead>
                            <tr>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Description</th>
                                <th style="text-align: center">Voucher No</th>
                                <th style="text-align: center">Debit</th>
                                <th style="text-align: center">Credit</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <%
                                   
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query = "select AMOUNT, DATE from netbalance where DATE !=CURDATE() order by SI_NO DESC LIMIT 1";
                                        ps=con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                            request.setAttribute("date", rs.getString("DATE"));
                                            request.setAttribute("amount", rs.getFloat("AMOUNT"));
                                        }
                                    } catch (Exception ex) {
                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                                <td style="text-align: center">${date}</td>
                                <th style="text-align: center">Opening Balance</th>
                                <td></td>
                                <th style="text-align: center">${amount}</th>
                                <td></td>
                            </tr>
                            <tr>   
                                <%
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query = "select INVOICE_NO, GRAND_TOTAL, DATE  from  paymentinfo where GRAND_TOTAL>0 and  DATE=CURDATE()";
                                        ps=con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                         
                                %>

                                <td style="text-align: center"><%= rs.getString("DATE")%></td> 
                                <td style="text-align: center">Cash Sale </td> 
                                <td style="text-align: center"><%= rs.getString("INVOICE_NO")%></td> 
                                <td style="text-align: center"><%= rs.getFloat("GRAND_TOTAL")%></td> 
                                <td style="text-align: center"></td> 


                            </tr>
                            <tr>
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
                                        String query = "select DEBIT_NAME, AMOUNT, DATE from debitbalance where DATE=CURDATE() ";
                                        ps=con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {

                                %>

                                <td style="text-align: center"><%= rs.getString("DATE")%></td>  
                                <td style="text-align: center">(DR) <%= rs.getString("DEBIT_NAME")%></td> 
                                <td></td>
                                <td style="text-align: center"><%= rs.getFloat("AMOUNT")%></td> 
                                <td></td>
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
                            <tr>
                                <%
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query = "select CREDIT_NAME, AMOUNT, DATE from creditbalance where DATE=CURDATE()";
                                        ps=con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {

                                %> 

                                <td style="text-align: center"><%= rs.getString("DATE")%></td>  
                                <td style="text-align: center">(CR) <%= rs.getString("CREDIT_NAME")%></td> 
                                <td></td>
                                <td></td>
                                <td style="text-align: center"><%= rs.getFloat("AMOUNT")%></td> 

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
                            <tr>
                                <%
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query = "select PAYMENT_NAME, AMOUNT,  DATE from cashpayment where DATE=CURDATE() ";
                                        ps=con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {

                                %> 

                                <td style="text-align: center"><%= rs.getString("DATE")%></td>  
                                <td style="text-align: center"><%= rs.getString("PAYMENT_NAME")%></td> 
                                <td></td>
                                <td></td>
                                <td style="text-align: center"><%= rs.getFloat("AMOUNT")%></td> 

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
                            <tr>
                                <%
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query = "select COST_NAME, NOTE, AMOUNT, DATE from cost where DATE=CURDATE() ";
                                        ps=con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {

                                %> 

                                <td style="text-align: center"><%= rs.getString("DATE")%></td>  
                                <td style="text-align: center"><%= rs.getString("COST_NAME")%> (<%= rs.getString("NOTE")%>)</td> 
                                <td></td>
                                <td></td>
                                <td style="text-align: center"><%= rs.getFloat("AMOUNT")%></td> 

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
                            <%
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select sum(GRAND_TOTAL) as totalsale from paymentinfo where DATE=CURDATE() ";
                                    ps=con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("totalsle", rs.getFloat("totalsale"));
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select sum(AMOUNT) as totaldbt from debitbalance where DATE=CURDATE() ";
                                    ps=con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("totaldebet", rs.getFloat("totaldbt"));
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select sum(AMOUNT) as totalcredt from creditbalance where DATE=CURDATE() ";
                                    ps=con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("totalcredet", rs.getFloat("totalcredt"));
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select sum(AMOUNT) as totalpay from cashpayment where DATE=CURDATE() ";
                                    ps=con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("totalpayment", rs.getFloat("totalpay"));
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                                try {
                                    con = Ssymphonyy.getConnection();
                                    String query = "select sum(AMOUNT) as totalcost from cost where DATE=CURDATE() ";
                                    ps=con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("totlcost", rs.getFloat("totalcost"));
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                            %>
                            <tr style="border-bottom-color: black">

                                <th style="text-align: center;border-left-style: hidden"></th>
                                <th style="text-align: center;border-left-style: hidden"></th>
                                <th style="text-align: center;border-left-style: hidden"></th>
                                <th style="text-align: center;border-left-style: hidden"><u>${amount+totalsle+totaldebet}</u></th>
                                <th style="text-align: center;border-left-style: hidden;border-right-style: hidden"><u>${totalcredet+totalpayment+totlcost}</u></th>
                            </tr>
                            <tr style="border-style: hidden">
                                <th style="text-align: center;border-style: hidden"></th>
                                <th style="text-align: center;border-style: hidden"></th>
                                <th style="text-align: center;border-style: hidden">Net Balance</th>
                                <th style="text-align: center;border-style: hidden"><u>${(amount+totalsle+totaldebet)-(totalcredet+totalpayment+totlcost)}</u></th>
                                <th style="text-align: center;border-style: hidden"></th>
                            </tr>
                            
                        </tbody>
                    </table>
                   </center>
            </div>
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
    </div><br><br>
    <div id="bnktrnsi" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Bank-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="BankTranServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Bank Name</label> 
                                        <select class="form-control" name="bank">
                                            <option value="">Bank Select</option>
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
                                    </div>   
                                    <div class="col-sm-6">
                                        <label>Transaction Type</label>
                                        <select name="type" class="form-control" required="">
                                            <option value="">Select Type</option>
                                            <option value="Deposit">Deposit</option>
                                            <option value="Withdraw">Withdraw</option>
                                        </select>
                                    </div>

                                </div><br>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="rate9" style="width: 90%" autocomplete="off" class="form-control input-sm" name="amount" required="">
                                        
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Branch Name</label>
                                        <input type="text" class="form-control input-sm" name="branch" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Payer/Receiver</label>
                                        <input type="text" class="form-control input-sm" name="payer" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">  
                                    </div> 
                                </div>
                            </form><hr style="background-color: green">
                            <form method="POST" action="BanktranDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Bank Transaction-Delete</label>
                                        <select  name="transi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            try {
            con = Ssymphonyy.getConnection();
            String query = "select SI_NO, TYPE, AMOUNT, BANK  from bank_transition where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()){
                                            %>
                                            <option value="<%= rs.getInt("SI_NO")%>"><%= rs.getString("BANK") %>(<%= rs.getString("TYPE") %>, <%= rs.getLong("AMOUNT") %>)</option>
                                            <% }
}catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                            %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
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
    <div id="propitercost" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Proprietor-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="PropitercostServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Transaction Name</label>
                                        <select style=" width: 80%" class="form-control input-sm" name="name" required="">
                                            <option value="">Select Item</option>
                                            <option value="Payment">Payment</option>
                                            <option value="Receive">Receive</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Proprietor Name</label>
                                        <select style=" width: 80%" class="form-control input-sm" name="propname" required="">
                                            <option value="">Select Proprietor</option>
                                           <%
                                        
        try {
            con = Ssymphonyy.getConnection();
            String query = "select P_NAME from proprietor_info order by P_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                                 %>
                                                 <option value="<%=rs.getString("P_NAME") %>"> <%= rs.getString("P_NAME")%></option>
                                    <%}
                                    }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="rate1" autocomplete="off" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form><hr style="background-color: green">
                            <form method="POST" action="ProTrDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Proprietor Transaction-Delete</label>
                                        <select  name="transi" class="form-control input-sm" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            try {
            con = Ssymphonyy.getConnection();
            String query = "select SI_NO, PAY_NAME, PAYMENT, RECEIVE  from proprietor_cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
           
                                            %>
                                            <option value="<%= rs.getInt("SI_NO") %>"><%= rs.getString("PAY_NAME") %>(<%= rs.getString("PAYMENT") %>/<%= rs.getString("RECEIVE") %>)</option>
                                            <% }
 }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                            %>
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
    <div id="cardinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Card-Payment</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CardPayEditServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                       <label>Invoice No</label>
                                       <select class="form-control input-sm" name="invoice" required="">
                                            <option value="">Select Invoice</option>
                                             <%
                                                  try {
            con = Ssymphonyy.getConnection();
            String query = "select INVOICE_NO from paymentinfo where DATE=CURDATE() ";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                                   %>
                                                   <option value="<%= rs.getString("INVOICE_NO") %>"><%= rs.getString("INVOICE_NO") %></option>
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
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Bank Name</label> 
                                        <select class="form-control input-sm" name="bank" required="">
                                            <option value="">Bank Select</option>
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
                                    </div>   
                                   
                                </div><br>
                                <div class="row">
                                     <div class="col-sm-6">
                                        <label>Card No</label>
                                        <input type="text" name="cardno" class="form-control input-sm" value="" required=""> 
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Amount</label>
                                        <input type="number" id="rate9" style="width: 90%" autocomplete="off" class="form-control input-sm" name="amount" required="">
                                        
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">  
                                    </div> 
                                </div>
                            </form><hr style="background-color: green">
                           
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
<div id="duetransaction" class="modal fade" style="color: #030303" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Due-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form id="duetrac" method="POST" action="DuetracServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Tran. Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" name="tname" required="">
                                            <option value="">Select Item</option>
                                            <option value="Payment">Payment</option>
                                            <option value="Receive">Receive</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Due Person</label>
                                        <select style=" width: 90%" class="form-control input-sm" name="duename" required="">
                                            <option value="">Select Person</option>
                                           <%
                                        
        try {
            con = Ssymphonyy.getConnection();
            String query = "select P_NAME from due_person order by P_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                                 %>
                                                 <option value="<%=rs.getString("P_NAME") %>"> <%= rs.getString("P_NAME")%></option>
                                    <%}
                                    }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                        </select>
                                    </div>
                                        <div class="col-sm-4">
                                        <label>Reference</label>
                                        <input type="text" name="ref" class="form-control input-sm" style=" width: 90%" required="">
                                    </div>
                                </div><br>
                                        <div class="row">
                                    <div class="col-sm-6">
                                        <label>Payable Date</label>
                                        <input type="date" name="paydate" class="form-control input-sm" style=" width: 90%" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="rate1" autocomplete="off" style=" width: 90%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div>
                            <br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form>
                                        <script>
                        $(document).ready(function () {
                            $("#duetrac").submit(function () {
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
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <%@include file = "footerpage.jsp" %> 
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>   
      <script>
      $(document).ready(function () { 
         var t = document.getElementById('cdstatus').value;
          var u = document.getElementById('ccstatus').value;
          
      if(t == 1){
         $("#cd").show(); 
       }else{
        $("#cd").hide();    
       };
       if(u == 1){
         $("#cc").show(); 
       }else{
        $("#cc").hide();    
       };
       
      });
   </script>
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
 
     pdf.save("CashBook.pdf");
        });
});
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

    <%
        }
    %>
</body>
</html>
