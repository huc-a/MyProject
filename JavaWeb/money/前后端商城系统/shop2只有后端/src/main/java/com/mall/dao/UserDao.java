package com.mall.dao;

import com.mall.model.User;
import java.util.List;

public interface UserDao {
    List<User> findAll();
    User findById(Integer id);
    User findByUsername(String username);
    List<User> search(String keyword);
    boolean delete(Integer id);
    boolean update(User user);
} 