<%-- 
    Document   : netblcheck
    Created on : May 18, 2021, 11:21:45 PM
    Author     : Acer
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
            if ((session.getAttribute("admin") == null) || (session.getAttribute("admin") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
      <%
                                    Connection con = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs0=null;
                                    ResultSet rs=null;
                                    ResultSet rs1=null;
                                    ResultSet rs2=null;
                                    ResultSet rs3=null;
                                    ResultSet rs4=null;
                                    ResultSet rs5=null;
                                    try {
                                    con = Ssymphonyy.getConnection();
                                    String date="select distinct DATE from netbalance";
                                    ps=con.prepareStatement(date);
                                    rs0 = ps.executeQuery();
                                    while(rs0.next()){
                                     String date1=rs0.getString("DATE");
                                    
                                    String query = "select sum(GRAND_TOTAL) as totalsale from paymentinfo where DATE=? ";
                                    ps=con.prepareStatement(query);
                                    ps.setString(1, date1);
                                    rs = ps.executeQuery();
                                    while(rs.next()){
                                    
                                    String query1 = "select sum(AMOUNT) as totaldbt from debitbalance where DATE=? ";
                                    ps=con.prepareStatement(query1);
                                    ps.setString(1, date1);
                                    rs1 = ps.executeQuery();
                                    while(rs1.next()){
                                                                               
                                        String query2 = "select sum(AMOUNT) as totalcredt from creditbalance where DATE=? ";
                                    ps=con.prepareStatement(query2);
                                    ps.setString(1, date1);
                                    rs2 = ps.executeQuery();
                                    while(rs2.next()){
                                       
                                        String query3 = "select sum(AMOUNT) as totalpay from cashpayment where DATE=?";
                                    ps=con.prepareStatement(query3);
                                    ps.setString(1, date1);
                                    rs3 = ps.executeQuery();
                                    while(rs3.next()){
                                                                             
                                        String query4 = "select sum(AMOUNT) as totalcost from cost where DATE=?";
                                    ps=con.prepareStatement(query4);
                                    ps.setString(1, date1);
                                    rs4 = ps.executeQuery();
                                    while(rs4.next()){
                                                                             
                                        String query5 = "select AMOUNT from netbalance where DATE<'" + date1 + "' order by SI_NO DESC LIMIT 1 ";
                                        ps=con.prepareStatement(query5);
                                        rs5 = ps.executeQuery();
                                        while(rs5.next()){
         Double totalreceive=rs5.getDouble(1)+rs.getDouble(1)+rs1.getDouble(1);
         Double totalpayment=rs2.getDouble(1)+rs3.getDouble(1)+rs4.getDouble(1);
         Double nbl=totalreceive-totalpayment;
         String balanceup="update netbalance set CH_BL=? where DATE=?";
                ps=con.prepareStatement(balanceup);
                ps.setDouble(1, nbl);
                ps.setString(2, date1);
                ps.executeUpdate();
                                        }}}}}}} } catch (Exception ex) {
                                }finally {
   try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
   try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
   try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                        } 
      %>
     
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
                             <li style="margin-left: 20px"> <a href="admin_portal.jsp"><span class="fa fa-home"></span> Home</a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
      
<%
try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select COMPANY_NAME from companyinfo";
                                                        ps=con.prepareStatement(query);
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
                        <div class="row">
                            <div class="col-sm-12">
                                <div id="div_print">
                                    <center>
                                        <h3>Nit Balance Compare Sheet</h3>
                                        <h4>Shop Name : ${company} </h4>
                                        <h4> Reporting Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                        <hr>
                                        <table border="2" class=" table-striped table-responsive" width="70%" id="mobiletable" >
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">SN</th>
                                                    <th style="text-align: center">Date</th>
                                                    <th style="text-align: center">Nit Balance</th>
                                                    <th style="text-align: center">Checked Balance</th>
                                                    <th style="text-align: center">Difference</th>
                                                 </tr>
                                            </thead> 
                                            <tbody>
                                                <%
                                                  
                                                    try {
                                                        con = Ssymphonyy.getConnection();
                                                        String query = "select AMOUNT, CH_BL, DATE from netbalance where AMOUNT<>CH_BL";
                                                        ps=con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                                <tr>
                                                    <td style="text-align: center"></td>
                                                    <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                                    <td style="text-align: center"><%= rs.getFloat("AMOUNT")%></td>
                                                    <td style="text-align: center"><%= rs.getFloat("CH_BL")%></td>
                                                    <th style="text-align: center"><%= rs.getFloat("CH_BL")-rs.getFloat("AMOUNT")%></th>
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
                                            <tfoot>
                                                <tr>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center"></th>
                                                    <th style="text-align: center">TOTAL</th>
                                                    <td style="text-align: center"></td>
                                                </tr>
                                            </tfoot>
                                            

                                        </table>
                                        
                                    </center>
                                </div>
                            </div>
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
        
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('table tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
        </script>
        <script>
        $(document).ready(function() {
            $('table thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        }
    </script>
    <% } %>
    </body>
</html>
