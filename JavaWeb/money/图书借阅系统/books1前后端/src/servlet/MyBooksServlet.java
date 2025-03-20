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
import java.util.List;

@WebServlet(name = "MyBooksServlet", urlPatterns = "/MyBooksServlet")
public class MyBooksServlet extends HttpServlet {
    private OrdersDao ordersDao = new OrdersDao();
    private BooksDao booksDao = new BooksDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("admin/login.jsp");
            return;
        }

        // 获取用户的借阅记录
        List<Order> orderList = ordersDao.findByUserId(user.getId());
        
        // 获取每个订单对应的图书信息
        for (Order order : orderList) {
            Book book = booksDao.findById(order.getBookid());
            if (book != null) {
                order.setBookImage(book.getImage());
            }
        }
        
        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("user/mybooks.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 