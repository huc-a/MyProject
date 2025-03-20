package com.hospital.service;

import com.hospital.model.Department;
import java.util.List;

public interface DepartmentService {
    /**
     * 获取医生所属的科室列表
     */
    List<Department> getDoctorDepartments(Long doctorId) throws Exception;
    
    /**
     * 获取医生可以添加的科室列表（排除已经加入的科室）
     */
    List<Department> getAvailableDepartments(Long doctorId) throws Exception;
    
    /**
     * 添加医生到科室
     */
    void addDoctorToDepartment(Long doctorId, Long departmentId) throws Exception;
    
    /**
     * 从科室中移除医生
     */
    void removeDoctorFromDepartment(Long doctorId, Long departmentId) throws Exception;
    
    /**
     * 获取所有科室列表
     */
    List<Department> getAllDepartments() throws Exception;
} 