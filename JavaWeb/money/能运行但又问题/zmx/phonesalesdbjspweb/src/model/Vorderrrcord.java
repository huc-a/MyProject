package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Vorderrrcord {
    private int saleid;
    private int productid;
    private int salequantity;
    private String saleamount;
    private String saletime;
    private String useraccount;
    private String recordstatus;
    private String productname;
    private String brand;
    private String memory;
    private String price;
    private String colortype;
    private String productlmage;
    private String pwd;
    private String username;
    private String utid;
    private String idnumber;
    private String mobile;

    public Vorderrrcord() {

    }

    public Vorderrrcord(int saleid, int productid, int salequantity, String saleamount, String saletime, String useraccount, String recordstatus, String productname, String brand, String memory, String price, String colortype, String productlmage, String pwd, String username, String utid, String idnumber, String mobile) {
        this.saleid = saleid;
        this.productid = productid;
        this.salequantity = salequantity;
        this.saleamount = saleamount;
        this.saletime = saletime;
        this.useraccount = useraccount;
        this.recordstatus = recordstatus;
        this.productname = productname;
        this.brand = brand;
        this.memory = memory;
        this.price = price;
        this.colortype = colortype;
        this.productlmage = productlmage;
        this.pwd = pwd;
        this.username = username;
        this.utid = utid;
        this.idnumber = idnumber;
        this.mobile = mobile;
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

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getMemory() {
        return memory;
    }

    public void setMemory(String memory) {
        this.memory = memory;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getColortype() {
        return colortype;
    }

    public void setColortype(String colortype) {
        this.colortype = colortype;
    }

    public String getProductlmage() {
        return productlmage;
    }

    public void setProductlmage(String productlmage) {
        this.productlmage = productlmage;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUtid() {
        return utid;
    }

    public void setUtid(String utid) {
        this.utid = utid;
    }

    public String getIdnumber() {
        return idnumber;
    }

    public void setIdnumber(String idnumber) {
        this.idnumber = idnumber;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    @Override
    public String toString() {
        return "Vorderrrcord{" +
                "saleid=" + saleid +
                ", productid=" + productid +
                ", salequantity=" + salequantity +
                ", saleamount='" + saleamount + '\'' +
                ", saletime='" + saletime + '\'' +
                ", useraccount='" + useraccount + '\'' +
                ", recordstatus='" + recordstatus + '\'' +
                ", productname='" + productname + '\'' +
                ", brand='" + brand + '\'' +
                ", memory='" + memory + '\'' +
                ", price='" + price + '\'' +
                ", colortype='" + colortype + '\'' +
                ", productlmage='" + productlmage + '\'' +
                ", pwd='" + pwd + '\'' +
                ", username='" + username + '\'' +
                ", utid='" + utid + '\'' +
                ", idnumber='" + idnumber + '\'' +
                ", mobile='" + mobile + '\'' +
                '}';
    }
    public Vorderrrcord(ResultSet rs){
        try{
            if (rs!=null && rs.next()){
                this.setSaleid(rs.getInt(saleid));
                this.setProductid(rs.getInt(productid));
                this.setSalequantity(rs.getInt(salequantity));
                this.setSaleamount(rs.getString(saleamount));
                this.setSaletime(rs.getString(saletime));
                this.setUseraccount(rs.getString(useraccount));
                this.setRecordstatus(rs.getString(recordstatus));
                this.setProductname(rs.getString(productname));
                this.setBrand(rs.getString(brand));
                this.setMemory(rs.getString(memory));
                this.setPrice(rs.getString(price));
                this.setColortype(rs.getString(colortype));
                this.setProductlmage(rs.getString(productlmage));
                this.setPwd(rs.getString(pwd));
                this.setUsername(rs.getString(username));
                this.setUtid(rs.getString(utid));
                this.setIdnumber(rs.getString(idnumber));
                this.setMobile(rs.getString(mobile));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static List<Vorderrrcord> tranList(ResultSet rs) {
        List<Vorderrrcord> list = new ArrayList<Vorderrrcord>();
        try {
            while (rs != null && rs.next()) {
                Vorderrrcord user = new Vorderrrcord();//创建一个空的VUers对象
                user.setSaleid(rs.getInt("saleid"));
                user.setProductid(rs.getInt("productid"));
                user.setSalequantity(rs.getInt("salequantity"));
                user.setSaleamount(rs.getString("saleamount"));
                user.setSaletime(rs.getString("saletime"));
                user.setUseraccount(rs.getString("useraccount"));
                user.setRecordstatus(rs.getString("recordstatus"));
                user.setProductname(rs.getString("productname"));
                user.setBrand(rs.getString("brand"));
                user.setMemory(rs.getString("memory"));
                user.setPrice(rs.getString("price"));
                user.setColortype(rs.getString("colortype"));
                user.setProductlmage(rs.getString("productlmage"));
                user.setPwd(rs.getString("pwd"));
                user.setUsername(rs.getString("username"));
                user.setUtid(rs.getString("utid"));
                user.setIdnumber(rs.getString("idnumber"));
                user.setMobile(rs.getString("mobile"));
                list.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
