package com.hospital.service;

import com.hospital.dao.UserDao;
import com.hospital.dao.UserDaoImpl;
import com.hospital.model.User;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();
    
    @Override
    public boolean register(User user) throws Exception {
        // 检查手机号是否已存在
        if (userDao.findByFullName(user.getFullName()) != null) {
            return false;
        }
        return userDao.save(user);
    }
    
    @Override
    public User login(String fullName, String password) throws Exception {
        User user = userDao.findByFullName(fullName);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
} 