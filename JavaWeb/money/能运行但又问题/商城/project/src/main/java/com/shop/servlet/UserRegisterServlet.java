package com.shop.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.dao.UserDAO;
import com.shop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/user/register")
public class UserRegisterServlet extends HttpServlet {
    private ObjectMapper objectMapper = new ObjectMapper();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> result = new HashMap<>();

        try {
            // 读取请求数据
            RegisterRequest registerRequest = objectMapper.readValue(request.getReader(), RegisterRequest.class);
            
            // 检查用户名是否已存在
            if (userDAO.findByUsername(registerRequest.getUsername()) != null) {
                result.put("success", false);
                result.put("message", "用户名已存在");
                objectMapper.writeValue(response.getWriter(), result);
                return;
            }

            // 创建新用户
            User user = new User();
            user.setUsername(registerRequest.getUsername());
            user.setPassword(registerRequest.getPassword());
            user.setEmail(registerRequest.getEmail());
            user.setPhone(registerRequest.getPhone());
            user.setAddress(registerRequest.getAddress());

            // 保存用户
            boolean success = userDAO.save(user);
            
            if (success) {
                result.put("success", true);
                result.put("message", "注册成功");
            } else {
                result.put("success", false);
                result.put("message", "注册失败");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "注册失败：" + e.getMessage());
        }

        objectMapper.writeValue(response.getWriter(), result);
    }

    // 用于接收注册请求的内部类
    private static class RegisterRequest {
        private String username;
        private String password;
        private String email;
        private String phone;
        private String address;

        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }
    }
} 