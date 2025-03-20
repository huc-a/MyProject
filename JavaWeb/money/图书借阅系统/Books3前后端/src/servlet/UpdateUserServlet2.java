package servlet;
import dao.UsersDao;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "UpdateUserServlet2",urlPatterns = "/UpdateUserServlet2")
public class UpdateUserServlet2 extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response)throws ServletException, IOException {
        //设置请求编码、响应方式和编码方式
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        int id = Integer.parseInt(request.getParameter("id"));
        UsersDao usersDao = new UsersDao();

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
        User u2= new User();
        u2.setId(id);
        u2.setUsername(username);
        u2.setPassword(password);
        u2.setEmail(email);
        u2.setBirthday(date1);
        u2.setIsadmin(isadmin);
        boolean flag=usersDao.update(u2);
        if(flag){
            response.sendRedirect("/IndexUserServlet");
        }else {
            request.setAttribute("error_msg","修改错误");
            request.getRequestDispatcher("admin/UpdateUser.jsp").forward(request,response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
}






