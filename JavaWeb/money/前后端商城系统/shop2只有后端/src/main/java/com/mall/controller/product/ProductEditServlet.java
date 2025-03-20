package com.mall.controller.product;

import com.mall.model.Product;
import com.mall.service.CategoryService;
import com.mall.service.ProductService;
import com.mall.service.impl.CategoryServiceImpl;
import com.mall.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/admin/product/edit")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProductEditServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null && !id.trim().isEmpty()) {
            Product product = productService.getProductById(Integer.parseInt(id));
            if (product != null) {
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.getAllCategories());
                req.getRequestDispatcher("/admin/product/edit.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect("list");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 获取表单数据
        Integer id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        BigDecimal price = new BigDecimal(req.getParameter("price"));
        Integer stock = Integer.parseInt(req.getParameter("stock"));
        Integer categoryId = Integer.parseInt(req.getParameter("categoryId"));

        // 获取原商品信息
        Product product = productService.getProductById(id);
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "商品不存在");
            return;
        }

        // 处理图片上传
        Part filePart = req.getPart("image");
        String imagePath = product.getImage(); // 保持原图片路径
        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileName = UUID.randomUUID().toString() + getFileExtension(submittedFileName);
            String uploadPath = getServletContext().getRealPath("/static/uploads/products/");
            filePart.write(uploadPath + fileName);
            imagePath = "/static/uploads/products/" + fileName;
        }

        // 更新商品信息
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStock(stock);
        product.setCategoryId(categoryId);
        product.setImage(imagePath);

        // 保存更新
        if (productService.updateProduct(product)) {
            resp.sendRedirect("list");
        } else {
            req.setAttribute("error", "更新商品失败");
            doGet(req, resp);
        }
    }

    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        return dotIndex == -1 ? "" : fileName.substring(dotIndex);
    }
} 