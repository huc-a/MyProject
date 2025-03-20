package com.shop.service;

import java.util.List;
import com.shop.entity.Order;

import com.shop.dao.OrderDao;

/**
 * 订单业务处理类
 */
public class OrderService {

    // 创建数据库操作对象
    private OrderDao orderDao = new OrderDao();

    /**
     * 添加订单
     * @param order
     * @return
     */
    public int add(Order order) {
        return orderDao.add(order);
    }

    /**
     * 删除订单
     * @param id
     * @return
     */
    public int delete(String id) {
        return orderDao.delete(id);
    }

    /**
     * 更新订单
     * @param order
     * @return
     */
    public int update(Order order) {
        return orderDao.update(order);
    }

    /**
     * 获取订单
     * @return
     */
    public List<Order> getAllOrder(String userPhone) {
        return orderDao.getAllOrder(userPhone);
    }

    /**
     * 根据id获取订单详情
     * @param id
     * @return
     */
    public Order getOrderById(String id) {
        return orderDao.getOrderById(id);
    }
}
