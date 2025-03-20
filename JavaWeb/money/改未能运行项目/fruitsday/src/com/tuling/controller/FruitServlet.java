package com.tuling.controller;

import com.tuling.domain.Cart;
import com.tuling.domain.Fruit;
import com.tuling.service.CartService;
import com.tuling.service.FruitService;
import com.tuling.service.impl.CartServiceImpl;
import com.tuling.service.impl.FruitServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/fruitServlet")
public class FruitServlet extends BaseServlet{
    private FruitService fruitService = new FruitServiceImpl();
    private CartService cartService = new CartServiceImpl();

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String info(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int fid=Integer.parseInt(req.getParameter("fid"));
        Fruit fruit = fruitService.findByFid(fid);
        req.setAttribute("fruit",fruit);
        int uid = Integer.parseInt(req.getParameter("uid"));
        if(uid!=0){
            List<Cart> cartList = cartService.showAll(uid);
            for (Cart cart : cartList) {
                if(cart.getFid()==fid){
                    if(cart.isCart()){
                        req.setAttribute("tit1", "已加入购物车");
                    }
                    if(cart.isStar()){
                        req.setAttribute("tit2", "已关注");
                    }
                    break;
                }
            }
        }
        hot(req,resp);
        //转发
        return "forward:/fruit_info.jsp";

    }

    public void hot(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        List<Fruit> hot = fruitService.findHot();
        req.setAttribute("fruits",hot);
    }
}
