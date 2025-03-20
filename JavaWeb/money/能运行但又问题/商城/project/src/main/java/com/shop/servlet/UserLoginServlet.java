package com.shop.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.dao.UserDAO;
import com.shop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/user/login")
public class UserLoginServlet extends HttpServlet {
    private ObjectMapper objectMapper = new ObjectMapper();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> result = new HashMap<>();

        try {
            LoginRequest loginRequest = objectMapper.readValue(request.getReader(), LoginRequest.class);
            
            // 直接使用明文密码验证
            String username = loginRequest.getUsername();
            String password = loginRequest.getPassword();
            
            User user = userDAO.findByUsername(username);
            
            if (user != null && user.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                result.put("success", true);
                result.put("message", "登录成功");
                result.put("user", new UserDTO(user));
            } else {
                result.put("success", false);
                result.put("message", "用户名或密码错误");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "登录失败：" + e.getMessage());
        }

        objectMapper.writeValue(response.getWriter(), result);
    }

    // 内部类用于请求体反序列化
    private static class LoginRequest {
        private String username;
        private String password;

        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }

    // 用户DTO，用于返回给前端的用户信息（去除敏感信息）
    private static class UserDTO {
        private int userId;
        private String username;
        private String email;

        public UserDTO(User user) {
            this.userId = user.getUserId();
            this.username = user.getUsername();
            this.email = user.getEmail();
        }

        public int getUserId() { return userId; }
        public String getUsername() { return username; }
        public String getEmail() { return email; }
    }
} 