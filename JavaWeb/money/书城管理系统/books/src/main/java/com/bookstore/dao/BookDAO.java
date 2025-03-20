package com.bookstore.dao;

import com.bookstore.model.Book;
import com.bookstore.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    
    public List<Book> getBooks(int page, int pageSize, String search) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE 1=1";
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (title LIKE ? OR author LIKE ? OR publisher LIKE ?)";
        }
        sql += " LIMIT ? OFFSET ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            
            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex, (page - 1) * pageSize);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public int getTotalBooks(String search) {
        String sql = "SELECT COUNT(*) FROM books WHERE 1=1";
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (title LIKE ? OR author LIKE ? OR publisher LIKE ?)";
        }
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(1, searchPattern);
                ps.setString(2, searchPattern);
                ps.setString(3, searchPattern);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public Book getBookById(int id) {
        String sql = "SELECT * FROM books WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBook(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addBook(Book book) {
        String sql = "INSERT INTO books (title, author, publisher, price, stock, cover_image, description, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getPublisher());
            ps.setDouble(4, book.getPrice());
            ps.setInt(5, book.getStock());
            
            String coverImage = book.getCoverImage();
            if (coverImage != null && !coverImage.startsWith("/static/")) {
                coverImage = "/static/images/books/" + coverImage;
            }
            ps.setString(6, coverImage);
            
            ps.setString(7, book.getDescription());
            ps.setInt(8, book.getStatus());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title=?, author=?, publisher=?, price=?, stock=?, " +
                    "cover_image=?, description=?, status=? WHERE id=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getPublisher());
            ps.setDouble(4, book.getPrice());
            ps.setInt(5, book.getStock());
            ps.setString(6, book.getCoverImage());
            ps.setString(7, book.getDescription());
            ps.setInt(8, book.getStatus());
            ps.setInt(9, book.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        book.setPublisher(rs.getString("publisher"));
        book.setPrice(rs.getDouble("price"));
        book.setStock(rs.getInt("stock"));
        book.setCoverImage(rs.getString("cover_image"));
        book.setDescription(rs.getString("description"));
        book.setStatus(rs.getInt("status"));
        book.setCreateTime(rs.getTimestamp("create_time"));
        book.setUpdateTime(rs.getTimestamp("update_time"));
        return book;
    }
} 