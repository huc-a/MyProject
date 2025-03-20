package com.mall.service;

import com.mall.model.User;
import java.util.List;

public interface UserService {
    List<User> getAllUsers();
    User getUserById(Integer id);
    User getUserByUsername(String username);
    List<User> searchUsers(String keyword);
    boolean deleteUser(Integer id);
    boolean updateUser(Integer id, String username, String password, String phone, String email);
} 