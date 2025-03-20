package com.example.servlet;

import com.example.service.StudentService;
import com.example.service.impl.StudentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/student/delete")
public class StudentDeleteServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            // 获取学生ID
            String idStr = req.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "学生ID不能为空");
                return;
            }

            // 删除学生
            Integer id = Integer.parseInt(idStr);
            studentService.deleteStudent(id);

            // 设置成功消息
            req.getSession().setAttribute("message", "删除成功！");
            
            // 重定向到学生列表
            resp.sendRedirect(req.getContextPath() + "/students");
        } catch (Exception e) {
            e.printStackTrace();
            // 设置错误消息并重定向到列表页
            req.getSession().setAttribute("error", "删除学生失败：" + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/students");
        }
    }
} 