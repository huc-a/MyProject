package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Tdelivery {
    private int  deliveryid;
    private String useraccount;
    private String country;
    private String province;
    private String city;
    private String detailaddr;
    private String contactphone1;
    private String contactphone2;


    public Tdelivery() {
    }

    public Tdelivery(int deliveryid, String useraccount, String country, String province, String city, String detailaddr, String contactphone1, String contactphone2) {
        this.deliveryid = deliveryid;
        this.useraccount = useraccount;
        this.country = country;
        this.province = province;
        this.city = city;
        this.detailaddr = detailaddr;
        this.contactphone1 = contactphone1;
        this.contactphone2 = contactphone2;
    }

    public int getDeliveryid() {
        return deliveryid;
    }

    public void setDeliveryid(int deliveryid) {
        this.deliveryid = deliveryid;
    }

    public String getUseraccount(String s) {
        return useraccount;
    }

    public void setUseraccount(String useraccount) {
        this.useraccount = useraccount;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDetailaddr() {
        return detailaddr;
    }

    public void setDetailaddr(String detailaddr) {
        this.detailaddr = detailaddr;
    }

    public String getContactphone1() {
        return contactphone1;
    }

    public void setContactphone1(String contactphone1) {
        this.contactphone1 = contactphone1;
    }

    public String getContactphone2(String s) {
        return contactphone2;
    }

    public void setContactphone2(String contactphone2) {
        this.contactphone2 = contactphone2;
    }

    @Override
    public String toString() {
        return "Tdelivery{" +
                "deliveryid=" + deliveryid +
                ", useraccount='" + useraccount + '\'' +
                ", country='" + country + '\'' +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", detailaddr='" + detailaddr + '\'' +
                ", contactphone1='" + contactphone1 + '\'' +
                ", contactphone2='" + contactphone2 + '\'' +
                '}';
    }

    public Tdelivery(ResultSet rs) {
        try {
            if (rs!= null && rs.next()) {
                this.deliveryid= rs.getInt("deliveryid");
                this.useraccount= rs.getString("useraccount");
                this.country= rs.getString("country");
                this.province= rs.getString("province");
                this.city= rs.getString("city");
                this.detailaddr= rs.getString("detailaddr");
                this.contactphone1= rs.getString("contactphones1");
                this.contactphone2 = rs.getString("contatcphone2");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

        public static List<Tdelivery> tranList(ResultSet rs){
            List<Tdelivery> list = new ArrayList<Tdelivery>();
            try {
                while (rs!=null && rs.next()){
                    Tdelivery user = new Tdelivery();
                    user.setDeliveryid(rs.getInt("deliveryid"));
                    user.setUseraccount(rs.getString("useraccount"));
                    user.setCountry (rs.getString("country"));
                    user.setProvince (rs.getString("province"));
                    user.setCity (rs.getString("city"));
                    user.setDetailaddr (rs.getString("detailaddr"));
                    user.setContactphone1 ( rs.getString("contactphones1"));
                    user.setContactphone2 (rs.getString("contatcphone2"));
                    list.add(user);
                }
            }catch (Exception e){
                e.printStackTrace();
            }
            return list;
        }
    }
