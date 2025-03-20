package com.shop.servlet.orderDetails;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.service.OrderDetailsService;

/**
 * 删除用户Servlet
 */
@WebServlet("/OrderDetailsDeleteServlet")
public class OrderDetailsDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private OrderDetailsService orderDetailsService = new OrderDetailsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取登录信息
        String orderId = request.getParameter("orderId");

        // 删除
        orderDetailsService.delete(orderId);

        // 跳转到用户列表页
        response.sendRedirect("orderDetailsList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
