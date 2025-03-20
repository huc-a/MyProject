package servlet;

import dao.OrdersDao;
import domain.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

@WebServlet("/UpdateOrderServlet")
public class UpdateOrderServlet extends HttpServlet {
    private OrdersDao ordersDao = new OrdersDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int orderid = Integer.parseInt(request.getParameter("id"));
            Order order = ordersDao.findById(orderid);
            
            if (order != null) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("admin/UpdateOrder.jsp").forward(request, response);
            } else {
                response.getWriter().write("订单不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("获取订单信息失败：" + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("utf-8");
            
            // 获取表单数据
            int orderid = Integer.parseInt(request.getParameter("orderid"));
            int status = Integer.parseInt(request.getParameter("status"));
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            
            // 获取原订单信息
            Order order = ordersDao.findById(orderid);
            if (order != null) {
                // 更新需要修改的字段
                order.setStatus(status);
                order.setAddress(address);
                order.setPhone(phone);
                
                // 更新订单
                if (ordersDao.update(order)) {
                    response.sendRedirect("/IndexOrderServlet");
                } else {
                    response.getWriter().write("更新订单失败");
                }
            } else {
                response.getWriter().write("订单不存在");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("更新订单失败：" + e.getMessage());
        }
    }
} 