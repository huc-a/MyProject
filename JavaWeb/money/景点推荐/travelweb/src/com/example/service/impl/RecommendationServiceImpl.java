package com.example.service.impl;

import com.example.dao.AttractionDao;
import com.example.model.Attraction;
import com.example.service.RecommendationService;
import com.example.util.DaoFactory;

import java.util.List;

public class RecommendationServiceImpl implements RecommendationService {
    private AttractionDao attractionDao = DaoFactory.getAttractionDao();

    @Override
    public List<Attraction> getRecommendations(int userId) {
        // 基于用户兴趣和浏览历史推荐景点
        return attractionDao.getRecommendedAttractions(userId);
    }
} 