package com.shop.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * 编码过滤器
 */
@WebFilter(filterName = "EncoderFilter",urlPatterns = "/*")
public class EncoderFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // ServletRequest 强转成 HttpServletRequest
        HttpServletRequest request = (HttpServletRequest) servletRequest;

        // 设置请求编码
        servletRequest.setCharacterEncoding("UTF-8");
        servletRequest.setCharacterEncoding("utf-8");

        if (request.getRequestURI().endsWith(".jsp")) {
            // 设置响应类型
            servletResponse.setContentType("text/html;charset=UTF-8");
        }

        // 过滤传递
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
    }
}
