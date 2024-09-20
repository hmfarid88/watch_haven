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

        <div class="row">

            <div class="col-sm-4"></div>
            <div class="col-sm-4">

                <div id="div_print"><br><br>
                    <center>
                        <div class="panel" style="width: 370px;  border-color: black" >
                            <table>
                                <tr>
                                 
                                    <td>

                                <center>
                                        <%
                                            String invono=request.getParameter("invono");
                                            Connection con = null;
                                            PreparedStatement ps = null;
                                            ResultSet rs=null;
                                                                                                                                
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select distinct COMPANY_NAME, ADDRESS, PHONE_NUMBER, EMAIL from companyinfo ";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <p style=" font-size: 18px;margin-top: 5px"><%= rs.getString("COMPANY_NAME")%></p>
                                        <p style="font-size: 11px"><%= rs.getString("ADDRESS")%><br>
                                            <span class="glyphicon glyphicon-phone-alt"></span> <%= rs.getString("PHONE_NUMBER")%><br>
                                            E-mail :<%= rs.getString("EMAIL")%> 

                                        </p>
                                        <%
                                                }
                                            } catch (Exception ex) {
                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                </center>
                                    </td>
                                </tr>
                            </table>
                            <p style=" font-size: 15px"><u><strong>Invoice/Bill (Vendor Sale)</strong></u></p>
                            <table style=" margin-left: 5px"  width="100%" class="table-responsive">

                                <tr style=" border-bottom-style: hidden">
                                    <td style="border-right-style: hidden; font-size: 12px" width="50%"><label>Date: </label> 
                                        <%
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select CUSTOMER_ID, DATE from customerinfo where CUSTOMER_ID=(select CUSTOMER_ID from vendor_sale where INVOICE_NO='"+ invono +"' UNION select CUSTOMER_ID from vendor_accessor_sale where INVOICE_NO='"+ invono +"')";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                                    request.setAttribute("cid", rs.getInt("CUSTOMER_ID"));
                                                    request.setAttribute("saledate", rs.getString("DATE"));
                                                }
                                            } catch (Exception ex) {
                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                        ${saledate}
                                    </td>

                                    <td style="font-size: 12px"><label>Invoice No:</label>

                                        NOV2018${cid}

                                    </td>
                                </tr>
                                <tr style=" border-bottom-style: hidden">
                                    <td style="border-right-style: hidden;font-size: 12px">
                                        <label>Name:</label>
                                        <%
                                            try {
                                                con = Ssymphonyy.getConnection();
                                                String query = "select C_NAME, PHONE_NUMBER, ADDRESS from customerinfo where CUSTOMER_ID=(select CUSTOMER_ID from vendor_sale where INVOICE_NO='"+ invono +"' UNION select CUSTOMER_ID from vendor_accessor_sale where INVOICE_NO='"+ invono +"')";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                                    request.setAttribute("address", rs.getString("ADDRESS"));
                                        %>
                                        <strong class="text-uppercase"> <%= rs.getString("C_NAME")%></strong>

                                    </td>
                                    <td style="font-size: 12px"><label>Phone:</label>
                                        <%= rs.getString("PHONE_NUMBER")%>
                                    </td>
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
                            <table style=" margin-left: 5px"  width="100%" class="table-responsive">
                                <tr style="font-size: 11px"> <td> <p class="text-uppercase"><strong>ADDRESS: </strong> ${address} </p></td></tr>

                            </table>
                            <table border="1" style="min-height: 290px" width="100%" class="myTables" >
                                <thead>
                                    <tr style="font-size: 12px" height="20%">
                                        <th style=" border-left-style: hidden"><center>SN</center></th>
                                <th><center>Description</center></th>
                                <th><center>Qnt</center></th>
                                <th><center>Unit</center></th>
                                <th style=" border-right-style: hidden"><center>Total</center></th>
                                </tr>
                                </thead>
                                <tbody>

                                    <%
                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select  PRODUCT_ID, BRAND, MODEL, COLOR, COST_PRICE from vendor_sale where  CUSTOMER_ID=(select CUSTOMER_ID from vendor_sale where INVOICE_NO='"+ invono +"' UNION select CUSTOMER_ID from vendor_accessor_sale where INVOICE_NO='"+ invono +"')";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                    %>

                                    <tr style="border-bottom-color: white; font-size: 12px">
                                        <td style="text-align: center; border-left-style: hidden">  </td>

                                        <td style="text-align: center"> <%= rs.getString("BRAND")%>, <%= rs.getString("MODEL")%>, <%= rs.getString("COLOR")%>, <%= rs.getString("PRODUCT_ID")%>
                                        </td>
                                        <td><center>1</center></td>
                                <td><center><%= rs.getFloat("COST_PRICE")%></center></td> 
                            <td style=" border-right-style: hidden"><center><%= rs.getFloat("COST_PRICE")%></center></td> 


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
                                        String query = "select  PRODUCT_NAME, PRODUCT_ID, MODEL, COST_PRICE from vendor_accessor_sale where  CUSTOMER_ID=(select CUSTOMER_ID from vendor_sale where INVOICE_NO='"+ invono +"' UNION select CUSTOMER_ID from vendor_accessor_sale where INVOICE_NO='"+ invono +"') ";
                                        ps = con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                %>
                                <tr style="border-bottom-color: white; font-size: 12px">
                                    <td style="text-align: center; border-left-style: hidden">  </td>
                                    <td><center><%= rs.getString("PRODUCT_NAME")%>  <%= rs.getString("MODEL")%>,<%= rs.getString("PRODUCT_ID")%> </center></td>
                                <td><center>1</center></td>
                                <td><center> <%= rs.getFloat("COST_PRICE")%></center></td>
                            <td style=" border-right-style: hidden"><center> <%= rs.getFloat("COST_PRICE")%></center></td>

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
                                <tr style=" font-size: 12px">
                                    <%
                                        try {
                                            con = Ssymphonyy.getConnection();
                                            String query = "select count(PRODUCT_ID) as pqnty, sum(COST_PRICE)as ptotal "
                                                    + " from vendor_sale where  CUSTOMER_ID=(select CUSTOMER_ID from vendor_sale where INVOICE_NO='"+ invono +"' UNION select CUSTOMER_ID from vendor_accessor_sale where INVOICE_NO='"+ invono +"')";
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
                                                    + " from vendor_accessor_sale where  CUSTOMER_ID=(select CUSTOMER_ID from vendor_sale where INVOICE_NO='"+ invono +"' UNION select CUSTOMER_ID from vendor_accessor_sale where INVOICE_NO='"+ invono +"') ";
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
}                                    %>  
                                    <th style=" border-left-style: hidden"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <th style="text-align: center">${mqty+aqty} </th>
                                    <th></th>
                                    <th style="text-align: center; border-right-style: hidden">${mtotal+atotal}</th>
                                </tr>

                                </tbody>
                            </table>
                            <table  border="0" width="100%">
                                <tr style=" font-size: 12px; height: 30px">
                                    <td>
                                        Signature: . . . . . . . . . . . 
                                    </td>
                                </tr> 
                            </table> 

                        </div>
                    </center>
                </div>
            </div>
            <div class="col-sm-4"></div>                  
        </div>                
        <%@include file = "footerpage.jsp" %> 
    </div>
    <div class="container">

    </div>

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('.myTables tr').each(function (index) {
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
    <% }%>
</body>
</html>
