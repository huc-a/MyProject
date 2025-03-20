package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Tproduct {
    private int productid;
    private String productname;
    private String brand;
    private String memory;
    private String price;
    private String colortype;
    private String productlmage;


    public Tproduct() {
    }

    public Tproduct(int productid, String productname, String brand, String memory, String price, String colortype, String productlmage) {
        this.productid = productid;
        this.productname = productname;
        this.brand = brand;
        this.memory = memory;
        this.price = price;
        this.colortype = colortype;
        this.productlmage = productlmage;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
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

    @Override
    public String toString() {
        return "Tproduct{" +
                "productid=" + productid +
                ", productname='" + productname + '\'' +
                ", brand='" + brand + '\'' +
                ", memory='" + memory + '\'' +
                ", price='" + price + '\'' +
                ", colortype='" + colortype + '\'' +
                ", productlmage='" + productlmage + '\'' +
                '}';
    }

    public Tproduct (ResultSet rs) {
        try {
            if (rs != null && rs.next()) {
                this.productid= rs.getInt("productid");
                this.productname = rs.getString("productname");
                this.brand= rs.getString("brand");
                this.memory= rs.getString("memory");
                this.price= rs.getString("price");
                this.colortype= rs.getString("colortype");
                this.productlmage= rs.getString("productlmage");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

        public static List<Tproduct > tranlist(ResultSet rs){
            List<Tproduct > list = new ArrayList<Tproduct >();
            try {
                while (rs!=null && rs.next()){
                    Tproduct  user = new Tproduct();
                    user.productid= rs.getInt("productid");
                    user.productname = rs.getString("productname");
                    user.brand= rs.getString("brand");
                    user.memory= rs.getString("memory");
                    user.price= rs.getString("price");
                    user.colortype= rs.getString("colortype");
                    user.productlmage= rs.getString("productlmage");
                   list.add(user);
                }
            }catch (Exception e){
                e.printStackTrace();
            }
            return list;
        }

    public void setUserid(Object userid) {
    }
}
