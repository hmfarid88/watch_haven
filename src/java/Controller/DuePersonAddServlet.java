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
public class DuePersonAddServlet extends HttpServlet {

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
        
        String propname = request.getParameter("rtname");
        String address = request.getParameter("address");
        String mnumber = request.getParameter("mnumber");
        
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Ssymphonyy.getConnection();
                String query = "select count(*) as dup from due_person where  P_NAME=?";
                ps = con.prepareStatement(query);
                ps.setString(1, propname);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt("dup");
                if (a > 0) {
                   out.println("<h3>This person is already entryed!</h3>");
                } else {
                    String query1 = "insert into due_person (P_NAME, ADDRESS, M_NUMBER, DATE) values (?,?,?, CURDATE())";
                            
                    ps = con.prepareStatement(query1);
                    ps.setString(1, propname);
                    ps.setString(2, address);
                    ps.setString(3, mnumber);
                    
                    int b = ps.executeUpdate();
                    if (b > 0) {
                        response.sendRedirect("home.jsp");
                    }else{
                        out.println("Due person is not Entryed");
                    }
                           }
                } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
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
