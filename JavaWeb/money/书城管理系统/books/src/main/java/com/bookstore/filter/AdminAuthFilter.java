package com.bookstore.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/jsp/admin/*")
public class AdminAuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        // 检查用户是否已登录
        if (session == null || session.getAttribute("user") == null) {
            // 未登录，重定向到登录页面
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }
        
        // 已登录，继续处理请求
        chain.doFilter(request, response);
    }
} 