package com.shop.servlet.order;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.Order;
import com.shop.entity.OrderDetails;
import com.shop.entity.ShopCar;
import com.shop.entity.User;
import com.shop.service.OrderDetailsService;
import com.shop.service.OrderService;
import com.shop.service.ShopCarService;
import com.shop.util.DateUtil;

/**
 * 添加订单Servlet
 */
@WebServlet("/OrderAddServlet")
public class OrderAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private OrderService orderService = new OrderService();
    private ShopCarService shopCarService = new ShopCarService();
    private OrderDetailsService orderDetailsService = new OrderDetailsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = UUID.randomUUID().toString().replace("-", "");
        User loginCust = (User) request.getSession().getAttribute("loginCust");

        List<ShopCar> shopCars = shopCarService.getAllShopCar(loginCust.getPhone());
        BigDecimal sum = new BigDecimal(0);
        for (ShopCar item: shopCars) {
            sum = sum.add(item.getGoodsInfo().getPrice().multiply(new BigDecimal(item.getCount())));
        }

        // 创建订单对象
        Order order = new Order();
        // 把信息添加到对象中
        order.setId(id);
        order.setUserPhone(loginCust.getPhone());
        order.setTotalPrice(sum);
        order.setCreateDatetime(new Date());

        // 执行添加操作
        int add = orderService.add(order);

        if (add > 0) {  // 成功
            request.setAttribute("successMsg", "添加成功");
            OrderDetails orderDetails = null;
            for (ShopCar sc: shopCars) {
                // 新增一条订单-商品记录
                orderDetails = new OrderDetails();
                orderDetails.setOrderId(order.getId());
                orderDetails.setGoodsId(sc.getGoodsId());
                orderDetails.setCount(sc.getCount());
                orderDetails.setSubTotal(sc.getGoodsInfo().getPrice().multiply(new BigDecimal(sc.getCount())));
                orderDetailsService.add(orderDetails);
                // 删除该条购物车数据
                shopCarService.delete(sc.getId());
            }
        } else {  // 失败
            request.setAttribute("errorMsg", "添加失败");
        }
        request.getRequestDispatcher("shopCarList.jsp").forward(request, response);

    }

}
