package com.hospital.controller.patient;

import com.hospital.model.User;
import com.hospital.service.DoctorService;
import com.hospital.service.DoctorServiceImpl;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/patient/doctors")
public class PatientDoctorServlet extends HttpServlet {
    private DoctorService doctorService = new DoctorServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User patient = (User) request.getSession().getAttribute("user");
        if (patient == null || !"patient".equals(patient.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String departmentId = request.getParameter("departmentId");
        if (departmentId == null || departmentId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "科室ID不能为空");
            return;
        }
        
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(
                doctorService.getDoctorsByDepartment(Long.parseLong(departmentId))
            ));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 