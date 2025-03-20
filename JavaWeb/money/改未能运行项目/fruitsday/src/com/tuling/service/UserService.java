package com.tuling.service;

import com.tuling.domain.User;

import java.util.List;

public interface UserService {
    public  User add(User user);
    public  User login(String str,String pwd,boolean flag);
    public  boolean del(User user);
    public  List<User> findAll();
    public  List<Integer> root();
    public  boolean update(User user);
    public  User findById(int id);
}
