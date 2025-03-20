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
import com.shop.service.GoodsService;
import com.shop.service.ShopCarService;
import com.shop.util.DateUtil;

/**
 * 更新购物车Servlet
 */
@WebServlet("/ShopCarUpdateServlet")
public class ShopCarUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        Integer id = Integer.valueOf(request.getParameter("id"));
        String flag = request.getParameter("flag");

        Goods goods = goodsService.getGoodsById(shopCarService.getShopCarById(id).getGoodsId());
        // 创建购物车对象
        ShopCar shopCar = new ShopCar();
        if (flag.equals("add")) {
            shopCar.setId(id);
            shopCar.setCount(shopCarService.getShopCarById(id).getCount() + 1);
            goods.setStock(goods.getStock() - 1);
        } else {
            shopCar.setId(id);
            shopCar.setCount(shopCarService.getShopCarById(id).getCount() - 1);
            goods.setStock(goods.getStock() + 1);
        }
        // 判断购物车数量是否为0 为0直接将记录删除
        if (shopCar.getCount() != 0) {
            // 执行更新操作
            int update = shopCarService.update(shopCar);
            if (update > 0) {  // 成功
                request.setAttribute("successMsg", "更新成功");

            } else {  // 失败
                request.setAttribute("errorMsg", "更新失败");
            }
        } else {
            shopCarService.delete(id);
        }
        goodsService.update(goods);
        request.getRequestDispatcher("shopCarList.jsp").forward(request, response);

    }

}
