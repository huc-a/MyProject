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

@WebServlet("/ReturnBookServlet")
public class ReturnBookServlet extends HttpServlet {
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
            // 获取订单ID
            int orderid = Integer.parseInt(request.getParameter("orderid"));
            
            // 验证订单是否属于当前用户
            Order order = ordersDao.findById(orderid);
            if (order != null && order.getId() == user.getId()) {
                // 删除订单
                if (ordersDao.delete(orderid)) {
                    // 重定向到借阅记录页面
                    response.sendRedirect("/MyBorrowsServlet?success=return");
                } else {
                    response.getWriter().write("归还失败，请稍后重试");
                }
            } else {
                response.getWriter().write("无效的订单");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("归还失败：" + e.getMessage());
        }
    }
} 