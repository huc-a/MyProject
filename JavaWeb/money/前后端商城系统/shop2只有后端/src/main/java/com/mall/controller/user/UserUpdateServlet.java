package com.mall.controller.user;

import com.mall.model.User;
import com.mall.service.UserService;
import com.mall.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/user/update")
public class UserUpdateServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 设置请求编码
        req.setCharacterEncoding("UTF-8");
        
        // 获取表单数据
        Integer id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        
        // 更新用户信息
        if (userService.updateUser(id, username, password, phone, email)) {
            resp.sendRedirect("list");
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "更新失败");
        }
    }
} 