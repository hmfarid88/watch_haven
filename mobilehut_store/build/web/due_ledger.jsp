
<%@page import="java.util.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Ssymphonyy"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>

                <div id="div_print">
                    <center>
                        <h3>Due Ledger</h3>
                        <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                    </center>

                    <table  border="2" width="100%" class=" table table-striped table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Due Person</th>
                                <th style="text-align: center">Receive</th>
                                <th style="text-align: center">Payment</th>
                                <th style="text-align: center">Balance</th>
                                <th style="text-align: center">Payable Date</th>
                                <th style="text-align: center">Details</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs0 = null;
                                ResultSet rs = null;
                                ResultSet rs1 = null;
                                
                                try {
            con = Ssymphonyy.getConnection();
            String query0="select distinct P_NAME from due_person";
            ps = con.prepareStatement(query0);
            rs0 = ps.executeQuery();
            while (rs0.next()) {
                String duename=rs0.getString("P_NAME");
            String query = "select sum(PAYMENT), sum(RECEIVE) from due_transaction where DUE_NAME=?";
            ps = con.prepareStatement(query);
            ps.setString(1, duename);
            rs = ps.executeQuery();
            while (rs.next()) {
            String duedate="select PAY_DATE from due_transaction where DUE_NAME='"+ duename +"' order by SI_NO desc limit 1";
            ps = con.prepareStatement(duedate);
            rs1 = ps.executeQuery();
            while (rs1.next()) {
                
                          %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%=rs0.getString("P_NAME") %></td>
                                <th style="text-align: center"><%=rs.getLong(2) %></th>
                                <th style="text-align: center"><%= rs.getLong(1) %></th>
                                <th style="text-align: center"><%= rs.getLong(1)- rs.getLong(2)%></th>
                                <td style="text-align: center" ><%=rs1.getString("PAY_DATE") %></td>
                                <td style="text-align: center">
                                    <form method="POST" action="details_due_ledger.jsp">
                                        <input type="hidden" name="propritor" value="<%= rs0.getString("P_NAME")%>">
                                        <input type="submit" value="Details" class="btn btn-info btn-sm">
                                    </form>
                                        
                                </td>
                            </tr>
                            <% }}}
 }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>
                            
                        </tbody>
                        <tfoot>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center">Total</th>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                             
                            </tr>
                        </tfoot>
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
            <script>
                           $(document).ready(function(){
  var _date = new Date();
  $('td').each(function(){
    var d = $(this).text().split('-');
    if (parseInt(d[0]) === _date.getFullYear() && parseInt(d[1]) === _date.getMonth()+1 && parseInt(d[2]) === _date.getDate()){
      $(this).css('color', 'red');
    }
  });
});
                            </script>
            <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
     $('table thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        } 
  });
});
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
