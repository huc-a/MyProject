package com.example.servlet;

import com.example.bean.Student;
import com.example.service.StudentService;
import com.example.service.impl.StudentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/students")
public class StudentListServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            String keyword = req.getParameter("keyword");
            List<Student> students;
            if (keyword != null && !keyword.trim().isEmpty()) {
                students = studentService.searchStudents(keyword);
                req.setAttribute("keyword", keyword);
            } else {
                students = studentService.getAllStudents();
            }
            req.setAttribute("students", students);
            req.getRequestDispatcher("/WEB-INF/jsp/student/list.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
} 