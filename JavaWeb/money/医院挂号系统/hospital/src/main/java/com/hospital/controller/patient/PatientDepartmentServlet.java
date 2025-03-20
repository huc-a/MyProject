package com.hospital.controller.patient;

import com.hospital.model.User;
import com.hospital.service.DepartmentService;
import com.hospital.service.DepartmentServiceImpl;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/patient/departments")
public class PatientDepartmentServlet extends HttpServlet {
    private DepartmentService departmentService = new DepartmentServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User patient = (User) request.getSession().getAttribute("user");
        if (patient == null || !"patient".equals(patient.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(departmentService.getAllDepartments()));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 