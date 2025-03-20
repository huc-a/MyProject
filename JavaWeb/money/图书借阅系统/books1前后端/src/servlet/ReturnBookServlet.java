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

@WebServlet(name = "ReturnBookServlet", urlPatterns = "/ReturnBookServlet")
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

        String orderId = request.getParameter("orderId");
        if (orderId != null) {
            try {
                // 获取订单信息
                Order order = ordersDao.findById(Integer.parseInt(orderId));
                
                // 验证是否是当前用户的订单
                if (order != null && order.getId() == user.getId()) {
                    // 更新归还时间
                    order.setReturntime(new Date());
                    boolean success = ordersDao.updateReturnTime(order);
                    
                    if (success) {
                        response.setContentType("text/html;charset=UTF-8");
                        response.getWriter().println("<script>alert('归还成功！'); window.location.href='/MyBooksServlet';</script>");
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<script>alert('归还失败！'); window.location.href='/MyBooksServlet';</script>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 