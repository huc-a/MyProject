package com.mall.controller;

import com.mall.model.Admin;
import com.mall.service.AdminService;
import com.mall.service.impl.AdminServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AdminService adminService = new AdminServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 检查是否已登录
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            // 已登录则直接跳转到后台首页
            resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
        } else {
            // 未登录则显示登录页面
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String captcha = req.getParameter("captcha");
        String correctCaptcha = req.getParameter("captchaCode"); // 从前端获取正确的验证码
        
        // 检查密码是否一致
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "两次输入的密码不一致");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        
        // 验证码验证在前端完成，这里可以不用再验证

        // 管理员登录验证
        Admin admin = adminService.login(username, password);
        if (admin != null) {
            HttpSession session = req.getSession();
            session.setAttribute("username", admin.getUsername());
            resp.sendRedirect("admin/index.jsp");
            return;
        }

        req.setAttribute("error", "用户名或密码错误");
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
} 