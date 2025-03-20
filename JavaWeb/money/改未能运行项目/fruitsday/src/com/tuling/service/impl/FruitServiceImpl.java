package com.tuling.service.impl;

import com.tuling.dao.FruitDao;
import com.tuling.dao.impl.FruitDaoImpl;
import com.tuling.domain.Fruit;
import com.tuling.service.FruitService;

import java.util.ArrayList;
import java.util.List;

public class FruitServiceImpl implements FruitService {
    private FruitDao fruitDao = new FruitDaoImpl();
    @Override
    public Fruit findByFid(int fid) {
        Fruit fruit=fruitDao.findByFid(fid);

        if(fruit==null)
        {
            fruit=new Fruit(1,"商品不存在","",0,"","",0);
        }

        return fruit;
    }

    @Override
    public List<Fruit> findHot() {
        return  fruitDao.findHot();
    }

    @Override
    public List<Fruit> findAll() {
        return fruitDao.findAll();
    }

    @Override
    public List<Fruit> search(String keyStr) {
        List<Fruit> fruits= fruitDao.findAll();
        List<Fruit> resultList=new ArrayList<Fruit>();
        for(Fruit fruit:fruits)
        {
            if(keyStr.indexOf(fruit.getFname())!=-1)
                resultList.add(fruit);
            else if(fruit.getFname().indexOf(keyStr)!=-1)
                resultList.add(fruit);
        }
        return resultList;
    }

    @Override
    public boolean add(Fruit fruit) {
        int num=fruitDao.add(fruit);
        if(num==1)
            return true;
        else
            return false;
    }

    @Override
    public boolean del(int fid) {
        int num=fruitDao.del(fid);
        if(num==1)
            return true;
        else
            return false;
    }

    @Override
    public boolean update(Fruit fruit) {
        int num=fruitDao.update(fruit);
        if(num==1)
            return true;
        else
            return false;
    }
}
