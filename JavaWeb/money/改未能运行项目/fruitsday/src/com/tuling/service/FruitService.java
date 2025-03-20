package com.tuling.service;

import com.tuling.domain.Fruit;

import java.util.List;

public interface FruitService {
    public  Fruit findByFid(int fid);
    public  List<Fruit> findHot();
    public  List<Fruit> findAll();
    public  List<Fruit> search(String keyStr);
    public  boolean add(Fruit fruit);
    public  boolean del(int fid);
    public  boolean update(Fruit fruit);
}
