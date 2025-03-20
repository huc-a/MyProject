package com.shop.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.shop.dao.CartDAO;
import com.shop.model.CartItem;
import com.shop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/cart/*")
public class CartServlet extends HttpServlet {
    private ObjectMapper objectMapper = new ObjectMapper();
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if ("/list".equals(pathInfo)) {
            listCartItems(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        switch (pathInfo) {
            case "/add":
                addToCart(request, response);
                break;
            case "/update":
                updateCartItem(request, response);
                break;
            case "/remove":
                removeFromCart(request, response);
                break;
        }
    }

    private void listCartItems(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> result = new HashMap<>();
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            result.put("success", false);
            result.put("message", "请先登录");
        } else {
            List<CartItem> items = cartDAO.findByUserId(user.getUserId());
            result.put("success", true);
            result.put("items", items);
        }
        
        objectMapper.writeValue(response.getWriter(), result);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> result = new HashMap<>();
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            result.put("success", false);
            result.put("message", "请先登录");
        } else {
            try {
                AddToCartRequest addRequest = objectMapper.readValue(
                    request.getReader(), AddToCartRequest.class);
                
                boolean success = cartDAO.addItem(
                    user.getUserId(), 
                    addRequest.getProductId(), 
                    addRequest.getQuantity());
                
                result.put("success", success);
                result.put("message", success ? "添加成功" : "添加失败");
            } catch (Exception e) {
                result.put("success", false);
                result.put("message", "添加失败：" + e.getMessage());
            }
        }
        
        objectMapper.writeValue(response.getWriter(), result);
    }

    private void updateCartItem(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> result = new HashMap<>();
        
        try {
            UpdateCartRequest updateRequest = objectMapper.readValue(
                request.getReader(), UpdateCartRequest.class);
            
            boolean success = cartDAO.updateQuantity(
                updateRequest.getCartItemId(), 
                updateRequest.getQuantity());
            
            result.put("success", success);
            result.put("message", success ? "更新成功" : "更新失败");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "更新失败：" + e.getMessage());
        }
        
        objectMapper.writeValue(response.getWriter(), result);
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        Map<String, Object> result = new HashMap<>();
        
        try {
            RemoveFromCartRequest removeRequest = objectMapper.readValue(
                request.getReader(), RemoveFromCartRequest.class);
            
            boolean success = cartDAO.removeItem(removeRequest.getCartItemId());
            
            result.put("success", success);
            result.put("message", success ? "删除成功" : "删除失败");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "删除失败：" + e.getMessage());
        }
        
        objectMapper.writeValue(response.getWriter(), result);
    }

    // 请求对象内部类
    private static class AddToCartRequest {
        private int productId;
        private int quantity = 1;

        public int getProductId() { return productId; }
        public void setProductId(int productId) { this.productId = productId; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
    }

    private static class UpdateCartRequest {
        private int cartItemId;
        private int quantity;

        public int getCartItemId() { return cartItemId; }
        public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
    }

    private static class RemoveFromCartRequest {
        private int cartItemId;

        public int getCartItemId() { return cartItemId; }
        public void setCartItemId(int cartItemId) { this.cartItemId = cartItemId; }
    }
} 