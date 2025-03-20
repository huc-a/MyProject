package com.example.servlet;

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
        // 获取当前会话
        HttpSession session = req.getSession(false);
        
        if (session != null) {
            // 清除所有session属性
            session.invalidate();
        }
        
        // 添加退出成功的消息
        req.getSession().setAttribute("message", "退出登录成功！");
        
        // 重定向到登录页面
        resp.sendRedirect(req.getContextPath() + "/login");
    }
} 