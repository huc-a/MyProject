package com.mall.dao;

import com.mall.model.Order;
import com.mall.model.OrderItem;
import java.util.List;

public interface OrderDao {
    List<Order> findAll();
    Order findById(Integer id);
    Order findByOrderNo(String orderNo);
    boolean updateStatus(Integer id, Integer status);
    List<Order> search(String keyword);
    List<OrderItem> findOrderItems(Integer orderId);
} 