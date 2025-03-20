package com.bookstore.dao;

import com.bookstore.model.Order;
import com.bookstore.model.OrderItem;
import com.bookstore.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    
    public List<Order> getOrders(String search) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE 1=1";
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (order_no LIKE ? OR receiver LIKE ?)";
        }
        sql += " ORDER BY create_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (search != null && !search.trim().isEmpty()) {
                String pattern = "%" + search + "%";
                ps.setString(1, pattern);
                ps.setString(2, pattern);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderNo(rs.getString("order_no"));
                    order.setAmount(rs.getDouble("amount"));
                    order.setStatus(rs.getInt("status"));
                    order.setReceiver(rs.getString("receiver"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("address"));
                    order.setCreateTime(rs.getTimestamp("create_time"));
                    order.setUpdateTime(rs.getTimestamp("update_time"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public Order getOrderById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setOrderNo(rs.getString("order_no"));
                    order.setAmount(rs.getDouble("amount"));
                    order.setStatus(rs.getInt("status"));
                    order.setReceiver(rs.getString("receiver"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("address"));
                    order.setCreateTime(rs.getTimestamp("create_time"));
                    order.setUpdateTime(rs.getTimestamp("update_time"));
                    
                    // 获取订单明细
                    order.setOrderItems(getOrderItems(order.getId()));
                    return order;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setBookId(rs.getInt("book_id"));
                    item.setBookName(rs.getString("book_name"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setSubtotal(rs.getDouble("subtotal"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
    
    public boolean deleteOrder(int id) {
        // 首先删除订单明细
        String deleteItemsSql = "DELETE FROM order_items WHERE order_id = ?";
        // 然后删除订单
        String deleteOrderSql = "DELETE FROM orders WHERE id = ?";
        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // 开启事务
            
            // 删除订单明细
            try (PreparedStatement ps = conn.prepareStatement(deleteItemsSql)) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }
            
            // 删除订单
            try (PreparedStatement ps = conn.prepareStatement(deleteOrderSql)) {
                ps.setInt(1, id);
                int result = ps.executeUpdate();
                
                conn.commit(); // 提交事务
                return result > 0;
            }
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback(); // 发生异常时回滚
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true); // 恢复自动提交
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
} 