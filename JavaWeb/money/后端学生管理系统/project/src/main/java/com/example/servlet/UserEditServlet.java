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

@WebServlet("/user/edit")
public class UserEditServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            // 获取用户ID
            String idStr = req.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "用户ID不能为空");
                return;
            }

            Integer id = Integer.parseInt(idStr);
            User user = userService.getUserById(id);
            
            if (user == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "用户不存在");
                return;
            }

            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/jsp/user/edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "系统错误");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            // 获取表单数据
            String idStr = req.getParameter("id");
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String role = req.getParameter("role");

            // 数据验证
            if (idStr == null || idStr.trim().isEmpty()) {
                throw new IllegalArgumentException("用户ID不能为空");
            }

            // 创建用户对象
            User user = new User();
            user.setId(Integer.parseInt(idStr));
            user.setUsername(username);
            user.setPassword(password);
            user.setRole(role != null ? role : "user"); // 默认角色为user

            // 更新用户
            userService.updateUser(user);

            // 重定向到用户列表
            resp.sendRedirect(req.getContextPath() + "/users");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "更新用户失败：" + e.getMessage());
            doGet(req, resp);
        }
    }
} 