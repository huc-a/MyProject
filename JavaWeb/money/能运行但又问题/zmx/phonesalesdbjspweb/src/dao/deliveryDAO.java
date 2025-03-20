package dao;

import model.Tdelivery;

import java.util.List;

public interface deliveryDAO {
    /**
     * 添加
     * @param record
     * @return
     */
    public int adddelivery(Tdelivery record);

    /**
     * 修改
     * @param record
     * @return
     */
    public int updatedelivery(Tdelivery record);//修改

    /**
     * 删除
     * @param deliveryid
     * @return
     */
    public boolean deletedelivery(int deliveryid);//删除

    /**
     * 通过ID获得信息
     * @param deliveryid
     * @return
     */
    public Tdelivery getdeliveryById(int deliveryid);

    /**
     * 查找全部
     * @return
     */
    public List<Tdelivery> getAlldelivery();//查找全部

    /**
     * 根据用户账号查找
     * @param useraccount
     * @return
     */
    public List<Tdelivery> getdeliverysByUseraccount(String useraccount);//查找变量
}
