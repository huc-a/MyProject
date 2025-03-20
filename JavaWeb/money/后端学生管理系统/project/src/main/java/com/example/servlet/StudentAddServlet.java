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

@WebServlet("/student/add")
public class StudentAddServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 显示添加学生表单
        req.getRequestDispatcher("/WEB-INF/jsp/student/add.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            // 设置请求编码
            req.setCharacterEncoding("UTF-8");
            
            // 获取表单数据
            String studentName = req.getParameter("studentName");
            String studentGender = req.getParameter("studentGender");
            String studentAgeStr = req.getParameter("studentAge");
            String studentClass = req.getParameter("studentClass");

            // 数据验证
            if (studentName == null || studentName.trim().isEmpty()) {
                throw new IllegalArgumentException("学生姓名不能为空");
            }
            if (studentGender == null || studentGender.trim().isEmpty()) {
                throw new IllegalArgumentException("性别不能为空");
            }
            if (studentAgeStr == null || studentAgeStr.trim().isEmpty()) {
                throw new IllegalArgumentException("年龄不能为空");
            }
            if (studentClass == null || studentClass.trim().isEmpty()) {
                throw new IllegalArgumentException("班级不能为空");
            }

            // 创建学生对象
            Student student = new Student();
            student.setStudentName(studentName);
            student.setStudentGender(studentGender);
            student.setStudentAge(Integer.parseInt(studentAgeStr));
            student.setStudentClass(studentClass);

            // 保存学生
            studentService.addStudent(student);

            // 重定向到学��列表
            resp.sendRedirect(req.getContextPath() + "/students");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "添加学生失败：" + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/student/add.jsp").forward(req, resp);
        }
    }
} 