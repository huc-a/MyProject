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
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response)throws ServletException, IOException {
        //设置请求编码、响应方式和编码方式
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String  date = request.getParameter("birthday");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = null;
        try {
             date1 = format.parse(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int isadmin = Integer.parseInt(request.getParameter("isadmin"));
        User u1 = new User();
        u1.setUsername(username);
        u1.setPassword(password);
        u1.setEmail(email);
        u1.setBirthday(date1);
        u1.setIsadmin(isadmin);
        UsersDao usersDao = new UsersDao();
        boolean flag = usersDao.insert(u1);
        if(flag){
            // 重定向到成功页面，
            response.sendRedirect("/IndexUserServlet");
            //response.sendRedirect("admin/UserMange.jsp");
            }else {
            response.getWriter().println("添加失败");
                    //response.sendRedirect("admin/UserMange.jsp");
                }
            }
        }






