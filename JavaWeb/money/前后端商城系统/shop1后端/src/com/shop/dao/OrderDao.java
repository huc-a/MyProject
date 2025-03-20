package com.shop.dao;

import com.shop.util.JDBCUtils;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

import com.shop.entity.Order;

/**
 * 订单数据库操作类
 */
public class OrderDao {

    /**
     * 添加订单
     * @param order
     * @return
     */
    public int add(Order order) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "insert into `order`(id, user_phone, total_price, create_datetime) values(?, ?, ?, ?)";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, order.getId());
            prepareStatement.setString(2, order.getUserPhone());
            prepareStatement.setBigDecimal(3, order.getTotalPrice());
            prepareStatement.setDate(4, new Date(order.getCreateDatetime().getTime()));
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
     * 删除订单
     * @param id
     * @return
     */
    public int delete(String id) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "delete from `order` where id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            prepareStatement.setString(1, id);

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
     * 更新订单
     * @param order
     * @return
     */
    public int update(Order order) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "update `order` set issue_datetime = ?,received_datetime = ?, update_datetime = ? where id = ?";
        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 添加参数
            if (order.getIssueDatetime() != null) {
                prepareStatement.setDate(1, new Date(order.getIssueDatetime().getTime()));
            } else {
                prepareStatement.setDate(1, null);
            }
            if (order.getReceivedDatetime() != null) {
                prepareStatement.setDate(2, new Date(order.getReceivedDatetime().getTime()));
            } else {
                prepareStatement.setDate(2, null);
            }
            prepareStatement.setDate(3, new Date(order.getUpdateDatetime().getTime()));
            prepareStatement.setString(4, order.getId());
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
     * 获取订单
     * @return
     */
    public List<Order> getAllOrder(String userPhone) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from `order` where 1=1";
        // 拼接模糊查询条件
        if (userPhone != null && !userPhone.equals("")) {
            sql += " and user_phone = '" + userPhone + "'";
        }


        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            List<Order> orders = new ArrayList<Order>();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setUserPhone(rs.getString("user_phone"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setIssueDatetime(rs.getDate("issue_datetime"));
                order.setReceivedDatetime(rs.getDate("received_datetime"));
                order.setCreateDatetime(rs.getDate("create_datetime"));
                order.setUpdateDatetime(rs.getDate("update_datetime"));
                orders.add(order);
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return orders;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据id获取订单详情
     * @param id
     * @return
     */
    public Order getOrderById(String id) {
        // 获取数据库连接
        Connection connection = JDBCUtils.getConnection();
        // 编写sql
        String sql = "select * from `order` where id = ?";

        try {
            // 预编译sql
            PreparedStatement prepareStatement = connection.prepareStatement(sql);
            prepareStatement.setString(1, id);
            // 执行sql
            ResultSet rs = prepareStatement.executeQuery();
            Order order = null;
            while (rs.next()) {
                order = new Order();
                order.setId(rs.getString("id"));
                order.setUserPhone(rs.getString("user_phone"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setIssueDatetime(rs.getDate("issue_datetime"));
                order.setReceivedDatetime(rs.getDate("received_datetime"));
                order.setCreateDatetime(rs.getDate("create_datetime"));
                order.setUpdateDatetime(rs.getDate("update_datetime"));
            }
            // 关闭资源
            JDBCUtils.closeAll(connection, prepareStatement, rs);
            return order;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

}
