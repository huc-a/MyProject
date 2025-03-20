package servlet;

import dao.OrdersDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DelOrderServlet")
public class DelOrderServlet extends HttpServlet {
    private OrdersDao ordersDao = new OrdersDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 获取订单ID
            int orderid = Integer.parseInt(request.getParameter("id"));
            
            // 删除订单
            ordersDao.delete(orderid);
            
            // 重定向到订单列表
            response.sendRedirect("/IndexOrderServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("删除订单失败：" + e.getMessage());
        }
    }
} 