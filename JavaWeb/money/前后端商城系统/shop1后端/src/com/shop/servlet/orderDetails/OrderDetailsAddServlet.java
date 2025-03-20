package com.shop.servlet.orderDetails;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.OrderDetails;
import com.shop.service.OrderDetailsService;
import com.shop.util.DateUtil;

/**
 * 添加订单详情Servlet
 */
@WebServlet("/OrderDetailsAddServlet")
public class OrderDetailsAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private OrderDetailsService orderDetailsService = new OrderDetailsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取订单详情信息
        String orderId = request.getParameter("orderId");
        String goodsId = request.getParameter("goodsId");
        Integer count = Integer.valueOf(request.getParameter("count"));
        BigDecimal subTotal = new BigDecimal(request.getParameter("subTotal"));

        // 创建订单详情对象
        OrderDetails orderDetails = new OrderDetails();
        // 把信息添加到对象中
        orderDetails.setOrderId(orderId);
        orderDetails.setGoodsId(goodsId);
        orderDetails.setCount(count);
        orderDetails.setSubTotal(subTotal);

        // 执行添加操作
        int add = orderDetailsService.add(orderDetails);

        if (add > 0) {  // 成功
            request.setAttribute("successMsg", "添加成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "添加失败");
            request.setAttribute("orderDetails", orderDetails);
        }
        request.getRequestDispatcher("orderDetailsAdd.jsp").forward(request, response);

    }

}
