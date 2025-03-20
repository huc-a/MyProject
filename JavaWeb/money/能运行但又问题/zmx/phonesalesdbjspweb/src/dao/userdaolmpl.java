package dao;

import model.Tdelivery;
import model.Tuser;
import utils.DataUtil;
import utils.IDataUtil;

import java.sql.ResultSet;
import java.util.List;

public class userdaolmpl implements userDAO{
    private IDataUtil dataUtil = null;

    public userdaolmpl(){ dataUtil = new DataUtil(); }

    @Override
    public boolean isUseridValid(String useraccount) {
        return false;
    }

    @Override
    public boolean registerUser(Tuser user) {
        return false;
    }

    @Override
    public int adduser(Tuser record) {
        String sql = "insert into t_user(useraccount,pwd,username,utid,idnumber,mobile)values(?,?,?,?,?,?)";
        Object[] para = {record.getUseraccount(),record.getPwd(),record.getUsername(),
        record.getUtid(),record.getIdnumber(),record.getMobile()};
        int key = dataUtil.insert(sql,para);
        return key;
    }

    @Override
    public int updateuser(Tuser record) {
        String sql = "insert into t_user(useraccount,pwd,username,utid,idnumber,mobile)values(?,?,?,?,?,?)";
        Object[] para= {record.getUseraccount(),record.getPwd(),record.getUsername(),
                record.getUtid(),record.getIdnumber(),record.getMobile()};
        int key = dataUtil.insert(sql,para);
        return key;
    }

    @Override
    public boolean deleteuser(int useraccount) {
        String sql="delete from t_user where useraccount=?";
        Object[] para={useraccount};
        int rows=dataUtil.delete(sql,para);
        if(rows>0) return true;
        else return false;
    }

    @Override
    public Tuser getuserById(int useraccount) {
        String sql="select * from t_user where useraccount=?";
        Object[] para={useraccount};
        ResultSet rs=dataUtil.select(sql,para);
        Tuser user=new Tuser(rs);
        dataUtil.close();
        return user;
    }


    @Override
    public List<Tuser> getAlluser() {
        return null;
    }

    @Override
    public List<Tuser> getouserByTitles(String title) {
        return null;
    }

    @Override
    public Tuser userLogin(String useraccount, String pwd) {
        String sql = "select * from t_user where useraccount = ? and pwd = ?";
        Object[] para = {useraccount, pwd};
        dataUtil.select(sql,para);
        ResultSet rs = dataUtil.select(sql, para);
        Tuser user = new Tuser(rs);
        dataUtil.close();
        return user;//返回用户实体对象
    }
}
