package com.mall.controller.product;

import com.mall.model.Product;
import com.mall.service.CategoryService;
import com.mall.service.ProductService;
import com.mall.service.impl.CategoryServiceImpl;
import com.mall.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/product/list")
public class ProductListServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 获取搜索参数
        String keyword = req.getParameter("keyword");
        String categoryIdStr = req.getParameter("categoryId");
        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // 忽略无效的分类ID
            }
        }
        
        // 获取商品列表
        List<Product> products = productService.searchProducts(keyword, categoryId);
        req.setAttribute("products", products);
        
        // 获取分类列表用于搜索表单
        req.setAttribute("categories", categoryService.getAllCategories());
        
        req.getRequestDispatcher("/admin/product/list.jsp").forward(req, resp);
    }
} 