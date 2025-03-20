package com.bookstore.servlet;

import com.bookstore.dao.OrderDAO;
import com.bookstore.model.Order;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/order/*")
public class OrderManageServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if (action == null || "/list".equals(action)) {
            String search = req.getParameter("search");
            List<Order> orders = orderDAO.getOrders(search);
            req.setAttribute("orders", orders);
            req.setAttribute("search", search);
            req.getRequestDispatcher("/jsp/admin/order-list.jsp").forward(req, resp);
        } else if ("/detail".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Order order = orderDAO.getOrderById(id);
            req.setAttribute("order", order);
            req.getRequestDispatcher("/jsp/admin/order-detail.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String action = req.getPathInfo();
        
        if ("/delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                if (orderDAO.deleteOrder(id)) {
                    resp.getWriter().write("success");
                } else {
                    resp.getWriter().write("error");
                }
            } catch (NumberFormatException e) {
                resp.getWriter().write("error");
            }
        }
    }
} 