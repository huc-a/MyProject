package com.tuling.dao.impl;

import com.tuling.dao.UserDao;
import com.tuling.domain.User;
import com.tuling.util.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class UserDaoImpl implements UserDao {
    //传递一个数据源对象
    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
    @Override
    public int add(User user) {
        String sql = "insert into user(email,phone,pwd,uname)values(?,?,?,?)";
        Object[] params = {user.getEmail(),user.getPhone(),user.getPwd(),user.getUname()};
        try {
            return queryRunner.update(sql,params);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return 0;
    }

    @Override
    public User findByStr(String str, boolean flag) {
        String sql="";
        if(flag)
            sql = "select id,email,phone,pwd,uname from user where email=?";
        else
            sql = "select id,email,phone,pwd,uname from user where phone=?";
        Object[] params = {str};
        try {
            User user = queryRunner.query(sql, new BeanHandler<User>(User.class),params);
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<User> findAll() {
        String sql = "select id,email,phone,uname from user";
        try {
            List<User> userList = queryRunner.query(sql, new BeanListHandler<User>(User.class));
            return userList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int del(User user) {
        String sql = "DELETE  FROM user WHERE id=?";
        Object[] params = {user.getId()};
        try {
           return  queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int update(User user) {
        String sql = "UPDATE user SET email=? ,phone=? ,uname=?,pwd=? WHERE id=?";
        Object[] params = {user.getEmail(),user.getPhone(),user.getUname(),user.getPwd(),user.getId()};
        try {
           return  queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int updatePwd(User user) {
        String sql = "UPDATE user SET pwd=? WHERE id=?";
        Object[] params = {user.getPwd(),user.getId()};
        try {
            return  queryRunner.update(sql,params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public User findById(int id) {
        String sql = "select id, email,phone,uname from user where id=?";
        Object[] params = {id};
        try {
            User user = queryRunner.query(sql, new BeanHandler<User>(User.class), params);
            user.setPwd("******");
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Integer> root() {
        String sql = "select uid from root";
        List<Integer> uidList = null;
        try {
            uidList = queryRunner.query(sql, new BeanListHandler<Integer>(Integer.class));
            return uidList;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
