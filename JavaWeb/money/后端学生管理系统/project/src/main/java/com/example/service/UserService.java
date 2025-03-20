package com.example.service;

import com.example.bean.User;
import java.util.List;

public interface UserService {
    void addUser(User user) throws Exception;
    void updateUser(User user) throws Exception;
    void deleteUser(Integer id) throws Exception;
    User getUserById(Integer id) throws Exception;
    List<User> getAllUsers() throws Exception;
    User login(String username, String password) throws Exception;
} 