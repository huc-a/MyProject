package com.hospital.controller.patient;

import com.hospital.model.User;
import com.hospital.service.AppointmentService;
import com.hospital.service.AppointmentServiceImpl;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/patient/appointments/*")
public class PatientAppointmentServlet extends HttpServlet {
    private AppointmentService appointmentService = new AppointmentServiceImpl();
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
            response.getWriter().write(gson.toJson(
                appointmentService.getPatientAppointments(patient.getId())
            ));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        User patient = (User) request.getSession().getAttribute("user");
        if (patient == null || !"patient".equals(patient.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        try {
            JsonObject data = gson.fromJson(request.getReader(), JsonObject.class);
            
            Long departmentId = data.get("departmentId").getAsLong();
            Long doctorId = data.get("doctorId").getAsLong();
            String visitDate = data.get("visitDate").getAsString();
            String timeSlot = data.get("timeSlot").getAsString();
            
            appointmentService.createAppointment(patient.getId(), doctorId, departmentId, visitDate, timeSlot);
            
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"success\":true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json;charset=UTF-8");
            String errorMessage = e.getMessage().replace("\"", "'");
            response.getWriter().write("{\"success\":false,\"message\":\"" + errorMessage + "\"}");
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User patient = (User) request.getSession().getAttribute("user");
        if (patient == null || !"patient".equals(patient.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        String[] pathParts = pathInfo.split("/");
        if (pathParts.length != 2) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        long appointmentId = Long.parseLong(pathParts[1]);
        
        try {
            appointmentService.cancelAppointment(appointmentId, patient.getId());
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 