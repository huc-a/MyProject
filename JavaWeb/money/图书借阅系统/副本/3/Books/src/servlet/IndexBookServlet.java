package servlet;

import dao.BooksDao;
import dao.UsersDao;
import domain.Book;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "IndexBookServlet",urlPatterns = "/IndexBookServlet")
public class IndexBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                HttpSession session = req.getSession();
                if(session.getAttribute("user")==null){
                    req.getRequestDispatcher("admin/login.jsp").forward(req,resp);
                }else {
                    BooksDao booksDao = new BooksDao();

                    ArrayList<Book> list = booksDao.findAll();

                    session.setAttribute("bookList",list);
                    req.getRequestDispatcher("admin/BookMange.jsp").forward(req,resp);
                }
            }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
