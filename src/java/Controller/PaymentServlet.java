/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DB.Ssymphonyy;
import Model.CashModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Polash
 */
public class PaymentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        
            String cname = request.getParameter("customername");
            String mnumber = request.getParameter("mobilenumber");
            String address = request.getParameter("address");
            String qnt=request.getParameter("qunt");
            int total = Integer.parseInt(request.getParameter("total"));
            int discount = Integer.parseInt(request.getParameter("totaldis"));
            Float vat=Float.parseFloat(request.getParameter("vat"));
            Float grandtotal = total-discount+vat;
            int gt=Math.round(grandtotal);
            Float cardrecev = Float.parseFloat(request.getParameter("cardamount"));
            Float cashrecev = grandtotal - cardrecev;
            int cash=Math.round(cashrecev);
            String cardac = request.getParameter("bank");
            String cardno = request.getParameter("cardno");
            String customerid = request.getParameter("customerid");
            String invo = "NOV2018";
            String invoice = invo + customerid;
            
                       
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs11=null;
            ResultSet rs12=null;
            ResultSet rs13=null;
            ResultSet rs14=null;
            try {
                con = Ssymphonyy.getConnection();
                 if(qnt.equals("0") || qnt.equals("")){
                   out.println("<center><h3>Please, complete sale information and try again</h3></center>"); 
                }else{
               if(cardrecev>0){
                   String rate="select RATE from bank_name where BANK_NAME=?";
                   ps = con.prepareStatement(rate);
                   ps.setString(1, cardac);
                   rs14=ps.executeQuery();
                   rs14.next();
                   Float bankrate=rs14.getFloat("RATE");
                   Float poscost=(cardrecev*bankrate)/100;    
                   String query = "insert into paymentinfo (TOTAL, VAT, GRAND_TOTAL, DISCOUNT, CARD_RECV, CASH_RECV, CARD_ACC_NO, CARD_NO, QUANTITY, "
                        + "CUSTOMER_ID, INVOICE_NO, DATE ) values (?,?,?,?,?,?,?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setInt(1, total);
                ps.setFloat(2, vat);
                ps.setInt(3, gt);
                ps.setInt(4, discount);
                ps.setFloat(5, cardrecev);
                ps.setInt(6, cash);
                ps.setString(7, cardac);
                ps.setString(8, cardno);
                ps.setString(9, qnt);
                ps.setString(10, customerid);
                ps.setString(11, invoice);
                ps.executeUpdate();
               
                String query1="insert into bank_transition (TYPE, AMOUNT, BANK, BRANCH, PAYER, DATE) values"
                        + "(?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query1);
                ps.setString(1, "Deposit");
                ps.setFloat(2, cardrecev-poscost);
                ps.setString(3, cardac);
                ps.setString(4, "Narayanganj");
                ps.setString(5, cname);
                ps.executeUpdate();
                String maxsi="select MAX(SI_NO) from bank_transition where BANK='"+ cardac +"'";
                        ps = con.prepareStatement(maxsi);
                        rs11 = ps.executeQuery();
                        rs11.next();
                        int maxsino = rs11.getInt(1);
                        String ldeposit = "select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK='" + cardac + "'";
                ps = con.prepareStatement(ldeposit);
                rs12=ps.executeQuery();
                rs12.next();
                Long ltotaldepo=rs12.getLong(1);
                String lwithdrw="select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK='"+ cardac +"'";
                ps = con.prepareStatement(lwithdrw);
                rs13=ps.executeQuery();
                rs13.next();
                Long ltotalwithd=rs13.getLong(1);
                Long lbalance=ltotaldepo-ltotalwithd;
                String blup="update bank_transition set BALANCE=? where SI_NO=?";
                ps = con.prepareStatement(blup);
                ps.setLong(1, lbalance);
                ps.setInt(2, maxsino);
                ps.executeUpdate();
                
                 String cashcredit="insert into creditbalance(CREDIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
                        ps = con.prepareStatement(cashcredit);
                        ps.setString(1, "Card Payment at "+cardac);
                        ps.setFloat(2, cardrecev-poscost);
                        ps.executeUpdate();
                
                String querycost="insert into cost (COST_NAME, NOTE, AMOUNT, DATE) values (?,?,?,CURDATE())";
                ps = con.prepareStatement(querycost);
                ps.setString(1, "POS Cost");
                ps.setString(2, "Charge");
                ps.setFloat(3, poscost);
                ps.executeUpdate();
                
                String customer = "insert into customerinfo (C_NAME, PHONE_NUMBER, ADDRESS, DATE) values (?,?,?,CURDATE())";
                   ps = con.prepareStatement(customer);
                   ps.setString(1, cname);
                   ps.setString(2, mnumber);
                   ps.setString(3, address);
                   ps.executeUpdate();
                   response.sendRedirect("voucher.jsp");
                   }else{
                  String query = "insert into paymentinfo (TOTAL, VAT, GRAND_TOTAL, DISCOUNT, CARD_RECV, CASH_RECV, CARD_ACC_NO, CARD_NO, QUANTITY, "
                        + "CUSTOMER_ID, INVOICE_NO, DATE ) values (?,?,?,?,?,?,?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setInt(1, total);
                ps.setFloat(2, vat);
                ps.setInt(3, gt);
                ps.setInt(4, discount);
                ps.setFloat(5, cardrecev);
                ps.setInt(6, cash);
                ps.setString(7, cardac);
                ps.setString(8, cardno);
                ps.setString(9, qnt);
                ps.setString(10, customerid);
                ps.setString(11, invoice);
                ps.executeUpdate(); 
                String customer = "insert into customerinfo (C_NAME, PHONE_NUMBER, ADDRESS, DATE) values (?,?,?,CURDATE())";
                   ps = con.prepareStatement(customer);
                   ps.setString(1, cname);
                   ps.setString(2, mnumber);
                   ps.setString(3, address);
                   ps.executeUpdate();
                   response.sendRedirect("voucher.jsp");
               }
                 } } catch (SQLException ex) {
                     
                  out.println("<h3>Sorry! Sale Process is not completed try again</h3>");
            }finally {
      try { if (rs14 != null) rs14.close(); rs14=null; } catch (SQLException ex2) { }
      try { if (rs13 != null) rs13.close(); rs13=null; } catch (SQLException ex2) { }
      try { if (rs12 != null) rs12.close(); rs12=null; } catch (SQLException ex2) { }
      try { if (rs11 != null) rs11.close(); rs11=null; } catch (SQLException ex2) { }
      try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
      try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
      try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        Connection con = null;
        PreparedStatement ps = null;
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
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
