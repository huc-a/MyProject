package com.hospital.service;

import java.util.List;
import java.util.Map;

public interface AppointmentService {
    /**
     * 获取医生的挂号记录
     * @param doctorId 医生ID
     * @param dateFilter 日期筛选
     * @param statusFilter 状态筛选
     * @param timeSlotFilter 时间段筛选
     * @return 挂号记录列表
     */
    List<Map<String, Object>> getDoctorAppointments(Long doctorId, String dateFilter, 
            String statusFilter, String timeSlotFilter) throws Exception;
    
    /**
     * 更新挂号记录状态
     * @param appointmentId 挂号记录ID
     * @param doctorId 医生ID
     * @param status 新状态
     */
    void updateAppointmentStatus(Long appointmentId, Long doctorId, String status) throws Exception;
    
    /**
     * 获取病人的挂号记录
     * @param patientId 病人ID
     * @return 挂号记录列表
     */
    List<Map<String, Object>> getPatientAppointments(Long patientId) throws Exception;
    
    /**
     * 创建挂号记录
     * @param patientId 病人ID
     * @param doctorId 医生ID
     * @param departmentId 科室ID
     * @param visitDate 就诊日期
     * @param timeSlot 时间段
     */
    void createAppointment(Long patientId, Long doctorId, Long departmentId, String visitDate, String timeSlot) throws Exception;
    
    /**
     * 取消挂号记录
     * @param appointmentId 挂号记录ID
     * @param patientId 病人ID
     */
    void cancelAppointment(Long appointmentId, Long patientId) throws Exception;
} 