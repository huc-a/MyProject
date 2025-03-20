package com.tuling.dao;

import com.tuling.domain.User;

import java.util.List;

public interface UserDao {
    //添加用户
    public int add(User user);
    //用户按邮箱或者手机号登录
    public User findByStr(String str,boolean flag);
    //查看所有人信息
    public List<User> findAll();
    //删除
    public int del(User user);
    //修改信息
    public int update(User user);
    //修改密码
    public int updatePwd(User user);
    //查看个人信息
    public User findById(int id);

    //获取管理员uid
    public List<Integer> root();
}
