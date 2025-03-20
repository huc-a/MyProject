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

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {
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
            Category category = booksDao.findCategoryById(categoryId);
            
            if (category != null) {
                request.setAttribute("category", category);
                request.getRequestDispatcher("admin/EditCategory.jsp").forward(request, response);
            } else {
                response.getWriter().write("分类不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("获取分类信息失败：" + e.getMessage());
        }
    }
} 