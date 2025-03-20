package com.mall.service;

import com.mall.model.Category;
import java.util.List;

public interface CategoryService {
    List<Category> getAllCategories();
    Category getCategoryById(Integer id);
    boolean addCategory(Category category);
    boolean updateCategory(Category category);
    boolean deleteCategory(Integer id);
} 