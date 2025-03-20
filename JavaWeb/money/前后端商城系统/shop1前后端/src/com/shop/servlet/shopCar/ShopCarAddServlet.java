package com.shop.servlet.shopCar;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.Goods;
import com.shop.entity.ShopCar;
import com.shop.entity.User;
import com.shop.service.GoodsService;
import com.shop.service.ShopCarService;
import com.shop.service.UserService;
import com.shop.util.DateUtil;

/**
 * 添加购物车Servlet
 */
@WebServlet("/ShopCarAddServlet")
public class ShopCarAddServlet extends HttpServlet {

    // 创建业务处理类对象
    private ShopCarService shopCarService = new ShopCarService();
    private GoodsService goodsService = new GoodsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取购物车信息
        String goodsId = request.getParameter("goodsId");
        User user = (User) request.getSession().getAttribute("loginCust");
        // 查询数据库中是否存在购物车数据 没有则新增 有则更新数量
        ShopCar shopCar = shopCarService.getShopCarByUserAndGoodsId(user.getPhone(), goodsId);

        Goods goods = goodsService.getGoodsById(goodsId);
        goods.setUpdateDatetime(new Date());
        if (shopCar == null) {
            shopCar = new ShopCar();
            // 把信息添加到对象中
            shopCar.setGoodsId(goodsId);
            shopCar.setCount(1);
            shopCar.setCreateUser(user.getPhone());
            shopCar.setCreateDatetime(new Date());
            // 执行添加操作
            int add = shopCarService.add(shopCar);

            if (add > 0) {  // 成功
                request.setAttribute("successMsg", "添加成功");
                goods.setStock(goods.getStock() - 1);
                goodsService.update(goods);
            } else {  // 失败
                request.setAttribute("errorMsg", "添加失败");
            }
        } else {
            shopCar.setCount(shopCar.getCount() + 1);
            int update = shopCarService.update(shopCar);
            if (update > 0) {
                request.setAttribute("successMsg", "添加成功");
                goods.setStock(goods.getStock() - 1);
                goodsService.update(goods);
            } else {  // 失败
                request.setAttribute("errorMsg", "添加失败");
            }
        }
        request.getRequestDispatcher("userIndex.jsp").forward(request, response);
    }

}
