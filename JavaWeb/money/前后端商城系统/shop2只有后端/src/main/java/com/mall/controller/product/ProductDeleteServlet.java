package com.mall.controller.product;

import com.mall.service.ProductService;
import com.mall.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/product/delete")
public class ProductDeleteServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null && !id.trim().isEmpty()) {
            if (productService.deleteProduct(Integer.parseInt(id))) {
                resp.sendRedirect("list");
                return;
            }
        }
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "删除失败");
    }
} 