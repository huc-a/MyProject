package com.example.dao;

import com.example.model.User;
import java.util.List;

public interface UserDao {
    // 用户认证相关
    User findUserByUsernameAndPassword(String username, String password);
    void addUser(User user);
    
    // 用户收藏相关
    void addFavorite(User user, String attractionId);
    
    // 用户兴趣相关
    List<String> getInterests(int userId);
}
