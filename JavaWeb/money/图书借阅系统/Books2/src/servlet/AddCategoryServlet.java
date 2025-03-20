package servlet;

import dao.CategoryDao;
import domain.Category;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 获取表单数据
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            
            // 创建分类对象
            Category category = new Category();
            category.setCategoryName(categoryName);
            category.setDescription(description);
            
            // 保存分类
            if (categoryDao.add(category)) {
                response.sendRedirect("/IndexCategoryServlet");
            } else {
                response.getWriter().write("添加分类失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("添加分类失败：" + e.getMessage());
        }
    }
} 