package com.example.dao;

import com.example.model.Attraction;
import java.util.List;
import java.util.Map;

public interface AttractionDao {
    void addAttraction(Attraction attraction);
    List<Attraction> filterAttractions(Integer categoryId, String city, Double minPrice, Double maxPrice, String level);
    List<String> getAllCities();
    List<Map<String, Object>> getAllCategories();
    List<String> getAllLevels();
    List<Attraction> getRecommendedAttractions(int userId);
    List<Attraction> getAllAttractions();
    boolean deleteAttraction(int id);
    boolean updateAttraction(Attraction attraction);
}
