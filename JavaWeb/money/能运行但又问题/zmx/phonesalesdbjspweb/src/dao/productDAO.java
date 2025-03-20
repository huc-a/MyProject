package dao;

import model.Tproduct;

import java.util.List;

public interface productDAO {
    /**
     * 添加产品
     * @param record
     * @return
     */
    public int addproduct(Tproduct record);

    /**
     * 修改
     * @param record
     * @return
     */
    public boolean updateproduct(Tproduct record);

    /**
     * 删除
     * @param productid
     * @return
     */
    public boolean deleteproduct(int productid);

    /**
     * 根据ID查找信息
     * @param productid
     * @return
     */
    public Tproduct getproductById(int productid);

    /**
     * 查找
     * @return
     */
    public List<Tproduct> getAllproduct();
    /**
     * 删除指定的酒店信息
     * @param productid
     * @return 成功返回true，失败返回false
     */
    public boolean removeProduct(int productid);

    /**
     * 根据手机名称查找信息
     * @param productname
     * @return
     */
    public List<Tproduct> getproductsByProductname(String productname);
    /**
     * 根据用户的userid查询所管理的所有的酒店信息
     * @param userid
     * @return
     */
    public List<Tproduct> getProductsByUser(String userid);
}

