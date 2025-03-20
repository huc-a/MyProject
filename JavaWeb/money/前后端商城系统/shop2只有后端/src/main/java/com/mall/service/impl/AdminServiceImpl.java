package com.mall.service.impl;

import com.mall.dao.AdminDao;
import com.mall.dao.impl.AdminDaoImpl;
import com.mall.model.Admin;
import com.mall.service.AdminService;

public class AdminServiceImpl implements AdminService {
    private AdminDao adminDao = new AdminDaoImpl();

    @Override
    public Admin login(String username, String password) {
        Admin admin = adminDao.findByUsername(username);
        if (admin != null && admin.getPassword().equals(password)) {
            return admin;
        }
        return null;
    }
} 