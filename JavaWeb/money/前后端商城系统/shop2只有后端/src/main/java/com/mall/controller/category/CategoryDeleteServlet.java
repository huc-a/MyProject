package com.mall.controller.category;

import com.mall.service.CategoryService;
import com.mall.service.impl.CategoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/category/delete")
public class CategoryDeleteServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null && !id.trim().isEmpty()) {
            if (categoryService.deleteCategory(Integer.parseInt(id))) {
                resp.sendRedirect("list");
                return;
            }
        }
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "删除失败");
    }
} 