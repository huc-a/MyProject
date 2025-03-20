package servlet;
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
@WebServlet(name = "LoginServlet",urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response)throws ServletException, IOException {
        //设置请求编码、响应方式和编码方式
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        PreparedStatement ptst = null;
        //获取登录页面提交的数据
        String loginName = request.getParameter("username");
        String loginPassword = request.getParameter("password");
        //sql语句
        String selectUsername = "select name from users";
        String selectPassword = "select * from users where name = ?";
        try {
            //获取与数据库的链接
            conn = new JDBCUtils().getConnection();
            //遍历user表，将数据库中所有username存入集合中
            st = conn.createStatement();
            rs = st.executeQuery(selectUsername);
            List<String> usernameList = new ArrayList<String>();
            while (rs.next()) {
                usernameList.add(rs.getString(1));
            }
            //关闭连接
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
            //判断集合中是否存在所要登录的username
            if (usernameList.contains(loginName)) {
                //查找username对应的password
                List<User> passwordList = new ArrayList<User>();
                ptst = (PreparedStatement)
                        conn.prepareStatement(selectPassword);
                //设置ptst参数
                ptst.setString(1, loginName);
                rs = ptst.executeQuery();
                while (rs.next()) {
                    User u1 = new User();
                    u1.setId(rs.getInt(1));
                    u1.setUsername(rs.getString(2));
                    u1.setPassword(rs.getString(3));
                    u1.setEmail(rs.getString(4));
                    u1.setBirthday(rs.getDate(5));
                    u1.setIsadmin(rs.getInt(6));
                    passwordList.add(u1);
                }
                //跳转后刷新页面
                long timestamp = System.currentTimeMillis();
                String queryString = "?t=" + timestamp;
                String url="/admin/MangeIndex.jsp";
                //判断数据库与登录页面提交的password是否一致
                if (passwordList.get(0).getPassword().equals(loginPassword)) {
                    //out.println("欢迎登录。");

                    //将用户放到session
                    HttpSession session = request.getSession();
                    session.setAttribute("user",passwordList.get(0));
                    response.sendRedirect(url+queryString);

                } else {
                    //out.println("密码错误，请重新输入。");
                    //跳转回登录界面login.jsp
                    response.sendRedirect(url+queryString);

                }
                if (rs != null) {
                    rs.close();
                }
                if (ptst != null) {
                    ptst.close();
                }
            } else {
                out.println("用户名不存在");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            //关闭链接
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        out.flush();
        out.close();
    }
}
