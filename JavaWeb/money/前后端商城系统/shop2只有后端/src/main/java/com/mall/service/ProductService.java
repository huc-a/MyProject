package com.mall.service;

import com.mall.model.Product;
import java.util.List;

public interface ProductService {
    List<Product> getAllProducts();
    Product getProductById(Integer id);
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(Integer id);
    List<Product> searchProducts(String keyword, Integer categoryId);
} 