
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
                    </ul>
                     <ul class="nav navbar-nav navbar-right">
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                </div>
            </nav>
            <div id="div_print">
                <center>
                    <h3>Cash Book</h3>
                    <h4>Date: ${param.date1}</h4>
                    <table  border="2" width="90%" class="table-striped table-responsive" >
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
                                    String date1 = request.getParameter("date1");
                                    Connection con = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs=null;
                                    ResultSet rs1=null;
                                    ResultSet rs2=null;
                                    ResultSet rs3=null;
                                    ResultSet rs4=null;
                                    ResultSet rs5=null;
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query = "select AMOUNT, DATE from netbalance where DATE<'" + date1 + "' order by SI_NO DESC LIMIT 1 ";
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
                                <th style="text-align: center">Balance B/D</th>
                                <td></td>
                                <th style="text-align: center">${amount}</th>
                                <td></td>
                            </tr>
                            <tr>   
                                <%
                                    try {
                                        con = Ssymphonyy.getConnection();
                                        String query = "select  GRAND_TOTAL, INVOICE_NO, DATE  from  paymentinfo where GRAND_TOTAL>0 and DATE=?";
                                        ps=con.prepareStatement(query);
                                        ps.setString(1, date1);
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
                                        String query = "select DEBIT_NAME, AMOUNT, DATE from debitbalance where DATE=? ";
                                        ps=con.prepareStatement(query);
                                        ps.setString(1, date1);
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
                                        String query = "select CREDIT_NAME, AMOUNT, DATE from creditbalance where DATE=? ";
                                        ps=con.prepareStatement(query);
                                        ps.setString(1, date1);
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
                                        String query = "select PAYMENT_NAME, AMOUNT, DATE from cashpayment where DATE=? ";
                                        ps=con.prepareStatement(query);
                                        ps.setString(1, date1);
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
                                        String query = "select COST_NAME, NOTE, AMOUNT, DATE from cost where DATE=? ";
                                        ps=con.prepareStatement(query);
                                        ps.setString(1, date1);
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
                                    String query = "select sum(GRAND_TOTAL) as totalsale from paymentinfo where DATE=? ";
                                    ps=con.prepareStatement(query);
                                    ps.setString(1, date1);
                                    rs = ps.executeQuery();
                                    rs.next();
                                        request.setAttribute("totalsle", rs.getFloat("totalsale"));
                                    String query1 = "select sum(AMOUNT) as totaldbt from debitbalance where DATE=? ";
                                    ps=con.prepareStatement(query1);
                                    ps.setString(1, date1);
                                    rs1 = ps.executeQuery();
                                    rs1.next();
                                        request.setAttribute("totaldebet", rs1.getFloat("totaldbt"));
                                        
                                        String query2 = "select sum(AMOUNT) as totalcredt from creditbalance where DATE=? ";
                                    ps=con.prepareStatement(query2);
                                    ps.setString(1, date1);
                                    rs2 = ps.executeQuery();
                                    rs2.next();
                                        request.setAttribute("totalcredet", rs2.getFloat("totalcredt"));
                                        String query3 = "select sum(AMOUNT) as totalpay from cashpayment where DATE=?";
                                    ps=con.prepareStatement(query3);
                                    ps.setString(1, date1);
                                    rs3 = ps.executeQuery();
                                    rs3.next();
                                        request.setAttribute("totalpayment", rs3.getFloat("totalpay"));
                                        
                                        String query4 = "select sum(AMOUNT) as totalcost from cost where DATE=?";
                                    ps=con.prepareStatement(query4);
                                    ps.setString(1, date1);
                                    rs4 = ps.executeQuery();
                                    rs4.next();
                                        request.setAttribute("totlcost", rs4.getFloat("totalcost"));
                                        
                                        String query5 = "select AMOUNT from netbalance where DATE<'" + date1 + "' order by SI_NO DESC LIMIT 1 ";
                                        ps=con.prepareStatement(query5);
                                        rs5 = ps.executeQuery();
                                        rs5.next();
         Double totalreceive=rs5.getDouble(1)+rs.getDouble(1)+rs1.getDouble(1);
         Double totalpayment=rs2.getDouble(1)+rs3.getDouble(1)+rs4.getDouble(1);
         Double nbl=totalreceive-totalpayment;
//         String balanceup="update netbalance set AMOUNT=? where DATE=?";
//                ps=con.prepareStatement(balanceup);
//                ps.setDouble(1, nbl);
//                ps.setString(2, date1);
//                ps.executeUpdate();
                                } catch (Exception ex) {
                                }finally {
   try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
   try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
   try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
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
            </div><br><br><br>
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
        <% } %>
    </body>
</html>
