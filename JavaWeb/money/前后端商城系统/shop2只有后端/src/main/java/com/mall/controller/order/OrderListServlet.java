package com.mall.controller.order;

import com.mall.model.Order;
import com.mall.service.OrderService;
import com.mall.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order/list")
public class OrderListServlet extends HttpServlet {
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        
        List<Order> orders;
        if (keyword != null && !keyword.trim().isEmpty()) {
            orders = orderService.searchOrders(keyword);
        } else {
            orders = orderService.getAllOrders();
        }
        
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/admin/order/list.jsp").forward(req, resp);
    }
} 