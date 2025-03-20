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
import java.util.Date;

@WebServlet("/BuyBookServlet")
public class BuyBookServlet extends HttpServlet {
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

        try {
            int bookid = Integer.parseInt(request.getParameter("bookid"));
            Book book = booksDao.findById(bookid);
            
            if (book != null && book.getStock() > 0) {
                // 创建订单
                Order order = new Order();
                order.setBookid(bookid);
                order.setId(user.getId());
                order.setQuantity(1);  // 默认购买1本
                order.setTotalPrice(book.getPrice());  // 设置总价
                order.setStatus(0);  // 设置为待付款状态
                order.setTime(new Date());
                order.setAddress(user.getAddress());  // 使用用户默认地址
                order.setPhone(user.getPhone());      // 使用用户默认电话
                
                if (ordersDao.add(order)) {
                    // 更新库存
                    book.setStock(book.getStock() - 1);
                    booksDao.update(book);
                    
                    response.sendRedirect("/MyOrdersServlet");  // 跳转到订单页面
                } else {
                    response.getWriter().write("购买失败，请稍后重试");
                }
            } else {
                response.getWriter().write("图书不存在或已售罄");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("购买失败：" + e.getMessage());
        }
    }
} 