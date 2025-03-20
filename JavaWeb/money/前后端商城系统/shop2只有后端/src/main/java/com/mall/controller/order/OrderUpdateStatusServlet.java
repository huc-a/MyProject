package com.mall.controller.order;

import com.mall.service.OrderService;
import com.mall.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/order/updateStatus")
public class OrderUpdateStatusServlet extends HttpServlet {
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        Integer status = Integer.parseInt(req.getParameter("status"));
        
        if (orderService.updateOrderStatus(id, status)) {
            resp.sendRedirect("list");
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "更新订单状态失败");
        }
    }
} 