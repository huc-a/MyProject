package com.bookstore.dao;

import com.bookstore.model.Feedback;
import com.bookstore.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {
    
    public List<Feedback> getFeedbacks(String search, Integer status) {
        List<Feedback> feedbacks = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT f.*, u.username " +
            "FROM feedbacks f " +
            "JOIN users u ON f.user_id = u.id " +
            "WHERE 1=1"
        );
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (f.title LIKE ? OR f.content LIKE ?)");
        }
        if (status != null) {
            sql.append(" AND f.status = ?");
        }
        sql.append(" ORDER BY f.create_time DESC");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String pattern = "%" + search + "%";
                ps.setString(paramIndex++, pattern);
                ps.setString(paramIndex++, pattern);
            }
            if (status != null) {
                ps.setInt(paramIndex, status);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setId(rs.getInt("id"));
                    feedback.setUserId(rs.getInt("user_id"));
                    feedback.setType(rs.getInt("type"));
                    feedback.setTitle(rs.getString("title"));
                    feedback.setContent(rs.getString("content"));
                    feedback.setStatus(rs.getInt("status"));
                    feedback.setReply(rs.getString("reply"));
                    feedback.setReplyTime(rs.getTimestamp("reply_time"));
                    feedback.setCreateTime(rs.getTimestamp("create_time"));
                    feedback.setUpdateTime(rs.getTimestamp("update_time"));
                    feedback.setUsername(rs.getString("username"));
                    feedbacks.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
    
    public boolean updateStatus(Integer id, Integer status) {
        String sql = "UPDATE feedbacks SET status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, status);
            ps.setInt(2, id);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateReply(Integer id, String reply) {
        String sql = "UPDATE feedbacks SET reply = ?, reply_time = NOW(), status = 2 WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, reply);
            ps.setInt(2, id);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 