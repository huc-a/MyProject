package com.hospital.dao;

import com.hospital.model.Department;
import java.util.List;

public interface DepartmentDao {
    /**
     * 查找医生所属的科室
     */
    List<Department> findByDoctorId(Long doctorId) throws Exception;
    
    /**
     * 查找医生可以添加的科室
     */
    List<Department> findAvailableForDoctor(Long doctorId) throws Exception;
    
    /**
     * 添加医生到科室
     */
    void addDoctorToDepartment(Long doctorId, Long departmentId) throws Exception;
    
    /**
     * 从科室中移除医生
     */
    void removeDoctorFromDepartment(Long doctorId, Long departmentId) throws Exception;
    
    /**
     * 查询所有科室
     */
    List<Department> findAll() throws Exception;
} 