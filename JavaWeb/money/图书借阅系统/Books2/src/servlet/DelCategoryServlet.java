package servlet;

import dao.CategoryDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DelCategoryServlet")
public class DelCategoryServlet extends HttpServlet {
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("id"));
            
            if (categoryDao.delete(categoryId)) {
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