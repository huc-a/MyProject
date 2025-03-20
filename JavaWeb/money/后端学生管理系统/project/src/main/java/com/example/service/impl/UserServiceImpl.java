package com.example.service.impl;

import com.example.bean.User;
import com.example.dao.UserDao;
import com.example.dao.impl.UserDaoImpl;
import com.example.service.UserService;
import java.util.List;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    @Override
    public void addUser(User user) throws Exception {
        // 检查用户名是否已存在
        if (userDao.findByUsername(user.getUsername()) != null) {
            throw new Exception("用户名已存在");
        }
        userDao.add(user);
    }

    @Override
    public void updateUser(User user) throws Exception {
        // 检查用户是否存在
        if (userDao.findById(user.getId()) == null) {
            throw new Exception("用户不存在");
        }
        userDao.update(user);
    }

    @Override
    public void deleteUser(Integer id) throws Exception {
        userDao.delete(id);
    }

    @Override
    public User getUserById(Integer id) throws Exception {
        return userDao.findById(id);
    }

    @Override
    public List<User> getAllUsers() throws Exception {
        return userDao.findAll();
    }

    @Override
    public User login(String username, String password) throws Exception {
        return userDao.findByUsernameAndPassword(username, password);
    }
} 