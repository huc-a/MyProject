package com.bookstore.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 获取session并使其失效
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        // 重定向到登录页面
        resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
    }
} 