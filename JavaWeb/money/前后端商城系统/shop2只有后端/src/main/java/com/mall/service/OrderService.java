package com.mall.service;

import com.mall.model.Order;
import com.mall.model.OrderItem;
import java.util.List;

public interface OrderService {
    List<Order> getAllOrders();
    Order getOrderById(Integer id);
    Order getOrderByOrderNo(String orderNo);
    boolean updateOrderStatus(Integer id, Integer status);
    List<Order> searchOrders(String keyword);
    List<OrderItem> getOrderItems(Integer orderId);
} 