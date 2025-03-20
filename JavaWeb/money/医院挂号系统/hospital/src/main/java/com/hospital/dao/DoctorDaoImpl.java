package com.hospital.dao;

import com.hospital.model.User;
import com.hospital.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDaoImpl implements DoctorDao {
    
    @Override
    public List<User> findByDepartmentId(Long departmentId) throws Exception {
        List<User> doctors = new ArrayList<>();
        String sql = 
            "SELECT u.* FROM users u " +
            "JOIN doctor_department dd ON u.id = dd.doctor_id " +
            "WHERE dd.department_id = ? AND u.user_type = 'doctor'";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, departmentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                User doctor = new User();
                doctor.setId(rs.getLong("id"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setFullName(rs.getString("full_name"));
                doctor.setUserType(rs.getString("user_type"));
                doctor.setIdCardNumber(rs.getString("id_card_number"));
                doctors.add(doctor);
            }
        }
        
        return doctors;
    }
} 