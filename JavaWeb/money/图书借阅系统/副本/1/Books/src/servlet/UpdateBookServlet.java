package servlet;

import dao.BooksDao;
import domain.Book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateBookServlet")
public class UpdateBookServlet extends HttpServlet {
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 获取图书ID
            int bookid = Integer.parseInt(request.getParameter("id"));
            
            // 查询图书信息
            Book book = booksDao.findById(bookid);
            
            // 将图书信息存储到request中
            request.setAttribute("book", book);
            
            // 转发到修改页面
            request.getRequestDispatcher("admin/UpdateBook.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("获取图书信息失败：" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 设置编码
            request.setCharacterEncoding("utf-8");
            
            // 获取表单数据
            int bookid = Integer.parseInt(request.getParameter("bookid"));
            String bookname = request.getParameter("bookname");
            String publish = request.getParameter("publish");
            float price = Float.parseFloat(request.getParameter("price"));
            String image = request.getParameter("image");
            
            // 创建Book对象
            Book book = new Book();
            book.setBookid(bookid);
            book.setBookname(bookname);
            book.setPublish(publish);
            book.setPrice(price);
            book.setImage(image);
            
            // 更新图书
            booksDao.update(book);
            
            // 重定向到图书列表
            response.sendRedirect("/IndexBookServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("修改图书失败：" + e.getMessage());
        }
    }
} 