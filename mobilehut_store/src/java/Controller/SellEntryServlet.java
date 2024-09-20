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
public class SellEntryServlet extends HttpServlet {

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
        
            String cid=request.getParameter("cid");
            String invo = "NOV2018";
            String invoice = invo + cid;
            String ime = request.getParameter("imei");

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs1=null;
            try {
                con = Ssymphonyy.getConnection();
                String query1 = "select count(*) from stock where IMEI=? " ;
                ps = con.prepareStatement(query1);
                ps.setString(1, ime);
                rs = ps.executeQuery();
                rs.next();
                int p = rs.getInt(1);
                if (p < 1) {
                   out.println("<h3>Sorry! This Product is not in stock");
                } else {
                    String query = "select  BRAND, MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, DATE from stock where IMEI=?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, ime);
                    rs1 = ps.executeQuery();
                    rs1.next();
                        String brand = rs1.getString("BRAND");    
                        String model = rs1.getString("MODEL");
                        String color = rs1.getString("COLOR");
                        String imei = rs1.getString("IMEI");
                        Float costprice = rs1.getFloat("PURCHASE_PRICE");
                        Float stockrate = rs1.getFloat("SELL_PRICE");
                        Float price = rs1.getFloat("SELL_PRICE");
                        String vendor = rs1.getString("VENDOR");
                        String date = rs1.getString("DATE");

                        String query2 = "insert into mobilesell (PRODUCT_ID, CUSTOMER_ID, INVOICE_NO, BRAND,"
                                + "MODEL, COLOR, COST_PRICE, STOCK_RATE, PRICE, VENDOR, STOCK_DATE, SELL_DATE) values (?,?,?,?,?,?,?,?,?,?,?, CURDATE())";
                        ps = con.prepareStatement(query2);
                        ps.setString(1, imei);
                        ps.setString(2, cid);
                        ps.setString(3, invoice);
                        ps.setString(4, brand);
                        ps.setString(5, model);
                        ps.setString(6, color);
                        ps.setFloat(7, costprice);
                        ps.setFloat(8, stockrate);
                        ps.setFloat(9, price);
                        ps.setString(10, vendor);
                        ps.setString(11, date);
                        ps.executeUpdate();
                        String query3 = "delete from stock where IMEI=?";
                        ps = con.prepareStatement(query3);
                        ps.setString(1, imei);
                        int b = ps.executeUpdate();
                        if (b > 0) {
                            response.sendRedirect("symmobilesell.jsp");
                        } else {
                            out.println("<h3>Sale is not completed, Try again!</h3>");
                        }
                    }
          
            } catch (SQLException ex) {
              
            }finally {
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
