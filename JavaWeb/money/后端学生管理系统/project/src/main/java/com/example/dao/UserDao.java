package com.example.dao;

import com.example.bean.User;
import java.util.List;

public interface UserDao {
    void add(User user) throws Exception;
    void update(User user) throws Exception;
    void delete(Integer id) throws Exception;
    User findById(Integer id) throws Exception;
    User findByUsername(String username) throws Exception;
    List<User> findAll() throws Exception;
    User findByUsernameAndPassword(String username, String password) throws Exception;
} 