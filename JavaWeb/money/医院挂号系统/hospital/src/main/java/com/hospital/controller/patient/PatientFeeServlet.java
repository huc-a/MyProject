package com.hospital.controller.patient;

import com.hospital.model.User;
import com.hospital.service.FeeService;
import com.hospital.service.FeeServiceImpl;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/patient/fee")
public class PatientFeeServlet extends HttpServlet {
    private FeeService feeService = new FeeServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User patient = (User) request.getSession().getAttribute("user");
        if (patient == null || !"patient".equals(patient.getUserType())) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String timeSlot = request.getParameter("timeSlot");
        if (timeSlot == null || timeSlot.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "时间段不能为空");
            return;
        }
        
        try {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            Map<String, Object> result = new HashMap<>();
            result.put("fee", feeService.getFee(timeSlot));
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
} 