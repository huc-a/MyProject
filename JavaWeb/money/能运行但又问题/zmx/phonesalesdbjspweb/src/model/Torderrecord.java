package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Torderrecord {
    private int saleid ;
    private int productid;
    private int salequantity;
    private String saleamount;
    private String saletime;
    private String useraccount;
    private String recordstatus;

    public Torderrecord() {
    }

    public Torderrecord(int saleid, int productid, int salequantity,
                        String saleamount, String saletime, String useraccount,
                        String recordstatus) {
        this.saleid = saleid;
        this.productid = productid;
        this.salequantity = salequantity;
        this.saleamount = saleamount;
        this.saletime = saletime;
        this.useraccount = useraccount;
        this.recordstatus = recordstatus;
    }

    public int getSaleid() {
        return saleid;
    }

    public void setSaleid(int saleid) {
        this.saleid = saleid;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public int getSalequantity() {
        return salequantity;
    }

    public void setSalequantity(int salequantity) {
        this.salequantity = salequantity;
    }

    public String getSaleamount() {
        return saleamount;
    }

    public void setSaleamount(String saleamount) {
        this.saleamount = saleamount;
    }

    public String getSaletime() {
        return saletime;
    }

    public void setSaletime(String saletime) {
        this.saletime = saletime;
    }

    public String getUseraccount() {
        return useraccount;
    }

    public void setUseraccount(String useraccount) {
        this.useraccount = useraccount;
    }

    public String getRecordstatus() {
        return recordstatus;
    }

    public void setRecordstatus(String recordstatus) {
        this.recordstatus = recordstatus;
    }

    @Override
    public String toString() {
        return "Torderrecord{" +
                "saleid=" + saleid +
                ", productid=" + productid +
                ", salequantity=" + salequantity +
                ", saleamount='" + saleamount + '\'' +
                ", saletime='" + saletime + '\'' +
                ", useraccount='" + useraccount + '\'' +
                ", recordstatus='" + recordstatus + '\'' +
                '}';
    }

    public Torderrecord(ResultSet rs) {

        try {
            if (rs!= null && rs.next()) {
                this.saleid = rs.getInt("saledid");
                this.productid = rs.getInt("productid");
                this.salequantity= rs.getInt("salequantity");
                this.saleamount = rs.getString("saleamount");
                this.saletime = rs.getString("saletime");
                this.useraccount= rs.getString("useraccount");
                this.recordstatus= rs.getString("recordstatus");

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

        public static List<Torderrecord> tranlist(ResultSet rs){
            List<Torderrecord> list = new ArrayList<Torderrecord>();
            try {
                while (rs!=null && rs.next()){
                    Torderrecord user = new Torderrecord();
                    user.saleid = rs.getInt("saledid");
                    user.productid = rs.getInt("productid");
                    user.salequantity= rs.getInt("salequantity");
                    user.saleamount = rs.getString("saleamount");
                    user.saletime = rs.getString("saletime");
                    user.useraccount= rs.getString("useraccount");
                    user.recordstatus= rs.getString("recordstatus");
                    list.add(user);

                }
            }catch (Exception e){
                e.printStackTrace();
            }
            return list;
        }
    }

