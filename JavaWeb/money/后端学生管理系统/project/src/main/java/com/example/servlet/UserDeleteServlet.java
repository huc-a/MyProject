package com.example.servlet;

import com.example.service.UserService;
import com.example.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/user/delete")
public class UserDeleteServlet extends HttpServlet {
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

            // 删除用户
            Integer id = Integer.parseInt(idStr);
            userService.deleteUser(id);

            // 重定向到用户列表
            resp.sendRedirect(req.getContextPath() + "/users");
        } catch (Exception e) {
            e.printStackTrace();
            // 设置错误消息并重定向到列表页
            req.getSession().setAttribute("error", "删除用户失败：" + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/users");
        }
    }
} 