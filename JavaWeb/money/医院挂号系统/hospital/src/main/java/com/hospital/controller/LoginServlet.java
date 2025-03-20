package com.hospital.controller;

import com.hospital.model.User;
import com.hospital.service.UserService;
import com.hospital.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        try {
            User user = userService.login(fullName, password);
            if (user != null) {
                if (!user.getUserType().equals(userType)) {
                    String errorMsg = "patient".equals(userType) ? 
                        "医生账号请在医生登录页面登录" : 
                        "病人账号请在病人登录页面登录";
                    request.setAttribute("error", errorMsg);
                    request.getRequestDispatcher("/common/login.jsp").forward(request, response);
                    return;
                }
                
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("username", user.getFullName());
                
                if ("doctor".equals(user.getUserType())) {
                    response.sendRedirect(request.getContextPath() + "/doctor/index.jsp");
                } else if ("patient".equals(user.getUserType())) {
                    response.sendRedirect(request.getContextPath() + "/patient/index.jsp");
                }
            } else {
                request.setAttribute("error", "用户名或密码错误");
                request.getRequestDispatcher("/common/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "系统错误: " + e.getMessage());
            request.getRequestDispatcher("/common/login.jsp").forward(request, response);
        }
    }
} 