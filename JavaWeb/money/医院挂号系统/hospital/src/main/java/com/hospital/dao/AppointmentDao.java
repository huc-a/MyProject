package com.hospital.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface AppointmentDao {
    /**
     * 根据医生ID查询挂号记录
     */
    List<Map<String, Object>> findByDoctorId(Long doctorId, String dateFilter, 
            String statusFilter, String timeSlotFilter) throws Exception;
    
    /**
     * 更新挂号记录状态
     */
    void updateStatus(Long appointmentId, String status) throws Exception;
    
    /**
     * 验证挂号记录是否属于指定医生
     */
    boolean verifyDoctorAppointment(Long appointmentId, Long doctorId) throws Exception;
    
    /**
     * 根据病人ID查询挂号记录
     */
    List<Map<String, Object>> findByPatientId(Long patientId) throws Exception;
    
    /**
     * 验证该时间段是否已约满
     */
    boolean isTimeSlotFull(Long doctorId, String visitDate, String timeSlot) throws Exception;
    
    /**
     * 创建挂号记录
     */
    void create(Long patientId, Long doctorId, Long departmentId, String visitDate, 
            String timeSlot, BigDecimal fee) throws Exception;
    
    /**
     * 验证挂号记录是否属于指定病人
     */
    boolean verifyPatientAppointment(Long appointmentId, Long patientId) throws Exception;
} 