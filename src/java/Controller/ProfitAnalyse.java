/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DB.Ssymphonyy;
import Model.CashModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProfitAnalyse {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs=null;
//    Cash Book Item Start

    public CashModel Salecount() {

        CashModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select sum(GRAND_TOTAL) as price from paymentinfo where DATE=CURDATE() ";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                cm = new CashModel();
                cm.setSale(rs.getFloat("price"));
            }

        } catch (SQLException ex) {
//            ex.printStackTrace();

        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        return cm;
    }

    public CashModel cost() {

        CashModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select sum(AMOUNT) as camount from cost where DATE=CURDATE() ";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                cm = new CashModel();
                cm.setCost(rs.getFloat("camount"));
            }
        } catch (SQLException ex) {

        }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return cm;

    }

    public CashModel DebitBalance() {

        CashModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select sum(AMOUNT) as damount from debitbalance where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                cm = new CashModel();
                cm.setDebetbalance(rs.getFloat("damount"));
            }
        } catch (SQLException ex) {

        }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return cm;

    }

    public CashModel CreditBalance() {

        CashModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select sum(AMOUNT) as cbamount from creditbalance where DATE=CURDATE() ";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                cm = new CashModel();
                cm.setCreditbalance(rs.getFloat("cbamount"));
            }
        } catch (SQLException ex) {

        }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return cm;

    }

    public CashModel CashPay() {

        CashModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select sum(AMOUNT) as csamount from cashpayment where DATE=CURDATE() ";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                cm = new CashModel();
                cm.setPayamount(rs.getFloat("csamount"));
            }
        } catch (SQLException ex) {

        }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return cm;

    }

    public CashModel OpenBalance() {

        CashModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select AMOUNT from netbalance where  DATE !=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                cm = new CashModel();
                cm.setOpenbalance(rs.getFloat(1));
            }
        } catch (SQLException ex) {

        }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return cm;
    }

    public CashModel CardPay() {

        CashModel cm = null;
        try {
            con = Ssymphonyy.getConnection();
            String query = "select sum(CARD_RECV) as crdamount from paymentinfo where DATE=CURDATE() ";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                cm = new CashModel();
                cm.setCardpay(rs.getFloat("crdamount"));
            }
        } catch (SQLException ex) {

        }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return cm;

    }

    public CashModel NetBalance() {

        Float get = this.OpenBalance().getOpenbalance() + this.Salecount().getSale() + this.DebitBalance().getDebetbalance();
        Float pay = this.cost().getCost() + this.CreditBalance().getCreditbalance() + this.CashPay().getPayamount();
        Float netbalance = get - pay;
        Float gettotal = this.OpenBalance().getOpenbalance() + this.Salecount().getSale() + this.DebitBalance().getDebetbalance();
        Float paytotal = this.cost().getCost() + this.CreditBalance().getCreditbalance() + this.CashPay().getPayamount();
        CashModel cm = new CashModel();
        cm.setNetbalance(netbalance);
        cm.setGettotal(gettotal);
        cm.setPaytotal(paytotal);

        return cm;

    }
}
//Cash Book End

