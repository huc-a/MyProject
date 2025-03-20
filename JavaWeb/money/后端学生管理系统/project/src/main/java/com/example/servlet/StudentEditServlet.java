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

@WebServlet("/student/edit")
public class StudentEditServlet extends HttpServlet {
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

            Integer id = Integer.parseInt(idStr);
            Student student = studentService.getStudentById(id);
            
            if (student == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "学生不存在");
                return;
            }

            req.setAttribute("student", student);
            req.getRequestDispatcher("/WEB-INF/jsp/student/edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "系统错误");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        try {
            // 设置请求编码
            req.setCharacterEncoding("UTF-8");
            
            // 获取表单数据
            String idStr = req.getParameter("studentId");
            String studentName = req.getParameter("studentName");
            String studentGender = req.getParameter("studentGender");
            String studentAgeStr = req.getParameter("studentAge");
            String studentClass = req.getParameter("studentClass");

            // 数据验证
            if (idStr == null || idStr.trim().isEmpty()) {
                throw new IllegalArgumentException("学生ID不能为空");
            }
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
            student.setStudentId(Integer.parseInt(idStr));
            student.setStudentName(studentName);
            student.setStudentGender(studentGender);
            student.setStudentAge(Integer.parseInt(studentAgeStr));
            student.setStudentClass(studentClass);

            // 更新学生
            studentService.updateStudent(student);

            // 重定向到学生列表
            resp.sendRedirect(req.getContextPath() + "/students");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "更新学生失败：" + e.getMessage());
            doGet(req, resp);
        }
    }
} 