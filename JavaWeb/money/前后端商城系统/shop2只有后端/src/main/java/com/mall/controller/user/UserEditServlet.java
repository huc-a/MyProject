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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/admin/user/edit")
public class UserEditServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        // 查询用户信息
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?")) {
            
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                req.setAttribute("user", user);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        req.getRequestDispatcher("/admin/user/edit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        // 获取表单数据
        String id = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");

        // 直接更新数据库
        String sql = "UPDATE users SET username = ?, email = ?, phone = ?";
        if (password != null && !password.trim().isEmpty()) {
            sql += ", password = ?";
        }
        sql += " WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            int paramIndex = 1;
            pstmt.setString(paramIndex++, username);
            pstmt.setString(paramIndex++, email);
            pstmt.setString(paramIndex++, phone);
            if (password != null && !password.trim().isEmpty()) {
                pstmt.setString(paramIndex++, password);
            }
            pstmt.setInt(paramIndex, Integer.parseInt(id));

            pstmt.executeUpdate();
            
            // 更新成功，重定向到列表页
            resp.sendRedirect("list");
            
        } catch (SQLException e) {
            e.printStackTrace();
            // 更新失败，返回编辑页面
            req.setAttribute("error", "更新失败");
            doGet(req, resp);
        }
    }
} 