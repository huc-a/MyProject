package dao;

import domain.Category;
import util.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    
    // 查询所有分类
    public List<Category> findAll() {
        List<Category> list = new ArrayList<Category>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM book_categories";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                list.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }
    
    // 添加分类
    public boolean add(Category category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JDBCUtils.getConnection();
            String sql = "INSERT INTO book_categories (category_name, description) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category.getCategoryName());
            pstmt.setString(2, category.getDescription());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }
    
    // 删除分类
    public boolean delete(int categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JDBCUtils.getConnection();
            String sql = "DELETE FROM book_categories WHERE category_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }
    
    // 更新分类
    public boolean update(Category category) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JDBCUtils.getConnection();
            String sql = "UPDATE book_categories SET category_name = ?, description = ? WHERE category_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category.getCategoryName());
            pstmt.setString(2, category.getDescription());
            pstmt.setInt(3, category.getCategoryId());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }
    
    // 根据ID查询分类
    public Category findById(int categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM book_categories WHERE category_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                return category;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return null;
    }
} 