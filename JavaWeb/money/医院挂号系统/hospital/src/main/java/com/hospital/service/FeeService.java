package com.hospital.service;

import java.math.BigDecimal;

public interface FeeService {
    /**
     * 获取指定时间段的挂号费用
     */
    BigDecimal getFee(String timeSlot) throws Exception;
} 