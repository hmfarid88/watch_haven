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
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class RetailerpayServlet extends HttpServlet {

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
        String rtname=request.getParameter("rtname");
        Float amount=Float.parseFloat(request.getParameter("amount"));
       
        
        Connection con = null;
        PreparedStatement ps = null;
        try{
            con = Ssymphonyy.getConnection();
            String query="insert into customer_pay (RETAILER, AMOUNT, DATE) values (?,?,CURDATE())";
            ps=con.prepareStatement(query);
            ps.setString(1, rtname);
            ps.setFloat(2, amount);
            ps.executeUpdate();
            String debit="insert into debitbalance(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
            ps = con.prepareStatement(debit);
             ps.setString(1, rtname);
             ps.setFloat(2, amount);
             ps.executeUpdate();
            response.sendRedirect("cash_book.jsp");
            }catch (Exception ex) {
              ex.printStackTrace();
            }finally {
  
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
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
