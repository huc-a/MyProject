package com.shop.servlet.order;

import com.shop.entity.Order;
import com.shop.service.OrderService;
import com.shop.util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 发货Servlet
 */
@WebServlet("/DeliverGoodsServlet")
public class DeliverGoodsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取订单信息
        String id = request.getParameter("id");
        // 创建订单对象
        Order order = orderService.getOrderById(id);
        order.setIssueDatetime(new Date());
        order.setUpdateDatetime(new Date());
        // 执行更新操作
        int update = orderService.update(order);

        if (update > 0) {  // 成功
            request.setAttribute("successMsg", "发货成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "发货失败");
        }
        request.getRequestDispatcher("orderList.jsp").forward(request, response);
    }

}
