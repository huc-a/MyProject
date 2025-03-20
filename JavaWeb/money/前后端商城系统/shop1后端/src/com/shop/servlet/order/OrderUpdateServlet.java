package com.shop.servlet.order;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.Order;
import com.shop.service.OrderService;
import com.shop.util.DateUtil;

/**
 * 更新订单Servlet
 */
@WebServlet("/OrderUpdateServlet")
public class OrderUpdateServlet extends HttpServlet {
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
        String userPhone = request.getParameter("userPhone");
        BigDecimal totalPrice = new BigDecimal(request.getParameter("totalPrice"));
        Date issueDatetime = DateUtil.parseYYYYMMDDHHMMSS(request.getParameter("issueDatetime"));
        Date receivedDatetime = DateUtil.parseYYYYMMDDHHMMSS(request.getParameter("receivedDatetime"));
        Date createDatetime = DateUtil.parseYYYYMMDDHHMMSS(request.getParameter("createDatetime"));
        Date updateDatetime = DateUtil.parseYYYYMMDDHHMMSS(request.getParameter("updateDatetime"));

        // 创建订单对象
        Order order = new Order();
        // 把信息添加到对象中
        order.setId(id);
        order.setUserPhone(userPhone);
        order.setTotalPrice(totalPrice);
        order.setIssueDatetime(issueDatetime);
        order.setReceivedDatetime(receivedDatetime);
        order.setCreateDatetime(createDatetime);
        order.setUpdateDatetime(updateDatetime);

        // 执行更新操作
        int update = orderService.update(order);

        if (update > 0) {  // 成功
            request.setAttribute("successMsg", "更新成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "更新失败");
            request.setAttribute("order", order);
        }
        request.getRequestDispatcher("orderUpdate.jsp").forward(request, response);

    }

}
