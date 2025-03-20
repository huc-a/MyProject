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

@WebServlet(name = "UpdateUserServlet",urlPatterns = "/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response)throws ServletException, IOException {
        //设置请求编码、响应方式和编码方式
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        int id = Integer.parseInt(request.getParameter("id"));
        UsersDao usersDao = new UsersDao();
        //根据id查找用户是否存在
        User u1 = usersDao.find(id);
        if(u1!=null){
            request.setAttribute("user1",u1);
            request.getRequestDispatcher("admin/UpdateUser.jsp").forward(request,response);
        }else{
            request.setAttribute("error_msg","用户不存在");

        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
}






