package com.shop.filter;

import com.shop.entity.AdminUser;
import com.shop.entity.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "LoginFilter", urlPatterns = "/*")
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        //1.获取资源请求路径
        String uri = request.getRequestURI();
        
        // 如果是根路径,直接重定向到管理员登录页
        if (uri.equals(request.getContextPath() + "/")) {
            response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
            return;
        }
        
        //2.判断是否包含登录相关资源路径,要注意排除掉 css/js/图片/验证码等资源
        if(uri.equals(request.getContextPath() + "/adminLogin.jsp")
                || uri.equals(request.getContextPath() + "/AdminLoginServlet") 
                || uri.equals(request.getContextPath() + "/GetImgServlet")
                || uri.startsWith(request.getContextPath() + "/css/")
                || uri.startsWith(request.getContextPath() + "/img/")
                || uri.startsWith(request.getContextPath() + "/common/")
                || uri.startsWith(request.getContextPath() + "/js/")
        ){
            //包含，用户就是想登录。放行
            filterChain.doFilter(request, response);
        } else {
            //不包含，需要验证用户是否登录
            //3.从获取session中获取user
            // 查看session中有没有登录用户
            AdminUser loginUser = (AdminUser) request.getSession().getAttribute("loginUser");

            if(loginUser != null){
                //登录了。放行
                filterChain.doFilter(servletRequest, servletResponse);
            }else{
                // 未登录 跳转到管理员登陆页面
                request.getRequestDispatcher("/adminLogin.jsp").forward(request,response);
            }
        }
    }

    @Override
    public void destroy() {
    }
}
