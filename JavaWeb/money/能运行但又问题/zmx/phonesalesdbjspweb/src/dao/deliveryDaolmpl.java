package dao;

import model.Tdelivery;
import utils.DataUtil;
import utils.IDataUtil;

import java.sql.ResultSet;
import java.util.List;

public class deliveryDaolmpl implements deliveryDAO{
    private IDataUtil dataUtil = null;

    public deliveryDaolmpl(){
        dataUtil = new DataUtil();
    }
    @Override
    public int adddelivery(Tdelivery record) {
        String sql = "insert into t_delivery(deliveryid,useraccount,country,province," +
                "city,detailaddr,contactphone1,contactphone2) values(?,?,?,?,?,?,?,?)";
        Object[] para = {record.getDeliveryid(),record.getUseraccount("112233"),record.getCountry(),
                record.getProvince(),record.getCity(),record.getDetailaddr(),
                record.getContactphone1(),record.getContactphone2("123556")};
        int key = dataUtil.insert(sql,para);
        return key;
    }

    @Override
    public int updatedelivery(Tdelivery record) {
        String sql = "insert into t_delivery(deliveryid,useraccount,country,province," +
                "city,detailaddr,contactphone1,contactphone2) values(?,?,?,?,?,?,?,?)";
        Object[] para= {record.getDeliveryid(),record.getUseraccount(""),record.getCountry(),
                record.getProvince(),record.getCity(),record.getDetailaddr(),
                record.getContactphone1(),record.getContactphone2("")};
        int key = dataUtil.insert(sql,para);
        return key;
    }

    @Override
    public boolean deletedelivery(int deliveryid) {
        String sql="delete from t_delivery where deliveryid=?";
        Object[] para={deliveryid};
        int rows=dataUtil.delete(sql,para);
        if(rows>0) return true;
        else return false;

    }

    @Override
    public Tdelivery getdeliveryById(int deliveryid) {
        String sql="select * from t_delivery where deliveryid=?";
        Object[] para={deliveryid};
        ResultSet rs=dataUtil.select(sql,para);
        Tdelivery delivery=new Tdelivery(rs);
        dataUtil.close();
        return delivery;
    }

    @Override
    public List<Tdelivery> getAlldelivery() {
        String sql="select * from t_delivery";
        ResultSet rs=dataUtil.select(sql,null);
        List<Tdelivery> list=Tdelivery.tranList(rs);
        dataUtil.close();
        return list;
    }

    @Override
    public List<Tdelivery> getdeliverysByUseraccount(String useraccount) {
        String sql="select * from t_delivery where useraccount like ?";
        Object[] para={"%"+useraccount+"%"};
        ResultSet rs=dataUtil.select(sql,para);
        List<Tdelivery> list=Tdelivery.tranList(rs);
        dataUtil.close();
        return list;
    }
}
