package com.mall.controller.order;

import com.mall.model.Order;
import com.mall.model.OrderItem;
import com.mall.service.OrderService;
import com.mall.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order/detail")
public class OrderDetailServlet extends HttpServlet {
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String orderNo = req.getParameter("orderNo");
        Order order = orderService.getOrderByOrderNo(orderNo);
        
        if (order != null) {
            List<OrderItem> items = orderService.getOrderItems(order.getId());
            req.setAttribute("order", order);
            req.setAttribute("items", items);
            req.getRequestDispatcher("/admin/order/detail.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "订单不存在");
        }
    }
} 