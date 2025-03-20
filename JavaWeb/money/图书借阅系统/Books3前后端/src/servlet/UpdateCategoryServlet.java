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

@WebServlet("/UpdateCategoryServlet")
public class UpdateCategoryServlet extends HttpServlet {
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getIsadmin() != 1) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        try {
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            String categoryName = request.getParameter("category_name");
            String description = request.getParameter("description");

            Category category = new Category();
            category.setCategory_id(categoryId);
            category.setCategory_name(categoryName);
            category.setDescription(description);

            if (booksDao.updateCategory(category)) {
                response.sendRedirect("/IndexCategoryServlet");
            } else {
                response.getWriter().write("更新分类失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("更新分类失败：" + e.getMessage());
        }
    }
} 