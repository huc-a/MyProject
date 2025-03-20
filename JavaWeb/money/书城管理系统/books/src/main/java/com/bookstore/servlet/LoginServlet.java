package com.bookstore.servlet;

import com.bookstore.dao.AdminUserDAO;
import com.bookstore.model.AdminUser;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AdminUserDAO adminUserDAO = new AdminUserDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 如果已经登录，重定向到图书列表页面
        HttpSession session = req.getSession();
        if (session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/book/list");
            return;
        }
        // 否则转发到登录页面
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String captcha = req.getParameter("captcha");
        
        // 验证验证码
        HttpSession session = req.getSession();
        String correctCaptcha = (String) session.getAttribute("captcha");
        // 验证后立即删除session中的验证码，防止重复使用
        session.removeAttribute("captcha");
        
        if (correctCaptcha == null || !correctCaptcha.equals(captcha)) {
            req.setAttribute("errorMessage", "验证码错误");
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }
        
        // 从数据库验证用户
        AdminUser user = adminUserDAO.findByUsername(username);
        
        if (user != null && password.equals(user.getPassword())) {
            // 登录成功，将用户信息存入session
            // 出于安全考虑，清除密码信息
            user.setPassword(null);
            session.setAttribute("user", user);
            // 重定向到管理后台首页
            resp.sendRedirect(req.getContextPath() + "/jsp/admin/index.jsp");
        } else {
            // 登录失败，返回登录页面并显示错误信息
            req.setAttribute("errorMessage", "用户名或密码错误");
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
        }
    }
} 