package com.mall.dao;

import com.mall.model.Category;
import java.util.List;

public interface CategoryDao {
    List<Category> findAll();
    Category findById(Integer id);
    boolean add(Category category);
    boolean update(Category category);
    boolean delete(Integer id);
} 