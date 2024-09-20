
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
    <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
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
                            <li><a href="home.jsp"><span class="fa fa-home"> Home</span></a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>

            <div id="div_print" style="font-family: fontawesome">
                <center>
                    <h3>Bank Ledger</h3>
                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                </center>

                <table  border="2" width="100%" class="table-condensed table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Bank Name</th>
                            <th style="text-align: center">Deposit</th>
                            <th style="text-align: center">Withdraw</th>
                            <th style="text-align: center">Balance</th>
                            <th style="text-align: center">Details</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                               Connection con = null;
                               PreparedStatement ps = null;
                               ResultSet rs = null;
                               ResultSet rs1 = null;
                               ResultSet rs2 = null;
               
        try {
            con = Ssymphonyy.getConnection();
            String tname="select BANK_NAME from bank_name";
            ps = con.prepareStatement(tname);
            rs = ps.executeQuery();
            while (rs.next()) {
            String bank=rs.getString(1);
            String query = "select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK=? ";
            ps = con.prepareStatement(query);
            ps.setString(1, bank);
            rs1 = ps.executeQuery();
            while (rs1.next()) {
            String withdraw = "select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK=? ";
            ps = con.prepareStatement(withdraw);
            ps.setString(1, bank);
            rs2 = ps.executeQuery();
            while (rs2.next()) {
            
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString(1) %></td>
                            <td style="text-align: center"><%= rs1.getLong(1) %></td>
                            <td style="text-align: center"><%= rs2.getLong(1)%></td>
                            <td style="text-align: center"><%= rs1.getLong(1)-rs2.getLong(1)%></td>
                            <td style="text-align: center">
                                <form method="POST" action="details_bank_book.jsp">
                                    <input type="hidden" name="bank" value="<%= rs.getString(1)%>" >
                                    <input type="submit" value="Details">
                                </form>
                            </td>
                        </tr>
                        <% 
                     } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                    </tbody>
                </table>

            </div>
        </div>
        <br><br>
        <%@include file = "footerpage.jsp" %>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
    
        <script language="javascript">
            var addSerialNumber = function () {
                var i = 0;
                $('table tr').each(function (index) {
                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                });
            };

            addSerialNumber();
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
        <% } %>
    </body>
</html>
