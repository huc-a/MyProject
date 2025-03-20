package dao;

import model.Tuser;

import java.util.List;

public interface userDAO {
    /**
     * 检查某userid是否可用（已经存在就不可用）
     * @param useraccount
     * @return 可用（数据库中没有）返回true， 否则返回false
     */
    public boolean isUseridValid(String useraccount);
    /**
     * 注册用户（添加一个新用户）
     * @param user
     * @return boolean  成功返回true, 失败返回false
     */
    public boolean registerUser(Tuser user);
    /**
     * 添加
     * @param record
     * @return
     */
    public int adduser(Tuser record);

    /**
     * 修改
     * @param record
     * @return
     */
    public int updateuser(Tuser record);

    /**
     * 删除
     * @param useraccount
     * @return
     */
    public boolean deleteuser(int useraccount);

    /**
     *
     * @param useraccount
     * @return
     */
    public Tuser getuserById(int useraccount);

    /**
     *
     * @return
     */
    public List<Tuser> getAlluser();

    /**
     *
     * @param username
     * @return
     */
    public List<Tuser> getouserByTitles(String username);
    /**
     * 用户登录
     * @param useraccount 用户账号
     * @param pwd 密码
     * @return 登录成功返回true，失败返回false
     */
    public Tuser userLogin(String useraccount, String pwd);

}
