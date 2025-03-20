package servlet;

import dao.BooksDao;
import dao.OrdersDao;
import domain.Book;
import domain.Order;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "BorrowBookServlet", urlPatterns = "/BorrowBookServlet")
public class BorrowBookServlet extends HttpServlet {
    private BooksDao booksDao = new BooksDao();
    private OrdersDao ordersDao = new OrdersDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        // 处理借阅操作
        String bookId = request.getParameter("bookId");
        if (bookId != null) {
            try {
                // 创建借阅记录
                Order order = new Order();
                order.setBookid(Integer.parseInt(bookId));
                order.setId(user.getId());
                order.setTime(new Date());
                
                boolean success = ordersDao.add(order);
                
                if (success) {
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().println("<script>alert('借阅成功！'); window.location.href='user/borrow.jsp';</script>");
                    return;
                } else {
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().println("<script>alert('借阅失败！'); window.location.href='user/borrow.jsp';</script>");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 获取搜索关键词
        String keyword = request.getParameter("keyword");
        List<Book> bookList;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 执行搜索
            bookList = booksDao.searchBooks(keyword.trim());
        } else {
            // 获取所有图书
            bookList = booksDao.findAll();
        }
        
        // 检查每本书的借阅状态
        for (Book book : bookList) {
            boolean isBorrowed = ordersDao.isBookBorrowed(book.getBookid());
            book.setBorrowed(isBorrowed);
        }
        
        request.setAttribute("bookList", bookList);
        request.getRequestDispatcher("user/borrow.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 