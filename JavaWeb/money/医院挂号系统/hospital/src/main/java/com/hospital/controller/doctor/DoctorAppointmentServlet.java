package com.hospital.controller.doctor;

import com.hospital.model.User;
import com.hospital.service.AppointmentService;
import com.hospital.service.AppointmentServiceImpl;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/doctor/appointments/*")
public class DoctorAppointmentServlet extends HttpServlet {
    private AppointmentService appointmentService = new AppointmentServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User doctor = (User) request.getSession().getAttribute("user");
        if (doctor == null || !"doctor".equals(doctor.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String dateFilter = request.getParameter("date");
        String statusFilter = request.getParameter("status");
        String timeSlotFilter = request.getParameter("timeSlot");
        
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(
                appointmentService.getDoctorAppointments(doctor.getId(), dateFilter, statusFilter, timeSlotFilter)
            ));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
    
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
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
        
        long appointmentId = Long.parseLong(pathParts[1]);
        Map<String, String> body = gson.fromJson(request.getReader(), Map.class);
        String status = body.get("status");
        
        try {
            appointmentService.updateAppointmentStatus(appointmentId, doctor.getId(), status);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 