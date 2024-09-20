/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Date;

public class PaymentModel {

    private int qnt;
    private Float total;
    private Float vat;
    private Float grandtotal;
    private Float discount;
    private Float cardrecv;
    private Float cashrecv;
    private String cardaccno;
    private String cardno;
    private String invoice;
    private String cid;
    private Date date;

    public int getQnt() {
        return qnt;
    }

    public void setQnt(int qnt) {
        this.qnt = qnt;
    }

    public Float getTotal() {
        return total;
    }

    public void setTotal(Float total) {
        this.total = total;
    }

    public Float getVat() {
        return vat;
    }

    public void setVat(Float vat) {
        this.vat = vat;
    }

    public Float getGrandtotal() {
        return grandtotal;
    }

    public void setGrandtotal(Float grandtotal) {
        this.grandtotal = grandtotal;
    }

    public Float getDiscount() {
        return discount;
    }

    public void setDiscount(Float discount) {
        this.discount = discount;
    }

    public Float getCardrecv() {
        return cardrecv;
    }

    public void setCardrecv(Float cardrecv) {
        this.cardrecv = cardrecv;
    }

    public Float getCashrecv() {
        return cashrecv;
    }

    public void setCashrecv(Float cashrecv) {
        this.cashrecv = cashrecv;
    }

    public String getCardaccno() {
        return cardaccno;
    }

    public void setCardaccno(String cardaccno) {
        this.cardaccno = cardaccno;
    }

    public String getCardno() {
        return cardno;
    }

    public void setCardno(String cardno) {
        this.cardno = cardno;
    }

    public String getInvoice() {
        return invoice;
    }

    public void setInvoice(String invoice) {
        this.invoice = invoice;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

}
