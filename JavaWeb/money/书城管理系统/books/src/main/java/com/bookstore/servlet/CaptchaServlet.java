package com.bookstore.servlet;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@WebServlet("/captcha")
public class CaptchaServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 设置响应类型
        resp.setContentType("image/jpeg");
        // 禁止图像缓存
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);
        
        // 创建图像
        int width = 80, height = 30;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        
        // 设置背景色
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, width, height);
        
        // 设置字体
        g.setFont(new Font("Arial", Font.BOLD, 20));
        
        // 生成随机验证码
        Random random = new Random();
        String captcha = String.format("%04d", random.nextInt(10000));
        
        // 将验证码存入session
        HttpSession session = req.getSession();
        session.setAttribute("captcha", captcha);
        
        // 添加干扰线
        g.setColor(Color.LIGHT_GRAY);
        for (int i = 0; i < 10; i++) {
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g.drawLine(x1, y1, x2, y2);
        }
        
        // 绘制验证码
        g.setColor(new Color(50 + random.nextInt(100), 
                           50 + random.nextInt(100), 
                           50 + random.nextInt(100)));
        g.drawString(captcha, 15, 22);
        
        // 释放图形资源
        g.dispose();
        
        // 输出图像
        ImageIO.write(image, "JPEG", resp.getOutputStream());
    }
} 