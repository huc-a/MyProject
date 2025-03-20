package servlet;

import dao.CategoryDao;
import domain.Category;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateCategoryServlet")
public class UpdateCategoryServlet extends HttpServlet {
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("id"));
            Category category = categoryDao.findById(categoryId);
            
            if (category != null) {
                request.setAttribute("category", category);
                request.getRequestDispatcher("admin/UpdateCategory.jsp").forward(request, response);
            } else {
                response.getWriter().write("分类不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("获取分类信息失败：" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 获取表单数据
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            
            // 创建分类对象
            Category category = new Category();
            category.setCategoryId(categoryId);
            category.setCategoryName(categoryName);
            category.setDescription(description);
            
            // 更新分类
            if (categoryDao.update(category)) {
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