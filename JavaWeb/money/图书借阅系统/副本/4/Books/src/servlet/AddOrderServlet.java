package servlet;

import dao.OrdersDao;
import domain.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/AddOrderServlet")
public class AddOrderServlet extends HttpServlet {
    private OrdersDao ordersDao = new OrdersDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 设置编码
            request.setCharacterEncoding("utf-8");
            
            // 获取表单数据
            int bookid = Integer.parseInt(request.getParameter("bookid"));
            int id = Integer.parseInt(request.getParameter("id"));
            String timeStr = request.getParameter("time");
            
            // 创建Order对象
            Order order = new Order();
            order.setBookid(bookid);
            order.setId(id);
            
            // 转换日期格式
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            order.setTime(sdf.parse(timeStr));
            
            // 添加订单
            ordersDao.add(order);
            
            // 重定向到订单列表
            response.sendRedirect("/IndexOrderServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("添加订单失败：" + e.getMessage());
        }
    }
} 