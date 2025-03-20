package dao;

import model.Tdelivery;
import model.Torderrecord;
import utils.DataUtil;
import utils.IDataUtil;

import java.sql.ResultSet;
import java.util.List;

public  class orderrecordDaolmpl implements orderrecordDAO {
    private IDataUtil dataUtil = null;

    public orderrecordDaolmpl() { dataUtil = new DataUtil(); }


    @Override
    public int addorderrecord(Torderrecord record) {
        String sql = "insert into t_orderrecord(saleid,productid,salequantity," +
                "saleamount,saletime,useraccount,recordstatus) values(?,?,?,?,?,?,?)";
        Object[] para = {record.getSaleid(),record.getProductid(),record.getSalequantity(),record.getSaleamount(),
        record.getSaletime(),record.getUseraccount(),record.getRecordstatus()};

        int key = dataUtil.insert(sql,para);
        return key;
    }

    @Override
    public int updateorderrecord(Torderrecord record) {
        String sql =  "insert into t_orderrecord(saleid,productid,salequantity," +
                "saleamount,saletime,useraccount,recordstatus) values(?,?,?,?,?,?,?)";
        Object[] para= {record.getSaleid(),record.getProductid(),record.getSalequantity(),record.getSaleamount(),
                record.getSaletime(),record.getUseraccount(),record.getRecordstatus()};
        int key = dataUtil.insert(sql,para);
        return key;
    }

    @Override
    public boolean deleteorderrecord(int saleid) {
        String sql="delete from t_orderrecord where saleid=?";
        Object[] para={saleid};
        int rows=dataUtil.delete(sql,para);
        if(rows>0) return true;
        else return false;
    }

    @Override
    public Torderrecord getorderrecordById(int saleid) {

        String sql="select * from t_orderrecord where saleid=?";
        Object[] para={saleid};
        ResultSet rs=dataUtil.select(sql,para);
        Torderrecord orderrecord=new Torderrecord(rs);
        dataUtil.close();
        return orderrecord;
    }

    @Override
    public List<Torderrecord> getOderrecordListByProductid(int productid) {
        return null;
    }

    @Override
    public List<Torderrecord> getAllorderrecord() {
        return null;
    }

    @Override
    public List<Torderrecord> getorderrecordsByUseraccount(String useraccount) {
        String sql="select * from t_orderrecord where useraccount like ?";
        Object[] para={"%"+useraccount+"%"};
        ResultSet rs=dataUtil.select(sql,para);
        List<Torderrecord> list=Torderrecord.tranlist(rs);
        dataUtil.close();
        return list;
    }


}