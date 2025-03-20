package com.example.servlet;

import com.example.bean.User;
import com.example.service.UserService;
import com.example.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user/add")
public class UserAddServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 显示添加用户表单
        req.getRequestDispatcher("/WEB-INF/jsp/user/add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            // 获取表单数据
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String role = req.getParameter("role");

            // 创建用户对象
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setRole(role != null ? role : "user"); // 默认角色为user

            // 保存用户
            userService.addUser(user);

            // 重定向到用户列表
            resp.sendRedirect(req.getContextPath() + "/users");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "添加用户失败：" + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/user/add.jsp").forward(req, resp);
        }
    }
} 