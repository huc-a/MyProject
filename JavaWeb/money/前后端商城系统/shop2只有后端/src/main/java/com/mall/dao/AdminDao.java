package com.mall.dao;

import com.mall.model.Admin;

public interface AdminDao {
    Admin findByUsername(String username);
} 