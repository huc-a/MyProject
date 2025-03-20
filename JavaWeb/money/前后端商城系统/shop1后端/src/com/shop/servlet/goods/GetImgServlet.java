package com.shop.servlet.goods;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * 获取图片servlet
 */
@WebServlet("/GetImgServlet")
public class GetImgServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        // 获取web应用的upload目录的真实路径
        String basepath = request.getServletContext().getRealPath("/upload");
        
        // 获取文件名
        String imgPath = request.getParameter("imgPath");
        String fullPath = basepath + File.separator + imgPath;
        
        File file = new File(fullPath);

        //设置
        response.setHeader("content-disposition","attachment;filename=" + imgPath);
        FileInputStream fis = new FileInputStream(file);
        ServletOutputStream sos = response.getOutputStream();
        byte[] buffer = new byte[1024 * 1024 * 100];
        int len = 0;
        while((len=fis.read(buffer))!=-1){
            sos.write(buffer,0,len);
        }
        fis.close();
        sos.close();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
    }

}
