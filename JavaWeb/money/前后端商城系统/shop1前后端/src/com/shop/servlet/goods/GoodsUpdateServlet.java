package com.shop.servlet.goods;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import com.shop.util.DateUtil;

/**
 * 更新商品Servlet
 */
@WebServlet("/GoodsUpdateServlet")
@MultipartConfig(maxFileSize = 1024*1024*100 ,maxRequestSize = 1024*1024*200)
public class GoodsUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        Integer stock = Integer.valueOf(request.getParameter("stock"));
        String remark = request.getParameter("remark");
        String isDelete = request.getParameter("isDelete");
        String fileName = request.getParameter("fileName");
        Part part = request.getPart("img");

        if (part != null && part.getSize() > 0) {
            String originalName = part.getSubmittedFileName();
            String extension = originalName.substring(originalName.lastIndexOf(".")).toLowerCase();
            
            // 检查文件类型
            if (!Arrays.asList(".jpg", ".jpeg", ".png", ".bmp").contains(extension)) {
                request.setAttribute("errorMsg", "只支持jpg、jpeg、png、bmp格式的图片");
                request.getRequestDispatcher("goodsUpdate.jsp").forward(request, response);
                return;
            }
            
            // 删除旧文件
            if (fileName != null) {
                File oldFile = new File(basepath, fileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
            
            // 保存新文件
            fileName = id + extension;
            File destFile = new File(basepath, fileName);
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
        goods.setFileName(fileName);
        goods.setRemark(remark);
        goods.setIsDelete(isDelete);
        goods.setUpdateDatetime(new Date());

        // 执行更新操作
        int update = goodsService.update(goods);

        if (update > 0) {  // 成功
            request.setAttribute("successMsg", "更新成功");
        } else {  // 失败
            request.setAttribute("errorMsg", "更新失败");
            request.setAttribute("goods", goods);
        }
        request.getRequestDispatcher("goodsUpdate.jsp").forward(request, response);

    }

}
