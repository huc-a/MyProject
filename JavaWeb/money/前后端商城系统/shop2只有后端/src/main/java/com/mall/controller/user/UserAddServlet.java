package com.mall.controller.user;

import com.mall.model.User;
import com.mall.utils.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/admin/user/add")
public class UserAddServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 显示添加用户页面
        req.getRequestDispatcher("/admin/user/add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置请求编码
        req.setCharacterEncoding("UTF-8");
        
        // 获取表单数据
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");

        // 直接插入数据库
        String sql = "INSERT INTO users (username, password, email, phone, create_time) VALUES (?, ?, ?, ?, NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);

            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
                // 添加成功，重定向到用户列表
                resp.sendRedirect("list");
            } else {
                // 添加失败，返回添加页面
                req.setAttribute("error", "添加用户失败");
                req.getRequestDispatcher("/admin/user/add.jsp").forward(req, resp);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            // 添加失败，返回添加页面
            req.setAttribute("error", "添加用户失败: " + e.getMessage());
            req.getRequestDispatcher("/admin/user/add.jsp").forward(req, resp);
        }
    }
} 