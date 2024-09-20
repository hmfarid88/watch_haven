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
 * @author Polash
 */
public class AccessorSelectServlet extends HttpServlet {

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

        String product = request.getParameter("product");
        Connection con = null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select PRODUCT_NAME, PURCHES_PRICE, SALE_PRICE from accessor_price where  PRODUCT_NAME =? ";
            ps = con.prepareStatement(query);
            ps.setString(1, product);
            rs = ps.executeQuery();
            while (rs.next()) {
                String prodct = rs.getString("PRODUCT_NAME");
                Float purchprice = rs.getFloat("PURCHES_PRICE");
                Float saleprice = rs.getFloat("SALE_PRICE");

                request.getSession().setAttribute("PRODCT", prodct);
                request.getSession().setAttribute("ACPURCH", purchprice);
                request.getSession().setAttribute("ACSALE", saleprice);

                response.sendRedirect("symaccesor_entry.jsp");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
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
