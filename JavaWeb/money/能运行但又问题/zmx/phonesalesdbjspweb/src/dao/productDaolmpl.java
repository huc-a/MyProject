package dao;

import model.Tproduct;
import utils.DataUtil;
import utils.IDataUtil;

import java.sql.ResultSet;
import java.util.List;

public class productDaolmpl implements productDAO{
    private IDataUtil dataUtil = null;

    public productDaolmpl(){ dataUtil = new DataUtil(); }

    @Override
    public int addproduct(Tproduct record) {
            String sql = "insert into t_product(productid,productname,brand," +
                    "memory,price,colortype,productlmage) values(?,?,?,?,?,?,?)";
            Object[] para = {record.getProductid(),record.getProductname(),record.getBrand(),
            record.getMemory(),record.getPrice(),record.getColortype(),record.getProductlmage()};
            int key = dataUtil.insert(sql,para);
            return key;
    }

    @Override
    public boolean updateproduct(Tproduct record) {
        String sql = "insert into t_product(productid,productname,brand," +
                "memory,price,colortype,productlmage) values(?,?,?,?,?,?,?)";
        Object[] para= {record.getProductid(),record.getProductname(),record.getBrand(),
                record.getMemory(),record.getPrice(),record.getColortype(),record.getProductlmage()};
        int rows=dataUtil.update(sql,para);
        if(rows>0) return true;
        else return false;
    }

    @Override
    public boolean deleteproduct(int productid) {

        String sql="delete from t_product where productid=?";
        Object[] para={productid};
        int rows=dataUtil.delete(sql,para);
        if(rows>0) return true;
        else return false;
    }

    @Override
    public Tproduct getproductById(int productid) {

        String sql="select * from t_product  where productid=?";
        Object[] para={productid};
        ResultSet rs=dataUtil.select(sql,para);
        Tproduct product=new Tproduct(rs);
        dataUtil.close();
        return product;
    }

    @Override
    public List<Tproduct> getAllproduct() {

        String sql="select * from t_product";
        ResultSet rs=dataUtil.select(sql,null);
        List<Tproduct> list=Tproduct.tranlist(rs);
        dataUtil.close();
        return list;
    }

    @Override
    public boolean removeProduct(int productid) {
        return false;
    }

    @Override
    public List<Tproduct> getproductsByProductname(String productname) {
        String sql="select * from t_product where productname like ?";
        Object[] para={"%"+productname+"%"};
        ResultSet rs=dataUtil.select(sql,para);
        List<Tproduct> list=Tproduct.tranlist(rs);
        dataUtil.close();
        return list;

    }

    @Override
    public List<Tproduct> getProductsByUser(String userid) {
        return null;
    }


}
