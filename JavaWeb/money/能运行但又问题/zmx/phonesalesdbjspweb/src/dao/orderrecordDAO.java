package dao;

import model.Torderrecord;

import java.util.List;

public interface orderrecordDAO {
    /**
     * 添加一条订购记录
     * @param record
     * @return
     */
    public int addorderrecord(Torderrecord record);

    /**
     * 修改订购记录
     * @param record
     * @return
     */
    public int updateorderrecord(Torderrecord record);

    /**
     * 删除
     * @param saleid
     * @return
     */
    public boolean deleteorderrecord(int saleid);

    /**
     * 根据ID查找
     * @param saleid
     * @return
     */
    public Torderrecord getorderrecordById(int saleid);
    /**
     *
     * @param productid
     * @return List<TRoomType>
     */
    public List<Torderrecord> getOderrecordListByProductid(int productid);

    /**
     * 查找所有
     * @return
     */
    public List<Torderrecord> getAllorderrecord();

    /**
     * 根据用户账号查找
     * @param useraccount
     * @return
     */
    public List<Torderrecord> getorderrecordsByUseraccount(String useraccount);
}
