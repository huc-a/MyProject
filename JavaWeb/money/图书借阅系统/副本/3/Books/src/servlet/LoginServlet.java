package servlet;
import dao.UsersDao;
import domain.User;
import util.JDBCUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        UsersDao usersDao = new UsersDao();
        List<User> list = usersDao.findAll();
        
        for (User user : list) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                // 验证用户类型
                if (("admin".equals(userType) && user.getIsadmin() == 1) || 
                    ("user".equals(userType) && user.getIsadmin() == 0)) {
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    
                    // 根据用户类型跳转到不同页面
                    if (user.getIsadmin() == 1) {
                        response.sendRedirect("admin/MangeIndex.jsp");
                    } else {
                        response.sendRedirect("/IndexBookServletForUser");
                    }
                    return;
                }
            }
        }
        
        // 登录失败
        request.setAttribute("error_msg", "用户名、密码或用户类型错误");
        request.getRequestDispatcher("admin/login.jsp").forward(request, response);
    }
}
