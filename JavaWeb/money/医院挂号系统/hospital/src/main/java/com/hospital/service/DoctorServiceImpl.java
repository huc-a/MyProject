package com.hospital.service;

import com.hospital.dao.DoctorDao;
import com.hospital.dao.DoctorDaoImpl;
import com.hospital.model.User;
import java.util.List;

public class DoctorServiceImpl implements DoctorService {
    private DoctorDao doctorDao = new DoctorDaoImpl();
    
    @Override
    public List<User> getDoctorsByDepartment(Long departmentId) throws Exception {
        return doctorDao.findByDepartmentId(departmentId);
    }
} 