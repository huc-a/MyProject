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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AddUserServlet",urlPatterns = "/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    private UsersDao usersDao = new UsersDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 设置编码
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            
            // 获取表单数据
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String birthdayStr = request.getParameter("birthday");
            int isadmin = Integer.parseInt(request.getParameter("isadmin"));
            
            // 获取来源页面
            String referer = request.getHeader("Referer");
            boolean isFromRegister = referer != null && referer.contains("register.jsp");
            
            // 获取最大ID并加1
            int newId = usersDao.getMaxId() + 1;
            
            // 创建User对象
            User user = new User();
            user.setId(newId);
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            
            // 转换日期格式
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            user.setBirthday(sdf.parse(birthdayStr));
            user.setIsadmin(isadmin);
            
            // 添加用户
            boolean success = usersDao.insert(user);
            
            if (success) {
                if (isFromRegister) {
                    // 如果是从注册页面来的，设置成功消息并输出跳转脚本
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script type='text/javascript'>");
                    out.println("alert('注册成功！');");
                    out.println("window.location.href='admin/login.jsp';");
                    out.println("</script>");
                } else {
                    // 如果是从管理页面来的
                    response.sendRedirect("/IndexUserServlet");
                }
            } else {
                if (isFromRegister) {
                    request.setAttribute("error_msg", "注册失败，请重试");
                    request.getRequestDispatcher("admin/register.jsp").forward(request, response);
                } else {
                    response.getWriter().write("添加用户失败");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("操作失败：" + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}






