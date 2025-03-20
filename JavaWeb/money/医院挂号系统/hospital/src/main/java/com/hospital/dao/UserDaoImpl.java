package com.hospital.dao;

import com.hospital.model.User;
import com.hospital.util.DBUtil;
import java.sql.*;

public class UserDaoImpl implements UserDao {
    
    @Override
    public User findByFullName(String fullName) throws Exception {
        String sql = "SELECT * FROM users WHERE full_name = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password_hash"));
                user.setFullName(rs.getString("full_name"));
                user.setUserType(rs.getString("user_type"));
                user.setIdCardNumber(rs.getString("id_card_number"));
                return user;
            }
        }
        return null;
    }
    
    @Override
    public boolean save(User user) throws Exception {
        String sql = "INSERT INTO users (phone, password_hash, full_name, user_type, id_card_number) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getPhone());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getUserType());
            ps.setString(5, user.getIdCardNumber());
            return ps.executeUpdate() > 0;
        }
    }
} 