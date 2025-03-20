package servlet;

import dao.BooksDao;
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

@WebServlet("/IndexBookServletForUser")
public class IndexBookServletForUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            req.getRequestDispatcher("admin/login.jsp").forward(req, resp);
            return;
        }
        
        if (user.getIsadmin() == 1) {
            resp.sendRedirect("admin/MangeIndex.jsp");
            return;
        }

        BooksDao booksDao = new BooksDao();
        
        // 获取分类列表
        ArrayList<Category> categories = booksDao.findAllCategories();
        session.setAttribute("categories", categories);

        // 获取搜索参数
        String keyword = req.getParameter("keyword");
        String categoryId = req.getParameter("category");
        ArrayList<Book> list;

        // 根据条件查询图书
        if ((keyword != null && !keyword.trim().isEmpty()) || 
            (categoryId != null && !categoryId.trim().isEmpty())) {
            list = booksDao.search(keyword, categoryId);
        } else {
            list = booksDao.findAll();
        }
        
        session.setAttribute("bookList", list);
        req.getRequestDispatcher("user/BookBorrow.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        this.doGet(req, resp);
    }
} 