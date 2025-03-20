package com.example.service;

import com.example.model.User;
import com.example.dao.UserDao;

public class UserService {
    private UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao; // 使用构造函数注入 DAO
    }

    // 用户登录
    public User login(String username, String password) {
        return userDao.findUserByUsernameAndPassword(username, password);
    }

    // 用户注册
    public void register(User user) {
        userDao.addUser(user);
    }

    // 添加用户收藏
    public void addFavorite(User user, String attractionId) {
        userDao.addFavorite(user, attractionId); // 调用 UserDao 的方法
    }
}