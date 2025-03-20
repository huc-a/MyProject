package dao;

import domain.Book;
import util.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;

public class BooksDao {
    // 添加图书
    public boolean insert(Book book) {
        String sql = "INSERT INTO books(bookid,bookname,publish,price,image) VALUES(?,?,?,?,?)";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, book.getBookid());
            pstmt.setString(2, book.getBookname());
            pstmt.setString(3, book.getPublish());
            pstmt.setFloat(4, book.getPrice());
            pstmt.setString(5, book.getImage());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 查询所有图书
    public ArrayList<Book> findAll() {
        ArrayList<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM books";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setImage(rs.getString("image"));
                list.add(book);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 根据ID查询图书
    public Book findById(int bookid) {
        String sql = "SELECT * FROM books WHERE bookid = ?";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookid);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setImage(rs.getString("image"));
                return book;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 更新图书
    public boolean update(Book book) {
        String sql = "UPDATE books SET bookname=?, publish=?, price=?, image=? WHERE bookid=?";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getBookname());
            pstmt.setString(2, book.getPublish());
            pstmt.setFloat(3, book.getPrice());
            pstmt.setString(4, book.getImage());
            pstmt.setInt(5, book.getBookid());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 删除图书
    public boolean delete(int bookid) {
        String sql = "DELETE FROM books WHERE bookid = ?";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookid);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 根据ID查找图书
    public Book find(int bookid) {
        String sql = "SELECT * FROM books WHERE bookid = ?";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookid);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book();
                book.setBookid(rs.getInt("bookid"));
                book.setBookname(rs.getString("bookname"));
                book.setPublish(rs.getString("publish"));
                book.setPrice(rs.getFloat("price"));
                book.setImage(rs.getString("image"));
                return book;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }
}
