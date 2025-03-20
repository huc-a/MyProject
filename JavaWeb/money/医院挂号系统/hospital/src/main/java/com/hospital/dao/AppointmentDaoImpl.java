package com.hospital.dao;

import com.hospital.util.DBUtil;
import java.math.BigDecimal;
import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

public class AppointmentDaoImpl implements AppointmentDao {
    
    @Override
    public List<Map<String, Object>> findByDoctorId(Long doctorId, String dateFilter, String status, String timeSlot) throws Exception {
        List<Map<String, Object>> appointments = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT r.*, u.full_name as patient_name, d.name as department_name " +
            "FROM registration r " +
            "JOIN users u ON r.patient_id = u.id " +
            "JOIN department d ON r.department_id = d.id " +
            "WHERE r.doctor_id = ? "
        );
        
        // 添加筛选条件
        if (status != null && !status.isEmpty()) {
            sql.append("AND r.status = ? ");
        }
        if (timeSlot != null && !timeSlot.isEmpty()) {
            sql.append("AND r.time_slot = ? ");
        }
        
        sql.append("ORDER BY r.visit_date, r.time_slot");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            stmt.setLong(paramIndex++, doctorId);
            
            if (status != null && !status.isEmpty()) {
                stmt.setString(paramIndex++, status);
            }
            if (timeSlot != null && !timeSlot.isEmpty()) {
                stmt.setString(paramIndex++, timeSlot);
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> appointment = new HashMap<>();
                appointment.put("id", rs.getLong("id"));
                appointment.put("patientName", rs.getString("patient_name"));
                appointment.put("visitDate", rs.getDate("visit_date").toString());
                appointment.put("timeSlot", rs.getString("time_slot"));
                appointment.put("departmentName", rs.getString("department_name"));
                appointment.put("status", rs.getString("status"));
                appointments.add(appointment);
            }
        }
        
        return appointments;
    }
    
    @Override
    public void updateStatus(Long appointmentId, String status) throws Exception {
        String sql = "UPDATE registration SET status = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setLong(2, appointmentId);
            
            int rows = stmt.executeUpdate();
            if (rows != 1) {
                throw new Exception("更新挂号记录状态失败");
            }
        }
    }
    
    @Override
    public boolean verifyDoctorAppointment(Long appointmentId, Long doctorId) throws Exception {
        String sql = "SELECT COUNT(*) FROM registration WHERE id = ? AND doctor_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, appointmentId);
            stmt.setLong(2, doctorId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }
    
    @Override
    public List<Map<String, Object>> findByPatientId(Long patientId) throws Exception {
        List<Map<String, Object>> appointments = new ArrayList<>();
        String sql = 
            "SELECT r.*, d.name as department_name, u.full_name as doctor_name " +
            "FROM registration r " +
            "JOIN department d ON r.department_id = d.id " +
            "JOIN users u ON r.doctor_id = u.id " +
            "WHERE r.patient_id = ? " +
            "ORDER BY r.visit_date DESC, r.time_slot";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, patientId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> appointment = new HashMap<>();
                appointment.put("id", rs.getLong("id"));
                appointment.put("visitDate", rs.getDate("visit_date").toString());
                appointment.put("timeSlot", rs.getString("time_slot"));
                appointment.put("departmentName", rs.getString("department_name"));
                appointment.put("doctorName", rs.getString("doctor_name"));
                appointment.put("status", rs.getString("status"));
                appointment.put("fee", rs.getBigDecimal("fee"));
                appointments.add(appointment);
            }
        }
        
        return appointments;
    }
    
    @Override
    public boolean isTimeSlotFull(Long doctorId, String visitDate, String timeSlot) throws Exception {
        String sql = 
            "SELECT COUNT(*) as count FROM registration " +
            "WHERE doctor_id = ? AND visit_date = ? AND time_slot = ? AND status != 'cancelled'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, doctorId);
            stmt.setDate(2, Date.valueOf(visitDate));
            stmt.setString(3, timeSlot);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                // 假设每个时间段最多接待5个病人
                return rs.getInt("count") >= 5;
            }
            return false;
        }
    }
    
    @Override
    public void create(Long patientId, Long doctorId, Long departmentId, 
            String visitDate, String timeSlot, BigDecimal fee) throws Exception {
        String sql = 
            "INSERT INTO registration " +
            "(patient_id, doctor_id, department_id, registration_time, visit_date, time_slot, status, fee) " +
            "VALUES (?, ?, ?, NOW(), ?, ?, 'pending', ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, patientId);
            stmt.setLong(2, doctorId);
            stmt.setLong(3, departmentId);
            stmt.setDate(4, Date.valueOf(visitDate));
            stmt.setString(5, timeSlot);
            stmt.setBigDecimal(6, fee);
            
            int rows = stmt.executeUpdate();
            if (rows != 1) {
                throw new Exception("创建挂号记录失败");
            }
        }
    }
    
    @Override
    public boolean verifyPatientAppointment(Long appointmentId, Long patientId) throws Exception {
        String sql = "SELECT COUNT(*) as count FROM registration WHERE id = ? AND patient_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, appointmentId);
            stmt.setLong(2, patientId);
            ResultSet rs = stmt.executeQuery();
            
            return rs.next() && rs.getInt("count") > 0;
        }
    }
} 