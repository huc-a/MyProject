package com.bookstore.dao;

import com.bookstore.model.BookComment;
import com.bookstore.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookCommentDAO {
    
    public List<BookComment> getComments(String search, Integer status) {
        List<BookComment> comments = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT c.*, b.title as book_name, u.username " +
            "FROM book_comments c " +
            "JOIN books b ON c.book_id = b.id " +
            "JOIN users u ON c.user_id = u.id " +
            "WHERE 1=1"
        );
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (b.title LIKE ? OR c.content LIKE ?)");
        }
        if (status != null) {
            sql.append(" AND c.status = ?");
        }
        sql.append(" ORDER BY c.create_time DESC");
        
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
                    BookComment comment = new BookComment();
                    comment.setId(rs.getInt("id"));
                    comment.setBookId(rs.getInt("book_id"));
                    comment.setUserId(rs.getInt("user_id"));
                    comment.setContent(rs.getString("content"));
                    comment.setRating(rs.getInt("rating"));
                    comment.setStatus(rs.getInt("status"));
                    comment.setReply(rs.getString("reply"));
                    comment.setReplyTime(rs.getTimestamp("reply_time"));
                    comment.setCreateTime(rs.getTimestamp("create_time"));
                    comment.setUpdateTime(rs.getTimestamp("update_time"));
                    comment.setBookName(rs.getString("book_name"));
                    comment.setUsername(rs.getString("username"));
                    comments.add(comment);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
    
    public boolean updateStatus(Integer id, Integer status) {
        String sql = "UPDATE book_comments SET status = ? WHERE id = ?";
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
        String sql = "UPDATE book_comments SET reply = ?, reply_time = NOW() WHERE id = ?";
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