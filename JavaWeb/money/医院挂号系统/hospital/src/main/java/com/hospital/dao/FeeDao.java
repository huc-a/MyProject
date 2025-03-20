package com.hospital.dao;

import java.math.BigDecimal;

public interface FeeDao {
    /**
     * 根据时间段查找挂号费用
     */
    BigDecimal findByTimeSlot(String timeSlot) throws Exception;
} 