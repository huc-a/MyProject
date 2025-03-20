package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();

        // 获取请求的URI
        String uri = request.getRequestURI();
        
        // 不需要过滤的URL
        String[] allowedPaths = {
            "/admin/login.jsp",      // 登录页面
            "/LoginServlet",         // 登录处理
            "/admin/register.jsp",   // 注册页面
            "/RegisterServlet",      // 注册处理
            "/css/",                 // 静态资源
            "/js/",
            "/images/",
            "/resource/"
        };

        // 检查是否是允许的路径
        boolean isAllowedPath = false;
        for (String path : allowedPaths) {
            if (uri.contains(path)) {
                isAllowedPath = true;
                break;
            }
        }

        // 如果是允许的路径或者已经登录，则继续
        if (isAllowedPath || session.getAttribute("user") != null) {
            chain.doFilter(request, response);
        } else {
            // 未登录且访问受限页面，重定向到登录页
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
} 