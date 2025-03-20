package com.hospital.dao;

import com.hospital.model.User;
import java.util.List;

public interface DoctorDao {
    /**
     * 根据科室ID查找医生
     */
    List<User> findByDepartmentId(Long departmentId) throws Exception;
} 