package com.tuling.service;

import com.tuling.domain.Cart;
import com.tuling.domain.Fruit;

import java.util.List;

public interface CartService {

    public  boolean del(int uid,int fid);
    public  List<Cart> showAll(int uid);
    public  List<Fruit> show(int uid, boolean flag);
    public  boolean add(int uid,Cart cart);
    public  Cart find(int uid,int fid);
    public  boolean update(int uid,Cart cart);
}
