package servlet;

import dao.BooksDao;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/DeleteCategoryServlet")
public class DeleteCategoryServlet extends HttpServlet {
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

        try {
            int categoryId = Integer.parseInt(request.getParameter("id"));
            
            if (booksDao.deleteCategory(categoryId)) {
                response.sendRedirect("/IndexCategoryServlet");
            } else {
                response.getWriter().write("删除分类失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("删除分类失败：" + e.getMessage());
        }
    }
} 