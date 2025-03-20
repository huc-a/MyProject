package dao;

import domain.Order;
import util.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdersDao {
    // 查询所有订单（包含图书名称和用户名）
    public List<Order> findAll() {
        List<Order> orderList = new ArrayList<Order>();
        String sql = "SELECT o.*, b.bookname, b.publish, b.image, u.NAME as username " +
                    "FROM orders o " +
                    "LEFT JOIN books b ON o.bookid = b.bookid " +
                    "LEFT JOIN users u ON o.id = u.id " +
                    "ORDER BY o.time DESC";
                    
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderid(rs.getInt("orderid"));
                order.setBookid(rs.getInt("bookid"));
                order.setId(rs.getInt("id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setTime(rs.getTimestamp("time"));
                order.setAddress(rs.getString("address"));
                order.setPhone(rs.getString("phone"));
                order.setBookname(rs.getString("bookname"));
                order.setUsername(rs.getString("username"));
                order.setPublish(rs.getString("publish"));
                order.setImage(rs.getString("image"));
                orderList.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return orderList;
    }

    // 添加订单
    public boolean add(Order order) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "INSERT INTO orders (bookid, id, quantity, total_price, status, time, address, phone) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, order.getBookid());
            pstmt.setInt(2, order.getId());
            pstmt.setInt(3, order.getQuantity());
            pstmt.setDouble(4, order.getTotalPrice());
            pstmt.setInt(5, order.getStatus());
            pstmt.setTimestamp(6, new Timestamp(order.getTime().getTime()));
            pstmt.setString(7, order.getAddress());
            pstmt.setString(8, order.getPhone());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
    }

    // 删除订单（归还图书）
    public boolean delete(int orderid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean autoCommit = true;
        boolean success = false;
        
        try {
            conn = JDBCUtils.getConnection();
            // 保存当前自动提交设置
            autoCommit = conn.getAutoCommit();
            // 关闭自动提交
            conn.setAutoCommit(false);
            
            // 删除订单
            String sql = "DELETE FROM orders WHERE orderid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderid);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                // 提交事务
                conn.commit();
                success = true;
            } else {
                // 回滚事务
                conn.rollback();
            }
        } catch (Exception e) {
            try {
                // 发生异常时回滚事务
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                // 恢复自动提交设置
                if (conn != null) {
                    conn.setAutoCommit(autoCommit);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            JDBCUtils.release(null, pstmt, conn);
        }
        return success;
    }

    // 根据ID查询订单
    public Order findById(int orderid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT o.*, b.bookname, b.publish, b.image, u.NAME as username " +
                        "FROM orders o " +
                        "LEFT JOIN books b ON o.bookid = b.bookid " +
                        "LEFT JOIN users u ON o.id = u.id " +
                        "WHERE o.orderid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderid);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setOrderid(rs.getInt("orderid"));
                order.setBookid(rs.getInt("bookid"));
                order.setId(rs.getInt("id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setTime(rs.getTimestamp("time"));
                order.setAddress(rs.getString("address"));
                order.setPhone(rs.getString("phone"));
                order.setBookname(rs.getString("bookname"));
                order.setUsername(rs.getString("username"));
                order.setPublish(rs.getString("publish"));
                order.setImage(rs.getString("image"));
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return null;
    }

    // 更新订单
    public boolean update(Order order) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "UPDATE orders SET status=?, address=?, phone=? WHERE orderid=?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, order.getStatus());
            pstmt.setString(2, order.getAddress());
            pstmt.setString(3, order.getPhone());
            pstmt.setInt(4, order.getOrderid());
            
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(null, pstmt, conn);
        }
        return false;
    }

    // 根据用户ID查询订单
    public List<Order> findByUserId(int userId) {
        List<Order> orderList = new ArrayList<Order>();
        String sql = "SELECT o.*, b.bookname, b.publish, b.image, u.NAME as username " +
                    "FROM orders o " +
                    "LEFT JOIN books b ON o.bookid = b.bookid " +
                    "LEFT JOIN users u ON o.id = u.id " +
                    "WHERE o.id = ? " +
                    "ORDER BY o.time DESC";
                
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderid(rs.getInt("orderid"));
                order.setBookid(rs.getInt("bookid"));
                order.setId(rs.getInt("id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setTime(rs.getTimestamp("time"));
                order.setBookname(rs.getString("bookname"));
                order.setUsername(rs.getString("username"));
                order.setPublish(rs.getString("publish"));
                order.setImage(rs.getString("image"));
                order.setAddress(rs.getString("address"));
                order.setPhone(rs.getString("phone"));
                orderList.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return orderList;
    }

    // 获取历史借阅总数
    public int getTotalBorrowCount(int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "SELECT COUNT(*) as total FROM orders o " +
                        "LEFT JOIN books b ON o.bookid = b.bookid " +
                        "WHERE o.id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtils.release(rs, pstmt, conn);
        }
        return 0;
    }
} 