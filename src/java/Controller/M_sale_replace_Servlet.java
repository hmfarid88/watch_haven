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
public class M_sale_replace_Servlet extends HttpServlet {

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
        String soldime = request.getParameter("soldime");
            String newime = request.getParameter("newime");
            Float discount=Float.parseFloat(request.getParameter("dis"));
            String disnote = request.getParameter("disnote");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs0=null;
            ResultSet rs00=null;
            ResultSet rs000=null;
            ResultSet rs=null;
            ResultSet rs1=null;
            ResultSet rs2=null;
            ResultSet rs3=null;
            ResultSet rs4=null;
            ResultSet rs5=null;
            
            try {
                con = Ssymphonyy.getConnection();
                String query = "select count(*) as imeei from stock where  IMEI=?";
                ps = con.prepareStatement(query);
                ps.setString(1, newime);
                rs0 = ps.executeQuery();
                rs0.next();
                int a = rs0.getInt("imeei");
                String queryy = "select count(*) as imeii from mobilesell where  PRODUCT_ID=?";
                ps = con.prepareStatement(queryy);
                ps.setString(1, soldime);
                rs00 = ps.executeQuery();
                rs00.next();
                int b = rs00.getInt("imeii");
                if (a>0 && b>0) {
                    String soldimei = "select count(*) as imeei from stock where  IMEI=?";
                ps = con.prepareStatement(soldimei);
                ps.setString(1, soldime);
                rs000 = ps.executeQuery();
                rs000.next();
                int s = rs000.getInt("imeei");
                if(s>0){
                   out.println("<h4>Sorry ! This Product Is Already In Stock</h4>"); 
                }else{
                    String query0 = "insert into stock (BRAND, MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, DATE) select  BRAND, MODEL,"
                        + " COLOR, PRODUCT_ID, COST_PRICE, STOCK_RATE, VENDOR, STOCK_DATE from mobilesell where PRODUCT_ID=?";
                ps = con.prepareStatement(query0);
                ps.setString(1, soldime);
                int p = ps.executeUpdate();  
                if(p>0){
                    String query01="select  BRAND, MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, DATE from stock where IMEI=?";
                    ps = con.prepareStatement(query01);
                    ps.setString(1, newime);
                    rs = ps.executeQuery();
                    rs.next();
                    String brand = rs.getString("BRAND");    
                    String model = rs.getString("MODEL");
                        String color = rs.getString("COLOR");
                        String imei = rs.getString("IMEI");
                        Float costprice = rs.getFloat("PURCHASE_PRICE");
                        Float stockrate = rs.getFloat("SELL_PRICE");
                        Float price = rs.getFloat("SELL_PRICE");
                        String vendor = rs.getString("VENDOR");
                        String date = rs.getString("DATE");
                    String query1 = "update  mobilesell set PRODUCT_ID=?, BRAND=?, MODEL=?, COLOR=?, COST_PRICE=?, STOCK_RATE=?, PRICE=?, DISCOUNT=?, DIS_NOTE=?, VENDOR=?, STOCK_DATE=?  where PRODUCT_ID=?";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, imei);
                    ps.setString(2, brand);
                    ps.setString(3, model);
                    ps.setString(4, color);
                    ps.setFloat(5, costprice);
                    ps.setFloat(6, stockrate);
                    ps.setFloat(7, price);
                    ps.setFloat(8, discount);
                    ps.setString(9, disnote);
                    ps.setString(10, vendor);
                    ps.setString(11, date);
                    ps.setString(12, soldime);
                    ps.executeUpdate();
                    
                    String query11="select CUSTOMER_ID from mobilesell where PRODUCT_ID=?";
                    ps = con.prepareStatement(query11);
                    ps.setString(1, newime);
                    rs1=ps.executeQuery();
                    rs1.next();
                    int cid=rs1.getInt(1);
                    
                    String query111="select sum(PRICE), sum(DISCOUNT) from mobilesell where CUSTOMER_ID=?";
                    ps = con.prepareStatement(query111);
                    ps.setInt(1, cid);
                    rs2=ps.executeQuery();
                    rs2.next();
                    Float tprice=rs2.getFloat(1);
                    Float tdis=rs2.getFloat(2);
                    
                    String queryac="select sum(SELL_PRICE), sum(DISCOUNT) from accessor_sale where CUSTOMER_ID=?";
                    ps = con.prepareStatement(queryac);
                    ps.setInt(1, cid);
                    rs3=ps.executeQuery();
                    rs3.next();
                    Float acprice=rs3.getFloat(1);
                    Float acdis=rs3.getFloat(2);
                    Float total=tprice+acprice;
                    Float dis=tdis+acdis;
                    
                    Float nprice=(tprice+acprice)-(tdis+acdis);
                    String queryvat="select VAT_RATE from vat";
                    ps = con.prepareStatement(queryvat);
                    rs4=ps.executeQuery();
                    rs4.next();
                    Float vatr=rs4.getFloat(1);
                    Float vat=(nprice*vatr)/100;
                    Float gprice=nprice+vat;
                    
                    String querycard="select CARD_RECV from paymentinfo where CUSTOMER_ID=?";
                    ps = con.prepareStatement(querycard);
                    ps.setInt(1, cid);
                    rs5=ps.executeQuery();
                    rs5.next();
                    Float cardamount=rs5.getFloat(1);
                    Float cash=gprice-cardamount;
                    
                    String paymentupdate="update paymentinfo set TOTAL=?, VAT=?, GRAND_TOTAL=?, DISCOUNT=?, CASH_RECV=? where CUSTOMER_ID=?";
                    ps = con.prepareStatement(paymentupdate);
                    ps.setFloat(1, total);
                    ps.setFloat(2, vat);
                    ps.setFloat(3, gprice);
                    ps.setFloat(4, dis);
                    ps.setFloat(5, cash);
                    ps.setInt(6, cid);
                   int u= ps.executeUpdate();
                   if(u>0){
                    String query2 = "delete from stock where IMEI=?";
                    ps = con.prepareStatement(query2);
                    ps.setString(1, newime);
                    ps.executeUpdate();
                    response.sendRedirect("admin_portal.jsp");
                }else{
                   out.println("<h4>Sorry ! Replacement not completed</h4>");
                       
                }
                   }else{
                     out.println("<h4>Sorry ! Product is not inserted in stock</h4>");     
                   }
                    
                }    }else{
                  out.println("<h4>Sorry ! Product Is Not Found</h4>");   
                } 
               
                     } catch (SQLException ex) {
                out.println("<h4>Sorry ! Action is not completed, Try Again</h4>"); 
            }finally {
   try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
   try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
   try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (rs000 != null) rs000.close(); rs000=null; } catch (SQLException ex2) { }
   try { if (rs00 != null) rs00.close(); rs00=null; } catch (SQLException ex2) { }
   try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
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
