package com.hospital.service;

import com.hospital.dao.AppointmentDao;
import com.hospital.dao.AppointmentDaoImpl;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class AppointmentServiceImpl implements AppointmentService {
    private AppointmentDao appointmentDao = new AppointmentDaoImpl();
    private FeeService feeService = new FeeServiceImpl();
    
    @Override
    public List<Map<String, Object>> getDoctorAppointments(Long doctorId, String dateFilter, 
            String statusFilter, String timeSlotFilter) throws Exception {
        return appointmentDao.findByDoctorId(doctorId, dateFilter, statusFilter, timeSlotFilter);
    }
    
    @Override
    public void updateAppointmentStatus(Long appointmentId, Long doctorId, String status) throws Exception {
        // 验证挂号记录是否属于该医生
        if (!appointmentDao.verifyDoctorAppointment(appointmentId, doctorId)) {
            throw new Exception("无权操作此挂号记录");
        }
        appointmentDao.updateStatus(appointmentId, status);
    }
    
    @Override
    public List<Map<String, Object>> getPatientAppointments(Long patientId) throws Exception {
        return appointmentDao.findByPatientId(patientId);
    }
    
    @Override
    public void createAppointment(Long patientId, Long doctorId, Long departmentId, 
            String visitDate, String timeSlot) throws Exception {
        // 获取挂号费用
        BigDecimal fee = feeService.getFee(timeSlot);
        
        // 检查该时间段是否已约满
        if (appointmentDao.isTimeSlotFull(doctorId, visitDate, timeSlot)) {
            throw new Exception("该时间段已约满，请选择其他时间");
        }
        
        // 创建挂号记录
        appointmentDao.create(patientId, doctorId, departmentId, visitDate, timeSlot, fee);
    }
    
    @Override
    public void cancelAppointment(Long appointmentId, Long patientId) throws Exception {
        // 验证挂号记录是否属于该病人
        if (!appointmentDao.verifyPatientAppointment(appointmentId, patientId)) {
            throw new Exception("无权操作此挂号记录");
        }
        
        // 更新状态为已取消
        appointmentDao.updateStatus(appointmentId, "cancelled");
    }
} 