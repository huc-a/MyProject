package com.shop.service;

import java.util.List;
import com.shop.entity.User;

import com.shop.dao.UserDao;

/**
 * 用户业务处理类
 */
public class UserService {

    // 创建数据库操作对象
    private UserDao userDao = new UserDao();

    /**
     * 添加用户
     * @param user
     * @return
     */
    public int add(User user) {
        return userDao.add(user);
    }

    /**
     * 删除用户
     * @param phone
     * @return
     */
    public int delete(String phone) {
        return userDao.delete(phone);
    }

    /**
     * 更新用户
     * @param user
     * @return
     */
    public int update(User user) {
        return userDao.update(user);
    }

    /**
     * 获取用户
     * @return
     */
    public List<User> getAllUser(String phone, String realName) {
        return userDao.getAllUser(phone, realName);
    }

    /**
     * 根据phone获取用户详情
     * @param phone
     * @return
     */
    public User getUserByPhone(String phone) {
        return userDao.getUserByPhone(phone);
    }
}
