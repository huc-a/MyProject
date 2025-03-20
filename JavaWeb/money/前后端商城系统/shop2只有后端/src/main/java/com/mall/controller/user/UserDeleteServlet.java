package com.mall.controller.user;

import com.mall.service.UserService;
import com.mall.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/user/delete")
public class UserDeleteServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null && !id.trim().isEmpty()) {
            if (userService.deleteUser(Integer.parseInt(id))) {
                resp.sendRedirect("list");
                return;
            }
        }
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "删除失败");
    }
} 