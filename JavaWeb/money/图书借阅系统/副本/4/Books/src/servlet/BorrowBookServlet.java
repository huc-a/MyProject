package servlet;

import dao.OrdersDao;
import domain.Order;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet("/BorrowBookServlet")
public class BorrowBookServlet extends HttpServlet {
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

        try {
            int bookid = Integer.parseInt(request.getParameter("bookid"));
            
            Order order = new Order();
            order.setBookid(bookid);
            order.setId(user.getId());
            order.setTime(new Date());
            
            if (ordersDao.add(order)) {
                response.sendRedirect("/user/BookBorrow.jsp");
            } else {
                response.getWriter().write("借阅失败，请稍后重试");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("借阅失败：" + e.getMessage());
        }
    }
} 