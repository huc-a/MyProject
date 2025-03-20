package servlet;

import dao.BooksDao;
import domain.Category;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/IndexCategoryServlet")
public class IndexCategoryServlet extends HttpServlet {
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getIsadmin() != 1) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        ArrayList<Category> categoryList = booksDao.findAllCategories();
        session.setAttribute("categoryList", categoryList);
        
        request.getRequestDispatcher("admin/CategoryManage.jsp").forward(request, response);
    }
} 