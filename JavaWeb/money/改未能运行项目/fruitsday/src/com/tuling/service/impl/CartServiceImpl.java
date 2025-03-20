package com.tuling.service.impl;

import com.tuling.dao.CartDao;
import com.tuling.dao.FruitDao;
import com.tuling.dao.impl.CartDaoImpl;
import com.tuling.dao.impl.FruitDaoImpl;
import com.tuling.domain.Cart;
import com.tuling.domain.Fruit;
import com.tuling.service.CartService;
import com.tuling.service.FruitService;

import java.util.ArrayList;
import java.util.List;

public class CartServiceImpl implements CartService {
    private CartDao cartDao = new CartDaoImpl();
    private FruitDao fruitDao = new FruitDaoImpl();
    @Override
    public boolean del(int uid, int fid) {
        int num=cartDao.del(uid,fid);
        if(num==1)
            return true;
        else
            return false;
    }

    @Override
    public List<Cart> showAll(int uid) {
        return cartDao.show(uid);
    }

    @Override
    public List<Fruit> show(int uid, boolean flag) {
        //根据用户id获取所有的购物车项
        List<Cart> cartList = showAll(uid);

        List<Fruit> fruits=new ArrayList<Fruit>();
        if(flag){//购物车列表
            for (Cart cart : cartList) {
                if(cart.isCart()){
                    Fruit fruit = fruitDao.findByFid(cart.getFid());
                    fruits.add(fruit);
                }
            }
        }else{//关注列表
            for (Cart cart : cartList) {
                if(cart.isStar()){
                    Fruit fruit = fruitDao.findByFid(cart.getFid());
                    fruits.add(fruit);
                }
            }
        }

        return fruits;
    }

    @Override
    public boolean add(int uid, Cart cart) {
        int num = cartDao.add(uid,cart);
        if(num==1){
            return true;
        }else{
            return false;
        }
    }

    @Override
    public Cart find(int uid, int fid) {
        return cartDao.find(uid,fid);
    }

    @Override
    public boolean update(int uid, Cart cart) {
        int num=cartDao.update(uid,cart);
        if(num==1)
            return true;
        else
            return false;
    }
}
