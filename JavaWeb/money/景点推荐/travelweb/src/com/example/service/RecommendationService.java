package com.example.service;

import com.example.model.Attraction;
import java.util.List;

public interface RecommendationService {
    /**
     * 根据用户ID获取推荐的景点列表
     * @param userId 用户ID
     * @return 推荐的景点列表
     */
    List<Attraction> getRecommendations(int userId);
} 