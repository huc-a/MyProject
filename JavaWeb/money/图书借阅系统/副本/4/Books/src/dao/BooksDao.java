package dao;

import domain.Book;
import util.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;

public class BooksDao {
    // 添加图书
    public boolean insert(Book book) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "INSERT INTO books(bookname,publish,price,stock,image) VALUES(?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, book.getBookname());
            pstmt.setString(2, book.getPublish());
            pstmt.setFloat(3, book.getPrice());
            pstmt.setInt(4, book.getStock());
            pstmt.setString(5, book.getImage());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    // 查询所有图书
    public ArrayList<Book> findAll() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Book> list = new ArrayList<Book>();
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM books";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setStock(rs.getInt("stock"));
                book.setImage(rs.getString("image"));
                list.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }

    // 根据ID查询图书
    public Book findById(int bookid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM books WHERE bookid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookid);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setStock(rs.getInt("stock"));
                book.setImage(rs.getString("image"));
                return book;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return null;
    }

    // 更新图书
    public boolean update(Book book) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "UPDATE books SET bookname=?, publish=?, price=?, stock=?, image=? WHERE bookid=?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, book.getBookname());
            pstmt.setString(2, book.getPublish());
            pstmt.setFloat(3, book.getPrice());
            pstmt.setInt(4, book.getStock());
            pstmt.setString(5, book.getImage());
            pstmt.setInt(6, book.getBookid());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    // 删除图书
    public boolean delete(int bookid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "DELETE FROM books WHERE bookid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookid);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    public ArrayList<Book> search(String keyword) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Book> list = new ArrayList<Book>();
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM books WHERE bookname LIKE ? OR publish LIKE ?";
            pstmt = conn.prepareStatement(sql);
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setStock(rs.getInt("stock"));
                book.setImage(rs.getString("image"));
                list.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }

    // 根据分类ID查询图书
    public ArrayList<Book> findByCategory(int categoryId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Book> list = new ArrayList<Book>();
        
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT * FROM books WHERE category_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setStock(rs.getInt("stock"));
                book.setImage(rs.getString("image"));
                book.setCategoryId(rs.getInt("category_id"));
                list.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return list;
    }
}
