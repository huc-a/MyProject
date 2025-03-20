package com.example.controller.admin;

import com.example.model.Attraction;
import com.example.dao.AttractionDao;
import com.example.util.DaoFactory;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AttractionServlet extends HttpServlet {
    private AttractionDao attractionDao;

    @Override
    public void init() throws ServletException {
        attractionDao = DaoFactory.getAttractionDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 默认显示列表页面
            String page = request.getParameter("page");
            if (page == null) {
                page = "list";
            }
            
            // 获取所有景点
            List<Attraction> attractions = attractionDao.getAllAttractions();
            System.out.println("获取到的景点数量: " + attractions.size()); // 调试信息
            
            // 设置属性
            request.setAttribute("attractions", attractions);
            request.setAttribute("currentPage", page);
            
            // 转发到JSP页面
            request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=true&message=" + 
                java.net.URLEncoder.encode("获取景点列表失败：" + e.getMessage(), "UTF-8"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            // 处理删除请求
            int id = Integer.parseInt(request.getParameter("id"));
            attractionDao.deleteAttraction(id);
            response.sendRedirect(request.getContextPath() + "/admin/attraction?page=list");
            return;
        }
        
        if ("update".equals(action)) {
            // 处理更新请求
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String city = request.getParameter("city");
                int categoryId = Integer.parseInt(request.getParameter("category_id"));
                String level = request.getParameter("level");
                String description = request.getParameter("description");
                double ticketPrice = Double.parseDouble(request.getParameter("ticket_price"));
                String openingHours = request.getParameter("opening_hours");
                int suggestedDuration = Integer.parseInt(request.getParameter("suggested_duration"));
                
                Attraction attraction = new Attraction();
                attraction.setId(id);
                attraction.setName(name);
                attraction.setCity(city);
                attraction.setCategoryId(categoryId);
                attraction.setLevel(level);
                attraction.setDescription(description);
                attraction.setTicketPrice(ticketPrice);
                attraction.setOpeningHours(openingHours);
                attraction.setSuggestedDuration(suggestedDuration);
                
                attractionDao.updateAttraction(attraction);
                response.sendRedirect(request.getContextPath() + "/admin/attraction?page=list");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("index.jsp?error=true&message=" + 
                    java.net.URLEncoder.encode("修改失败：" + e.getMessage(), "UTF-8"));
                return;
            }
        }
        
        // 设置编码
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 获取表单数据
            String name = request.getParameter("name");
            String city = request.getParameter("city");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            String level = request.getParameter("level");
            String description = request.getParameter("description");
            double ticketPrice = Double.parseDouble(request.getParameter("ticket_price"));
            String openingHours = request.getParameter("opening_hours");
            int suggestedDuration = Integer.parseInt(request.getParameter("suggested_duration"));
            
            // 创建景点对象
            Attraction attraction = new Attraction();
            attraction.setName(name);
            attraction.setCity(city);
            attraction.setCategoryId(categoryId);
            attraction.setLevel(level);
            attraction.setDescription(description);
            attraction.setTicketPrice(ticketPrice);
            attraction.setOpeningHours(openingHours);
            attraction.setSuggestedDuration(suggestedDuration);
            
            // 保存到数据库
            attractionDao.addAttraction(attraction);
            
            // 设置成功消息并重定向
            response.sendRedirect("index.jsp?success=true&message=" + 
                java.net.URLEncoder.encode("景点 " + name + " 添加成功！", "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            // 设置错误消息并重定向
            response.sendRedirect("index.jsp?error=true&message=" + 
                java.net.URLEncoder.encode("添加失败：" + e.getMessage(), "UTF-8"));
        }
    }
}