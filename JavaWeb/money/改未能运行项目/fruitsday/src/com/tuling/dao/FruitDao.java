package com.tuling.dao;

import com.tuling.domain.Fruit;

import java.util.List;

public interface FruitDao {
    //根据商品编号查找
    public Fruit findByFid(int fid);
    //热卖商品
    public List<Fruit> findHot();

    //全部商品
    public List<Fruit> findAll();

    //添加商品
    public int add(Fruit fruit);
    //删除商品
    public int del(int fid);

    //更新商品
    public int update(Fruit fruit);
}
