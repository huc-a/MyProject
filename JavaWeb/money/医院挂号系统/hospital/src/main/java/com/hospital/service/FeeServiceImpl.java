package com.hospital.service;

import com.hospital.dao.FeeDao;
import com.hospital.dao.FeeDaoImpl;
import java.math.BigDecimal;

public class FeeServiceImpl implements FeeService {
    private FeeDao feeDao = new FeeDaoImpl();
    
    @Override
    public BigDecimal getFee(String timeSlot) throws Exception {
        return feeDao.findByTimeSlot(timeSlot);
    }
} 