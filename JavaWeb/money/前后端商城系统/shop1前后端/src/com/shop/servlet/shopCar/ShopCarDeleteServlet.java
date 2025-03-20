package com.shop.servlet.shopCar;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.Goods;
import com.shop.entity.ShopCar;
import com.shop.service.GoodsService;
import com.shop.service.ShopCarService;

/**
 * 删除用户Servlet
 */
@WebServlet("/ShopCarDeleteServlet")
public class ShopCarDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private ShopCarService shopCarService = new ShopCarService();
    private GoodsService goodsService = new GoodsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取登录信息
        Integer id = Integer.valueOf(request.getParameter("id"));
        ShopCar shopCar = shopCarService.getShopCarById(id);
        // 更新商品库存
        Goods goods = goodsService.getGoodsById(shopCar.getGoodsId());
        goods.setStock(goods.getStock() + shopCar.getCount());
        goodsService.update(goods);
        // 删除
        shopCarService.delete(id);
        // 跳转到用户列表页
        response.sendRedirect("shopCarList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
