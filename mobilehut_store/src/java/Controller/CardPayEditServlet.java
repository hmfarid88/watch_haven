/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DB.Ssymphonyy;
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
 * @author Acer
 */
public class CardPayEditServlet extends HttpServlet {

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
        String invono=request.getParameter("invoice");
        String bank=request.getParameter("bank");
        String cardno=request.getParameter("cardno");
        int amount=Integer.parseInt(request.getParameter("amount"));
        Connection con = null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        ResultSet rs1=null;
        ResultSet rs2=null;
        ResultSet rs3=null;
        ResultSet rs4=null;
        try {
            con = Ssymphonyy.getConnection();
            String query="select GRAND_TOTAL from paymentinfo where INVOICE_NO=?";
            ps=con.prepareStatement(query);
            ps.setString(1, invono);
            rs=ps.executeQuery();
            rs.next();
            Float gtotal=rs.getFloat(1);
            Float newcash=gtotal-amount;
            String query1="update paymentinfo set CARD_RECV=?, CASH_RECV=?, CARD_ACC_NO=?, CARD_NO=? where INVOICE_NO=?";
            ps=con.prepareStatement(query1);
            ps.setFloat(1, amount);
            ps.setFloat(2, newcash);
            ps.setString(3, bank);
            ps.setString(4, cardno);
            ps.setString(5, invono);
            int a=ps.executeUpdate();
            if(a>0){
                String rate="select RATE from bank_name where BANK_NAME=?";
                   ps = con.prepareStatement(rate);
                   ps.setString(1, bank);
                   rs4=ps.executeQuery();
                   rs4.next();
                   Float bankrate=rs4.getFloat("RATE");
                   Float poscost=(amount*bankrate)/100;  
                  
                        String querybank="insert into bank_transition (TYPE, AMOUNT, BANK, BRANCH, PAYER, DATE) values"
                        + "(?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(querybank);
                ps.setString(1, "Deposit");
                ps.setFloat(2, amount-poscost);
                ps.setString(3, bank);
                ps.setString(4, "Narayanganj");
                ps.setString(5, invono);
                ps.executeUpdate();
                String maxsi="select MAX(SI_NO) from bank_transition where BANK='"+ bank +"'";
                         ps = con.prepareStatement(maxsi);
                         rs1=ps.executeQuery();
                         rs1.next();
                         int maxsino=rs1.getInt(1);
                         String ldeposit="select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK='"+ bank +"'";
                ps = con.prepareStatement(ldeposit);
                rs2=ps.executeQuery();
                rs2.next();
                Long ltotaldepo=rs2.getLong(1);
                String lwithdrw="select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK='"+ bank +"'";
                ps = con.prepareStatement(lwithdrw);
                rs3=ps.executeQuery();
                rs3.next();
                Long ltotalwithd=rs3.getLong(1);
                Long lbalance=ltotaldepo-ltotalwithd;
                String blup="update bank_transition set BALANCE=? where SI_NO=?";
                ps = con.prepareStatement(blup);
                ps.setLong(1, lbalance);
                ps.setInt(2, maxsino);
                ps.executeUpdate();
                String cashcredit="insert into creditbalance(CREDIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
                        ps = con.prepareStatement(cashcredit);
                        ps.setString(1, "Card Payment at "+bank);
                        ps.setFloat(2, amount-poscost);
                        ps.executeUpdate();
                String querycost="insert into cost (COST_NAME, NOTE, AMOUNT, DATE) values (?,?,?,CURDATE())";
                ps = con.prepareStatement(querycost);
                ps.setString(1, "POS Cost");
                ps.setString(2, "Charge");
                ps.setFloat(3, poscost);
                ps.executeUpdate();
                response.sendRedirect("cash_book.jsp");
            }else{
                out.println("Update is not completed !");
            }
         } catch (SQLException ex) {

            ex.printStackTrace();
        }finally {
   try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
   try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
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
