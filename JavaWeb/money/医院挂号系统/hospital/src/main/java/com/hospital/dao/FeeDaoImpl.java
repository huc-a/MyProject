package com.hospital.dao;

import com.hospital.util.DBUtil;
import java.math.BigDecimal;
import java.sql.*;

public class FeeDaoImpl implements FeeDao {
    
    @Override
    public BigDecimal findByTimeSlot(String timeSlot) throws Exception {
        String sql = "SELECT fee FROM registration_fee WHERE time_slot = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, timeSlot);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getBigDecimal("fee");
            } else {
                throw new Exception("未找到指定时间段的费用信息");
            }
        }
    }
} 