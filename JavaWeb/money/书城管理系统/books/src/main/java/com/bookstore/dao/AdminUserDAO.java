package com.bookstore.dao;

import com.bookstore.model.AdminUser;
import com.bookstore.util.DBUtil;
import java.sql.*;

public class AdminUserDAO {
    
    public AdminUser findByUsername(String username) {
        String sql = "SELECT * FROM admin_user WHERE username = ? AND status = 1";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    AdminUser user = new AdminUser();
                    user.setId(rs.getLong("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRealName(rs.getString("real_name"));
                    user.setPhone(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));
                    user.setStatus(rs.getInt("status"));
                    user.setCreateTime(rs.getTimestamp("create_time"));
                    user.setUpdateTime(rs.getTimestamp("update_time"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
} 