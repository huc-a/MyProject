package servlet;

import dao.BooksDao;
import dao.CategoryDao;
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
import java.util.List;

@WebServlet("/IndexBookServletForUser")
public class IndexBookServletForUser extends HttpServlet {
    private BooksDao booksDao = new BooksDao();
    private CategoryDao categoryDao = new CategoryDao();

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

        // 获取分类列表
        List<Category> categoryList = categoryDao.findAll();
        session.setAttribute("categoryList", categoryList);

        // 获取查询参数
        String keyword = req.getParameter("keyword");
        String categoryId = req.getParameter("categoryId");
        
        ArrayList<Book> list;

        if (keyword != null && !keyword.trim().isEmpty()) {
            // 关键字搜索
            list = booksDao.search(keyword);
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
            // 分类查询
            list = booksDao.findByCategory(Integer.parseInt(categoryId));
        } else {
            // 查询所有图书
            list = booksDao.findAll();
        }
        
        session.setAttribute("bookList", list);
        req.getRequestDispatcher("user/BookStore.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        this.doGet(req, resp);
    }
} 