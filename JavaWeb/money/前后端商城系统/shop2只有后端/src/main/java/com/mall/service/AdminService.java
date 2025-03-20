package com.mall.service;

import com.mall.model.Admin;

public interface AdminService {
    Admin login(String username, String password);
} 