package com.mall.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("")  // 匹配根路径 "/"
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 检查是否已登录
        Object username = req.getSession().getAttribute("username");
        if (username != null) {
            // 已登录则跳转到后台首页
            resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
        } else {
            // 未登录则跳转到登录页
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        doGet(req, resp);
    }
} 