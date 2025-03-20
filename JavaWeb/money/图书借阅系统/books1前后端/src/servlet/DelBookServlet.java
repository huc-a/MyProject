package servlet;

import dao.BooksDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DelBookServlet")
public class DelBookServlet extends HttpServlet {
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 获取图书ID
            int bookid = Integer.parseInt(request.getParameter("id"));
            
            // 删除图书
            booksDao.delete(bookid);
            
            // 重定向到图书列表
            response.sendRedirect("/IndexBookServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("删除图书失败：" + e.getMessage());
        }
    }
} 