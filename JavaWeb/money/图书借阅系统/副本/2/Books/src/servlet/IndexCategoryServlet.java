package servlet;

import dao.CategoryDao;
import domain.Category;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/IndexCategoryServlet")
public class IndexCategoryServlet extends HttpServlet {
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // 检查用户是否登录
        if(session.getAttribute("user") == null) {
            request.getRequestDispatcher("admin/login.jsp").forward(request, response);
            return;
        }
        
        // 获取所有分类
        List<Category> categoryList = categoryDao.findAll();
        session.setAttribute("categoryList", categoryList);
        
        // 转发到分类管理页面
        request.getRequestDispatcher("admin/CategoryMange.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 