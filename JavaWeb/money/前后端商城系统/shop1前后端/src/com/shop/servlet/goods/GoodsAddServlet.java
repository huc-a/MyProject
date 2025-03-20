package com.shop.servlet.goods;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.shop.entity.Goods;
import com.shop.service.GoodsService;

/**
 * 添加商品Servlet
 */
@WebServlet("/GoodsAddServlet")
@MultipartConfig(maxFileSize = 1024*1024*100 ,maxRequestSize = 1024*1024*200)
public class GoodsAddServlet extends HttpServlet {

    // 创建业务处理类对象
    private GoodsService goodsService = new GoodsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取web应用的upload目录的真实路径
        String basepath = request.getServletContext().getRealPath("/upload");
        
        // 在request中获取商品信息
        String id = UUID.randomUUID().toString().replace("-", "");
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        Integer stock = Integer.valueOf(request.getParameter("stock"));
        String remark = request.getParameter("remark");
        Part part = request.getPart("img");

        //获取上传文件的路径  真实路径
        File uploadDir = new File(basepath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fileName = null;

        if (part != null && part.getSize() > 0) {
            String originalName = part.getSubmittedFileName();
            String extension = originalName.substring(originalName.lastIndexOf(".")).toLowerCase();
            
            // 检查文件类型
            if (!Arrays.asList(".jpg", ".jpeg", ".png", ".bmp").contains(extension)) {
                request.setAttribute("errorMsg", "只支持jpg、jpeg、png、bmp格式的图片");
                request.getRequestDispatcher("goodsAdd.jsp").forward(request, response);
                return;
            }
            
            // 使用商品ID作为文件名
            fileName = id + extension;
            File destFile = new File(uploadDir, fileName);
            part.write(destFile.getAbsolutePath());
        }

        // 创建商品对象
        Goods goods = new Goods();
        // 把信息添加到对象中
        goods.setId(id);
        goods.setName(name);
        goods.setBrand(brand);
        goods.setPrice(price);
        goods.setStock(stock);
        goods.setRemark(remark);
        goods.setCreateDatetime(new Date());
        goods.setFileName(fileName);

        // 执行添加操作
        int add = 0;
        try {
            add = goodsService.add(goods);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (add > 0) {  // 成功
            request.setAttribute("successMsg", "添加成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "添加失败");
            request.setAttribute("goods", goods);
        }
        request.getRequestDispatcher("goodsAdd.jsp").forward(request, response);

    }

}
