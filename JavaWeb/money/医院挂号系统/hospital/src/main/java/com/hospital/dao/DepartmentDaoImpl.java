package com.hospital.dao;

import com.hospital.model.Department;
import com.hospital.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDaoImpl implements DepartmentDao {
    
    @Override
    public List<Department> findByDoctorId(Long doctorId) throws Exception {
        List<Department> departments = new ArrayList<>();
        String sql = 
            "SELECT d.* FROM department d " +
            "JOIN doctor_department dd ON d.id = dd.department_id " +
            "WHERE dd.doctor_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                departments.add(new Department(
                    rs.getLong("id"),
                    rs.getString("name"),
                    rs.getString("description")
                ));
            }
            return departments;
        } catch (Exception e) {
            e.printStackTrace(); // 打印详细错误信息
            throw e;
        }
    }
    
    @Override
    public List<Department> findAvailableForDoctor(Long doctorId) throws Exception {
        List<Department> departments = new ArrayList<>();
        String sql = 
            "SELECT * FROM department d " +
            "WHERE d.id NOT IN (" +
            "  SELECT department_id FROM doctor_department WHERE doctor_id = ?" +
            "  UNION " +
            "  SELECT -1" + // 添加一个永远不存在的ID，避免空集合的情况
            ")";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                departments.add(new Department(
                    rs.getLong("id"),
                    rs.getString("name"),
                    rs.getString("description")
                ));
            }
            return departments;
        } catch (Exception e) {
            e.printStackTrace(); // 打印详细错误信息
            throw e;
        }
    }
    
    @Override
    public void addDoctorToDepartment(Long doctorId, Long departmentId) throws Exception {
        String sql = "INSERT INTO doctor_department (doctor_id, department_id) VALUES (?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, doctorId);
            stmt.setLong(2, departmentId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // 打印详细错误信息
            throw e;
        }
    }
    
    @Override
    public void removeDoctorFromDepartment(Long doctorId, Long departmentId) throws Exception {
        String sql = "DELETE FROM doctor_department WHERE doctor_id = ? AND department_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, doctorId);
            stmt.setLong(2, departmentId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // 打印详细错误信息
            throw e;
        }
    }
    
    @Override
    public List<Department> findAll() throws Exception {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM department ORDER BY name";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Department dept = new Department();
                dept.setId(rs.getLong("id"));
                dept.setName(rs.getString("name"));
                dept.setDescription(rs.getString("description"));
                departments.add(dept);
            }
        }
        
        return departments;
    }
} 