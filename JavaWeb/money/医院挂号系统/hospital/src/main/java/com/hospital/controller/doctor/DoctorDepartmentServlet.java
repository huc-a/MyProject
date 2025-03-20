package com.hospital.controller.doctor;

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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/doctor/departments/*")
public class DoctorDepartmentServlet extends HttpServlet {
    private DepartmentService departmentService = new DepartmentServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User doctor = (User) request.getSession().getAttribute("user");
        if (doctor == null || !"doctor".equals(doctor.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        try {
            Map<String, Object> data = new HashMap<>();
            data.put("myDepartments", departmentService.getDoctorDepartments(doctor.getId()));
            data.put("availableDepartments", departmentService.getAvailableDepartments(doctor.getId()));
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(data));
        } catch (Exception e) {
            e.printStackTrace(); // 打印详细错误信息
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleDepartmentChange(request, response, true);
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleDepartmentChange(request, response, false);
    }
    
    private void handleDepartmentChange(HttpServletRequest request, HttpServletResponse response, boolean isAdd) 
            throws ServletException, IOException {
        User doctor = (User) request.getSession().getAttribute("user");
        if (doctor == null || !"doctor".equals(doctor.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        String[] pathParts = pathInfo.split("/");
        if (pathParts.length != 2) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        long departmentId = Long.parseLong(pathParts[1]);
        
        try {
            if (isAdd) {
                departmentService.addDoctorToDepartment(doctor.getId(), departmentId);
            } else {
                departmentService.removeDoctorFromDepartment(doctor.getId(), departmentId);
            }
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 