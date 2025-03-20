package com.hospital.service;

import com.hospital.dao.DepartmentDao;
import com.hospital.dao.DepartmentDaoImpl;
import com.hospital.model.Department;
import java.util.List;

public class DepartmentServiceImpl implements DepartmentService {
    private DepartmentDao departmentDao = new DepartmentDaoImpl();
    
    @Override
    public List<Department> getDoctorDepartments(Long doctorId) throws Exception {
        return departmentDao.findByDoctorId(doctorId);
    }
    
    @Override
    public List<Department> getAvailableDepartments(Long doctorId) throws Exception {
        return departmentDao.findAvailableForDoctor(doctorId);
    }
    
    @Override
    public void addDoctorToDepartment(Long doctorId, Long departmentId) throws Exception {
        departmentDao.addDoctorToDepartment(doctorId, departmentId);
    }
    
    @Override
    public void removeDoctorFromDepartment(Long doctorId, Long departmentId) throws Exception {
        departmentDao.removeDoctorFromDepartment(doctorId, departmentId);
    }
    
    @Override
    public List<Department> getAllDepartments() throws Exception {
        return departmentDao.findAll();
    }
} 