package com.hospital.dao;

import com.hospital.model.User;

public interface UserDao {
    /**
     * 根据用户名查找用户
     * @param fullName 用户名
     * @return 用户对象，如果不存在返回null
     */
    User findByFullName(String fullName) throws Exception;
    
    /**
     * 保存用户信息
     * @param user 用户信息
     * @return 保存成功返回true，失败返回false
     */
    boolean save(User user) throws Exception;
} 