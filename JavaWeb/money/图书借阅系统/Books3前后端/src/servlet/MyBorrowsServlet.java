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
import java.util.List;

@WebServlet("/MyBorrowsServlet")
public class MyBorrowsServlet extends HttpServlet {
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

        // 获取用户的借阅记录
        List<Order> myBorrows = ordersDao.findByUserId(user.getId());
        
        // 计算统计信息
        int totalBorrows = ordersDao.getTotalBorrowCount(user.getId());
        int overdueCount = 0;
        
        // 检查是否有即将到期的图书（假设14天为期限）
        long now = System.currentTimeMillis();
        for (Order order : myBorrows) {
            long borrowTime = order.getTime().getTime();
            long days = (now - borrowTime) / (1000 * 60 * 60 * 24);
            if (days >= 10) { // 超过10天标记为即将到期
                order.setOverdue(true);
                overdueCount++;
            }
        }
        
        // 设置属性
        session.setAttribute("myBorrows", myBorrows);
        request.setAttribute("totalBorrows", totalBorrows);
        request.setAttribute("overdueCount", overdueCount);
        
        request.getRequestDispatcher("user/MyBorrows.jsp").forward(request, response);
    }
} 