package com.tuling.controller;

import com.tuling.domain.Cart;
import com.tuling.domain.Fruit;
import com.tuling.domain.User;
import com.tuling.service.CartService;
import com.tuling.service.impl.CartServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/cartServlet")
public class CartServlet extends BaseServlet{
    private CartService cartService = new CartServiceImpl();
    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String del(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        Cart cart=new Cart();
        int uid=Integer.parseInt(req.getParameter("uid"));
        int fid = Integer.parseInt(req.getParameter("fid"));
        cart.setFid(fid);
        cart.setFid(fid);
        String str = req.getParameter("str");
        if(uid!=0){
            Cart resultCart = cartService.find(uid, fid);
            if(str.equals("cart")){
                cart.setIsCart(false);
                cart.setIsStar(resultCart.isStar());
            }else{
                cart.setIsStar(false);
                cart.setIsCart(resultCart.isCart());
            }
            //倘若加入了购物车，或者被关注了
            if(cart.isCart()||cart.isStar())
            {//更新
                cartService.update(uid, cart);
            }
            else
            {//删除
                cartService.del(uid,cart.getFid());
            }
        }

        if(str.equals("cart")){
            return "forward:/cartServlet?method=show&uid="+uid+"&boob=cart";
        }else{
            return "forward:/cartServlet?method=show&uid="+uid+"&boob=star";
        }

    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String show(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        int uid=Integer.parseInt(req.getParameter("uid"));
        String boob=req.getParameter("boob");
        //
        boolean flag =false;
        if(boob.equals("cart")){
            flag=true;
        }
        if(uid!=0){
            List<Fruit> fruits = cartService.show(uid, flag);
            req.setAttribute("fruits",fruits);
            if(flag){
                return "forward:/showcart.jsp";
            }else{
                return "forward:/showstar.jsp";
            }
        }else{
            //跳转到登录页面,提示用户登录
            req.setAttribute("showError",true);
            return "forward:/login.jsp";
        }

    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        Cart cart=new Cart();
        int uid = Integer.parseInt(req.getParameter("uid"));
        int fid = Integer.parseInt(req.getParameter("fid"));
        cart.setFid(fid);
        if(uid!=0){
            String str = req.getParameter("str");
            Cart resultCart = cartService.find(uid, fid);
            if(resultCart==null){
                if (str.equals("cart")) {
                    cart.setIsStar(false);
                    cart.setIsCart(true);
                } else {
                    cart.setIsStar(true);
                    cart.setIsCart(false);
                }
                cartService.add(uid,cart);//添加
            }else{
                if(str.equals("cart"))
                {
                    cart.setIsCart(true);
                    cart.setIsStar(resultCart.isStar());
                }
                else
                {
                    cart.setIsStar(true);
                    cart.setIsCart(resultCart.isCart());
                }
                cartService.update(uid,cart);
            }
            return "forward:"+"/fruitServlet?method=info&uid="+uid+"&fid="+cart.getFid();
        }else{
            //跳转到登录页面,提示用户登录
            req.setAttribute("showError",true);
            return "forward:/login.jsp";
        }


    }

    /**
     *
     * @param req
     * @param resp
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public void num(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        int num=0;
        HttpSession session=req.getSession();
        if(session.getAttribute("user")!=null) {
            User user = (User) session.getAttribute("user");
            List<Fruit> fruits = cartService.show(user.getId(), true);
            num = fruits.size();
        }
        req.setAttribute("num",num);
    }

}
