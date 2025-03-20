package com.shop.dao;

import com.shop.util.JDBCUtils;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

import com.shop.entity.AdminUser;

/**
 * 管理员用户数据库操作类
 */
public class AdminUserDao {

    /**
     * 添加管理员用户
     * @param adminUser
     * @return
     */
    public int add(AdminUser adminUser) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "insert into admin_user(username, password, real_name, sex, birthday, create_datetime) values(?, ?, ?, ?, ?, ?)";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, adminUser.getUsername());
            prepareStatement.setString(2, adminUser.getPassword());
            prepareStatement.setString(3, adminUser.getRealName());
            prepareStatement.setString(4, adminUser.getSex());
            prepareStatement.setDate(5, new Date(adminUser.getBirthday().getTime()));
            prepareStatement.setDate(6, new Date(adminUser.getCreateDatetime().getTime()));
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
     * 删除管理员用户
     * @param username
     * @return
     */
    public int delete(String username) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "delete from admin_user where username = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, username);

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
     * 更新管理员用户
     * @param adminUser
     * @return
     */
    public int update(AdminUser adminUser) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "update admin_user set password = ?,real_name = ?,sex = ?,birthday = ?,update_datetime = ? where username = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, adminUser.getPassword());
            prepareStatement.setString(2, adminUser.getRealName());
            prepareStatement.setString(3, adminUser.getSex());
            prepareStatement.setDate(4, new Date(adminUser.getBirthday().getTime()));
            prepareStatement.setDate(5, new Date(adminUser.getUpdateDatetime().getTime()));
            prepareStatement.setString(6, adminUser.getUsername());
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
     * 获取管理员用户
     * @return
     */
    public List<AdminUser> getAllAdminUser(String username) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from admin_user where 1=1 ";
        // 拼接模糊查询条件
        if (username != null && !username.equals("")) {
            sql += "and username like '%" + username + "%'";
        }
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            List<AdminUser> adminUsers = new ArrayList<AdminUser>();
            while (rs.next()) {
                AdminUser adminUser = new AdminUser();
                adminUser.setUsername(rs.getString("username"));
                adminUser.setPassword(rs.getString("password"));
                adminUser.setRealName(rs.getString("real_name"));
                adminUser.setSex(rs.getString("sex"));
                adminUser.setBirthday(rs.getDate("birthday"));
                adminUser.setCreateDatetime(rs.getDate("create_datetime"));
                adminUser.setUpdateDatetime(rs.getDate("update_datetime"));
                adminUsers.add(adminUser);
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return adminUsers;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据username获取管理员用户详情
     * @param username
     * @return
     */
    public AdminUser getAdminUserByUsername(String username) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from admin_user where username = ?";

        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setString(1, username);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            AdminUser adminUser = null;
            while (rs.next()) {
                adminUser = new AdminUser();
                adminUser.setUsername(rs.getString("username"));
                adminUser.setPassword(rs.getString("password"));
                adminUser.setRealName(rs.getString("real_name"));
                adminUser.setSex(rs.getString("sex"));
                adminUser.setBirthday(rs.getDate("birthday"));
                adminUser.setCreateDatetime(rs.getDate("create_datetime"));
                adminUser.setUpdateDatetime(rs.getDate("update_datetime"));
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return adminUser;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

}
