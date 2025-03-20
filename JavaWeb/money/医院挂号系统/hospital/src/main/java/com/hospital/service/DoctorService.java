package com.hospital.service;

import com.hospital.model.User;
import java.util.List;

public interface DoctorService {
    /**
     * 获取指定科室的医生列表
     */
    List<User> getDoctorsByDepartment(Long departmentId) throws Exception;
} 