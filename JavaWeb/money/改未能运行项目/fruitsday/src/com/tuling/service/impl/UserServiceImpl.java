package com.tuling.service.impl;

import com.tuling.dao.CartDao;
import com.tuling.dao.UserDao;
import com.tuling.dao.impl.CartDaoImpl;
import com.tuling.dao.impl.UserDaoImpl;
import com.tuling.domain.User;
import com.tuling.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();
    private CartDao cartDao = new CartDaoImpl();
    @Override
    public User add(User user) {
        int num = userDao.add(user);
        User loginUser = null;
        if(num==1){
            //根据用户名密码登录
             loginUser = login(user.getEmail(),user.getPwd(),true);
             //创建用户的时候同时创建一张表
//            boolean result = cartDao.createCart(loginUser.getId());
//            if(!result){
//                del(user);
//                return null;
//            }
        }
        return loginUser;
    }

    @Override
    public User login(String str, String pwd, boolean flag) {
        User user = userDao.findByStr(str, flag);
        if(user.getPwd().equals(pwd)){
            user.setPwd("******");
            return user;
        }
        return null;
    }

    @Override
    public boolean del(User user) {
        int num=userDao.del(user);
        if(num==1)
            return true;
        else
            return false;
    }

    @Override
    public List<User> findAll() {
        return  userDao.findAll();
    }

    @Override
    public List<Integer> root() {
        return  userDao.root();
    }

    @Override
    public boolean update(User user) {
        int num=userDao.update(user);
        if(num==1)
            return true;
        else
            return false;
    }

    @Override
    public User findById(int id) {
        return  userDao.findById(id);
    }
}
