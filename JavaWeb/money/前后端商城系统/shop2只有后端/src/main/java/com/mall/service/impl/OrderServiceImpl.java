package com.mall.service.impl;

import com.mall.dao.OrderDao;
import com.mall.dao.impl.OrderDaoImpl;
import com.mall.model.Order;
import com.mall.model.OrderItem;
import com.mall.service.OrderService;
import java.util.List;

public class OrderServiceImpl implements OrderService {
    private OrderDao orderDao = new OrderDaoImpl();

    @Override
    public List<Order> getAllOrders() {
        return orderDao.findAll();
    }

    @Override
    public Order getOrderById(Integer id) {
        return orderDao.findById(id);
    }

    @Override
    public Order getOrderByOrderNo(String orderNo) {
        return orderDao.findByOrderNo(orderNo);
    }

    @Override
    public boolean updateOrderStatus(Integer id, Integer status) {
        return orderDao.updateStatus(id, status);
    }

    @Override
    public List<Order> searchOrders(String keyword) {
        return orderDao.search(keyword);
    }

    @Override
    public List<OrderItem> getOrderItems(Integer orderId) {
        return orderDao.findOrderItems(orderId);
    }
} 