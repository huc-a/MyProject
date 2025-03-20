package com.shop.servlet.goods;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.entity.Goods;
import com.shop.service.GoodsService;

/**
 * 删除用户Servlet
 */
@WebServlet("/GoodsDeleteServlet")
public class GoodsDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 创建业务处理类对象
    private GoodsService goodsService = new GoodsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 在request中获取登录信息
        String id = request.getParameter("id");

        // 删除
        Goods goods = goodsService.getGoodsById(id);

        goods.setIsDelete("1");
        goods.setUpdateDatetime(new Date());

        goodsService.update(goods);

        // 跳转到用户列表页
        response.sendRedirect("goodsList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
