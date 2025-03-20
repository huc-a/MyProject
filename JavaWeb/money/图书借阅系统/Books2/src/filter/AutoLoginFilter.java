package filter;
import domain.User;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter(filterName = "AutoLoginFilter",urlPatterns = "/admin/*")
public class AutoLoginFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    public void doFilter(ServletRequest req, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse Response = (HttpServletResponse) response;
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // 获得用户请求的URI
        String path = request.getRequestURI();
        // 登陆页面无需过滤
        if(path.indexOf("/login.jsp") > -1) {
            chain.doFilter(request, response);
            return;
        }
        if(path.indexOf("/register.jsp") > -1) {
            chain.doFilter(request, response);
            return;
        }

        if (user==null) {
            // 放行
            req.setAttribute("error_msg","您还没有登录");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, response);

        }else if(user!=null&&user.getIsadmin()!=1){
            req.setAttribute("error_msg","您是普通用户，没有权限！");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, response);
        }else{
            chain.doFilter(request, response);
        }

    }


    public void destroy() {
    }
}