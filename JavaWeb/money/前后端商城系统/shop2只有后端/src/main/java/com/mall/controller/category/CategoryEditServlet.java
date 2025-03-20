package com.mall.controller.category;

import com.mall.model.Category;
import com.mall.service.CategoryService;
import com.mall.service.impl.CategoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/category/edit")
public class CategoryEditServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        Category category = new Category();
        category.setId(id);
        category.setName(name);
        category.setDescription(description);

        if (categoryService.updateCategory(category)) {
            resp.sendRedirect("list");
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "更新分类失败");
        }
    }
} 