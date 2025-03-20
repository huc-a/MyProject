package com.mall.service.impl;

import com.mall.dao.UserDao;
import com.mall.dao.impl.UserDaoImpl;
import com.mall.model.User;
import com.mall.service.UserService;
import java.util.List;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    @Override
    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    @Override
    public User getUserById(Integer id) {
        return userDao.findById(id);
    }

    @Override
    public User getUserByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public List<User> searchUsers(String keyword) {
        return userDao.search(keyword);
    }

    @Override
    public boolean deleteUser(Integer id) {
        // 检查是否有关联的订单
        User user = userDao.findById(id);
        if (user != null) {
            return userDao.delete(id);
        }
        return false;
    }

    @Override
    public boolean updateUser(Integer id, String username, String password, String phone, String email) {
        User user = userDao.findById(id);
        if (user != null) {
            user.setUsername(username);
            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(password);
            }
            user.setPhone(phone);
            user.setEmail(email);
            return userDao.update(user);
        }
        return false;
    }
} 