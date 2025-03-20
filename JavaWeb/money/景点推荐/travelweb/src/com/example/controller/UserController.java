package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import com.example.dao.UserDao;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UserController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        UserDao userDao = new com.example.dao.UserDaoImpl();// 创建 UserDao 实例
        userService = new UserService(userDao); // 传递 UserDao 实例
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            handleLogout(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userService.login(username, password);
        
        if (user != null) {
            // 登录成功，将用户信息存入session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // 根据用户角色重定向到不同页面
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/index.jsp");
                return;
            } else {
                // 普通用户重定向到首页
                response.sendRedirect("index.jsp");
            }
        } else {
            // 登录失败，重定向回登录页面并显示错误信息
            response.sendRedirect("login.jsp?error=true");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (!password.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + 
                "/login.jsp?error=password_mismatch#register");
            return;
        }
        
        try {
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password);
            newUser.setRole("user"); // 默认注册为普通用户
            
            userService.register(newUser);
            response.sendRedirect(request.getContextPath() + "/login.jsp?register=success");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + 
                "/login.jsp?error=register_failed#register");
        }
    }
}
