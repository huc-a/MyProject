package com.hospital.service;

import com.hospital.model.User;

public interface UserService {
    /**
     * 用户登录
     * @param fullName 用户名
     * @param password 密码
     * @return 登录成功返回用户对象，失败返回null
     */
    User login(String fullName, String password) throws Exception;
    
    /**
     * 用户注册
     * @param user 用户信息
     * @return 注册成功返回true，失败返回false
     */
    boolean register(User user) throws Exception;
} 