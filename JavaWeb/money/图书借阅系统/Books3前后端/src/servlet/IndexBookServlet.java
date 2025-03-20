package servlet;

import dao.BooksDao;
import dao.UsersDao;
import domain.Book;
import domain.User;
import domain.Category;

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
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if(session.getAttribute("user") == null) {
            req.getRequestDispatcher("admin/login.jsp").forward(req, resp);
            return;
        }

        String method = req.getParameter("method");
        
        if ("add".equals(method)) {
            // 加载分类数据
            ArrayList<Category> categories = booksDao.findAllCategories();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("admin/AddBook.jsp").forward(req, resp);
            return;
        }
        
        // 查询所有图书
        ArrayList<Book> list = booksDao.findAll();
        session.setAttribute("bookList", list);
        req.getRequestDispatcher("admin/BookMange.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
