package com.shop.dao;

import com.shop.util.JDBCUtils;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

import com.shop.entity.User;

/**
 * 用户数据库操作类
 */
public class UserDao {

    /**
     * 添加用户
     * @param user
     * @return
     */
    public int add(User user) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "insert into user(phone, username, password, real_name, sex, birthday, address, create_datetime) values(?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, user.getPhone());
            prepareStatement.setString(2, user.getUsername());
            prepareStatement.setString(3, user.getPassword());
            prepareStatement.setString(4, user.getRealName());
            prepareStatement.setString(5, user.getSex());
            prepareStatement.setDate(6, new Date(user.getBirthday().getTime()));
            prepareStatement.setString(7, user.getAddress());
            prepareStatement.setDate(8, new Date(user.getCreateDatetime().getTime()));
            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 删除用户
     * @param phone
     * @return
     */
    public int delete(String phone) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "delete from user where phone = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, phone);

            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 更新用户
     * @param user
     * @return
     */
    public int update(User user) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "update user set username = ?,password = ?,real_name = ?,sex = ?,birthday = ?,address = ?,update_datetime = ? where phone = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, user.getUsername());
            prepareStatement.setString(2, user.getPassword());
            prepareStatement.setString(3, user.getRealName());
            prepareStatement.setString(4, user.getSex());
            prepareStatement.setDate(5, new Date(user.getBirthday().getTime()));
            prepareStatement.setString(6, user.getAddress());
            prepareStatement.setDate(7, new Date(user.getUpdateDatetime().getTime()));
            prepareStatement.setString(8, user.getPhone());
            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 获取用户
     * @return
     */
    public List<User> getAllUser(String phone, String realName) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from user where 1=1 ";
        if (phone != null && !phone.equals("")) {
            sql += "and phone like '%" + phone + "%'";
        }
        if (realName != null && !realName.equals("")) {
            sql += "and real_name like '%" + realName + "%'";
        }
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            List<User> users = new ArrayList<User>();
            while (rs.next()) {
                User user = new User();
                user.setPhone(rs.getString("phone"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRealName(rs.getString("real_name"));
                user.setSex(rs.getString("sex"));
                user.setBirthday(rs.getDate("birthday"));
                user.setAddress(rs.getString("address"));
                user.setCreateDatetime(rs.getDate("create_datetime"));
                user.setUpdateDatetime(rs.getDate("update_datetime"));
                users.add(user);
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return users;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据phone获取用户详情
     * @param phone
     * @return
     */
    public User getUserByPhone(String phone) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from user where phone = ?";

        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setString(1, phone);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            User user = null;
            while (rs.next()) {
                user = new User();
                user.setPhone(rs.getString("phone"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRealName(rs.getString("real_name"));
                user.setSex(rs.getString("sex"));
                user.setBirthday(rs.getDate("birthday"));
                user.setAddress(rs.getString("address"));
                user.setCreateDatetime(rs.getDate("create_datetime"));
                user.setUpdateDatetime(rs.getDate("update_datetime"));
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return user;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

}
