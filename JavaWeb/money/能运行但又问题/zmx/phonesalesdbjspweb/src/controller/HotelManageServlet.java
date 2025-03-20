package controller;


import dao.productDAO;
import dao.productDaolmpl;

import model.Tproduct;

import model.Vorderrrcord;
import utils.DispatcherUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 酒店管理页面数据请求控制器
 */
@WebServlet(name = "HotelManageServlet", value = "/jspviews/hotelmanage.do")
public class HotelManageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(); //获取session对象
        Vorderrrcord loginuser = (Vorderrrcord) session.getAttribute("loginuser"); //获取登录用户
        //获取用户管理的所有酒店信息
        productDAO hdao = new productDaolmpl();
        List<Tproduct> productList = hdao.getProductsByUser(loginuser.getProductname());
        request.setAttribute("productList",productList); //把酒店集合存入内置对象中

        //打开hotelmanage.jsp展示数据
        DispatcherUtils.openWeb("productmanage.jsp",request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
