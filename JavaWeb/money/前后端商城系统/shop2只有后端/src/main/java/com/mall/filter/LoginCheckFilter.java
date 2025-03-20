package com.mall.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class LoginCheckFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        String requestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        
        // 允许访问的资源
        boolean isPublicResource = requestURI.equals(contextPath + "/login") ||
                                 requestURI.equals(contextPath + "/login.jsp") ||
                                 requestURI.contains("/static/");
        
        if (isPublicResource || (session != null && session.getAttribute("username") != null)) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(contextPath + "/login");
        }
    }

    @Override
    public void destroy() {
    }
} 