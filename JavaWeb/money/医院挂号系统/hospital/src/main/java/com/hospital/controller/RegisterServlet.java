package com.hospital.controller;

import com.hospital.model.User;
import com.hospital.service.UserService;
import com.hospital.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 获取注册信息
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String userType = request.getParameter("userType");
        String idCardNumber = request.getParameter("idCardNumber");
        
        try {
            // 创建用户对象
            User user = new User();
            user.setPhone(phone);
            user.setPassword(password);
            user.setFullName(fullName);
            user.setUserType(userType);
            user.setIdCardNumber(idCardNumber);
            
            // 尝试注册
            userService.register(user);
            
            // 注册成功，重定向到登录页
            response.sendRedirect(request.getContextPath() + "/common/login.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/common/register.jsp").forward(request, response);
        }
    }
} 