package com.shop.dao;

import com.shop.util.JDBCUtils;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

import com.shop.entity.OrderDetails;

/**
 * 订单详情数据库操作类
 */
public class OrderDetailsDao {

    /**
     * 添加订单详情
     * @param orderDetails
     * @return
     */
    public int add(OrderDetails orderDetails) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "insert into order_details(order_id, goods_id, count, sub_total) values(?, ?, ?, ?)";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, orderDetails.getOrderId());
            prepareStatement.setString(2, orderDetails.getGoodsId());
            prepareStatement.setInt(3, orderDetails.getCount());
            prepareStatement.setBigDecimal(4, orderDetails.getSubTotal());
            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 删除订单详情
     * @param orderId
     * @return
     */
    public int delete(String orderId) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "delete from order_details where order_id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, orderId);

            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 更新订单详情
     * @param orderDetails
     * @return
     */
    public int update(OrderDetails orderDetails) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "update order_details set goods_id = ?,count = ?,sub_total = ? where order_id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, orderDetails.getGoodsId());
            prepareStatement.setInt(2, orderDetails.getCount());
            prepareStatement.setString(4, orderDetails.getOrderId());
            // 执行sql
            int rs = prepareStatement.executeUpdate();
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, null);
            return rs;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 获取订单详情
     * @return
     */
    public List<OrderDetails> getAllOrderDetails(String orderId) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from order_details where order_id = ?" ;
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setString(1, orderId);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            List<OrderDetails> orderDetailss = new ArrayList<OrderDetails>();
            while (rs.next()) {
                OrderDetails orderDetails = new OrderDetails();
                orderDetails.setOrderId(rs.getString("order_id"));
                orderDetails.setGoodsId(rs.getString("goods_id"));
                orderDetails.setCount(rs.getInt("count"));
                orderDetails.setSubTotal(rs.getBigDecimal("sub_total"));
                orderDetailss.add(orderDetails);
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return orderDetailss;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据orderId获取订单详情详情
     * @param orderId
     * @return
     */
    public OrderDetails getOrderDetailsByOrderId(String orderId) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from order_details where order_id = ?";

        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setString(1, orderId);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            OrderDetails orderDetails = null;
            while (rs.next()) {
                orderDetails = new OrderDetails();
                orderDetails.setOrderId(rs.getString("order_id"));
                orderDetails.setGoodsId(rs.getString("goods_id"));
                orderDetails.setCount(rs.getInt("count"));
                orderDetails.setSubTotal(rs.getBigDecimal("sub_total"));
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return orderDetails;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

}
