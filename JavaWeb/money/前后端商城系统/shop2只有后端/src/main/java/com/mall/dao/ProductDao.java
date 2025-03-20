package com.mall.dao;

import com.mall.model.Product;
import java.util.List;

public interface ProductDao {
    List<Product> findAll();
    Product findById(Integer id);
    boolean add(Product product);
    boolean update(Product product);
    boolean delete(Integer id);
    List<Product> findByCategory(Integer categoryId);
    List<Product> search(String keyword, Integer categoryId);
} 