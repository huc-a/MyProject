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

@WebServlet("/MyOrdersServlet")
public class MyOrdersServlet extends HttpServlet {
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

        // 获取用户的订单记录
        List<Order> myOrders = ordersDao.findByUserId(user.getId());
        
        // 计算统计信息
        int totalOrders = ordersDao.getTotalBorrowCount(user.getId());
        int pendingCount = 0;  // 待付款订单数量
        
        // 检查订单状态
        for (Order order : myOrders) {
            if (order.getStatus() == 0) { // 待付款状态
                pendingCount++;
            }
        }
        
        // 设置属性
        session.setAttribute("myOrders", myOrders);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingCount", pendingCount);
        
        request.getRequestDispatcher("user/MyOrders.jsp").forward(request, response);
    }
} 