package com.mall.service.impl;

import com.mall.dao.ProductDao;
import com.mall.dao.impl.ProductDaoImpl;
import com.mall.model.Product;
import com.mall.service.ProductService;
import java.util.List;

public class ProductServiceImpl implements ProductService {
    private ProductDao productDao = new ProductDaoImpl();

    @Override
    public List<Product> getAllProducts() {
        return productDao.findAll();
    }

    @Override
    public Product getProductById(Integer id) {
        return productDao.findById(id);
    }

    @Override
    public boolean addProduct(Product product) {
        return productDao.add(product);
    }

    @Override
    public boolean updateProduct(Product product) {
        return productDao.update(product);
    }

    @Override
    public boolean deleteProduct(Integer id) {
        return productDao.delete(id);
    }

    @Override
    public List<Product> searchProducts(String keyword, Integer categoryId) {
        return productDao.search(keyword, categoryId);
    }
} 