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

    private static final int PAGE_SIZE = 8; // 每页显示8本书

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            request.getRequestDispatcher("admin/login.jsp").forward(request, response);
            return;
        }
        
        if (user.getIsadmin() == 1) {
            response.sendRedirect("admin/MangeIndex.jsp");
            return;
        }

        // 获取分类列表
        List<Category> categoryList = categoryDao.findAll();
        session.setAttribute("categoryList", categoryList);

        // 获取当前页码，默认为1
        int currentPage = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }

        // 获取分类ID和搜索关键词
        String categoryId = request.getParameter("categoryId");
        String keyword = request.getParameter("keyword");

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

        // 计算总页数
        int totalBooks = list.size();
        int totalPages = (int) Math.ceil((double) totalBooks / PAGE_SIZE);

        // 获取当前页的图书
        int start = (currentPage - 1) * PAGE_SIZE;
        int end = Math.min(start + PAGE_SIZE, totalBooks);
        List<Book> currentPageBooks = list.subList(start, end);

        // 设置属性
        session.setAttribute("bookList", currentPageBooks);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        
        // 转发到图书列表页面
        request.getRequestDispatcher("user/BookStore.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 