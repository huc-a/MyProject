package dao;

import domain.Order;
import util.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrdersDao {
    // 查询所有订单（包含图书名称和用户名）
    public List<Order> findAll() {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT o.orderid, o.bookid, o.id, o.time, " +
                    "b.bookname, u.NAME as username " +
                    "FROM orders o " +
                    "LEFT JOIN books b ON o.bookid = b.bookid " +
                    "LEFT JOIN users u ON o.id = u.id " +
                    "ORDER BY o.time DESC";
                    
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderid(rs.getInt("orderid"));
                order.setBookid(rs.getInt("bookid"));
                order.setId(rs.getInt("id"));
                order.setTime(rs.getDate("time"));
                order.setBookname(rs.getString("bookname"));
                order.setUsername(rs.getString("username"));
                orderList.add(order);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    // 添加订单
    public boolean add(Order order) {
        String sql = "INSERT INTO orders (bookid, id, time) VALUES (?, ?, ?)";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, order.getBookid());
            pstmt.setInt(2, order.getId());
            pstmt.setDate(3, new java.sql.Date(order.getTime().getTime()));
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 删除订单
    public boolean delete(int orderid) {
        String sql = "DELETE FROM orders WHERE orderid = ?";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderid);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 根据ID查询订单
    public Order findById(int orderid) {
        String sql = "SELECT o.orderid, o.bookid, o.id, o.time, " +
                    "b.bookname, u.NAME as username " +
                    "FROM orders o " +
                    "LEFT JOIN books b ON o.bookid = b.bookid " +
                    "LEFT JOIN users u ON o.id = u.id " +
                    "WHERE o.orderid = ?";
                    
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderid);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setOrderid(rs.getInt("orderid"));
                order.setBookid(rs.getInt("bookid"));
                order.setId(rs.getInt("id"));
                order.setTime(rs.getDate("time"));
                order.setBookname(rs.getString("bookname"));
                order.setUsername(rs.getString("username"));
                return order;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 更新订单
    public boolean update(Order order) {
        String sql = "UPDATE orders SET bookid=?, id=?, time=? WHERE orderid=?";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, order.getBookid());
            pstmt.setInt(2, order.getId());
            pstmt.setDate(3, new java.sql.Date(order.getTime().getTime()));
            pstmt.setInt(4, order.getOrderid());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isBookBorrowed(int bookId) {
        String sql = "SELECT COUNT(*) FROM orders WHERE bookid = ? AND returntime IS NULL";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Order> findByUserId(int userId) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT o.*, b.bookname, b.image FROM orders o " +
                    "LEFT JOIN books b ON o.bookid = b.bookid " +
                    "WHERE o.id = ? " +
                    "ORDER BY o.time DESC";
                    
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderid(rs.getInt("orderid"));
                order.setBookid(rs.getInt("bookid"));
                order.setId(rs.getInt("id"));
                order.setTime(rs.getTimestamp("time"));
                order.setReturntime(rs.getTimestamp("returntime"));
                order.setBookname(rs.getString("bookname"));
                order.setBookImage(rs.getString("image"));
                orderList.add(order);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    public boolean updateReturnTime(Order order) {
        String sql = "UPDATE orders SET returntime = ? WHERE orderid = ? AND id = ?";
        try (Connection conn = JDBCUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setTimestamp(1, new java.sql.Timestamp(order.getReturntime().getTime()));
            pstmt.setInt(2, order.getOrderid());
            pstmt.setInt(3, order.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
} 