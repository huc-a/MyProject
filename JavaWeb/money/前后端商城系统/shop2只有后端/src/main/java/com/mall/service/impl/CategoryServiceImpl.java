package com.mall.service.impl;

import com.mall.dao.CategoryDao;
import com.mall.dao.impl.CategoryDaoImpl;
import com.mall.model.Category;
import com.mall.service.CategoryService;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public List<Category> getAllCategories() {
        return categoryDao.findAll();
    }

    @Override
    public Category getCategoryById(Integer id) {
        return categoryDao.findById(id);
    }

    @Override
    public boolean addCategory(Category category) {
        return categoryDao.add(category);
    }

    @Override
    public boolean updateCategory(Category category) {
        return categoryDao.update(category);
    }

    @Override
    public boolean deleteCategory(Integer id) {
        return categoryDao.delete(id);
    }
} 