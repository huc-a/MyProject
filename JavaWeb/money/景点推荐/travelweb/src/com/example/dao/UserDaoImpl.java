package com.example.dao;

import com.example.model.User;
import com.example.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    @Override
    public User findUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM t_user WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getInt("is_admin") == 1 ? "admin" : "user");
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void addUser(User user) {
        String sql = "INSERT INTO t_user (username, password, email, create_time, status, is_admin) " +
                    "VALUES (?, ?, ?, NOW(), 1, 0)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            
            int affectedRows = pstmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("创建用户失败，没有行被插入。");
            }

            // 获取自动生成的ID
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("创建用户失败，没有获取到ID。");
                }
            }
            
            // 更新最后登录时间
            updateLastLogin(user.getId());
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("注册失败: " + e.getMessage());
        }
    }

    private void updateLastLogin(int userId) {
        String sql = "UPDATE t_user SET last_login = NOW() WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addFavorite(User user, String attractionId) {
        String sql = "INSERT INTO t_user_favorite (user_id, scenic_spot_id) VALUES (?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, user.getId());
            pstmt.setInt(2, Integer.parseInt(attractionId));
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<String> getInterests(int userId) {
        List<String> interests = new ArrayList<>();
        String sql = "SELECT t.name FROM t_interest_tag t " +
                    "JOIN t_user_interest ui ON t.id = ui.interest_id " +
                    "WHERE ui.user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                interests.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return interests;
    }
}
