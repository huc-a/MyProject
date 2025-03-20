package servlet;

import dao.UsersDao;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "IndexUserServlet",urlPatterns = "/IndexUserServlet")
public class IndexUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                HttpSession session = req.getSession();
                if(session.getAttribute("user")==null){
                    req.getRequestDispatcher("admin/login.jsp").forward(req,resp);
                }else {
                    UsersDao usersDao = new UsersDao();

                    ArrayList<User> list = usersDao.findAll();

                    session.setAttribute("userList",list);
                    req.getRequestDispatcher("admin/UserMange.jsp").forward(req,resp);
                }
            }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
