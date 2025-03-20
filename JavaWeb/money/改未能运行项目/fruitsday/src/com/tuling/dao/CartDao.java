package com.tuling.dao;



import com.tuling.domain.Cart;
import java.util.List;


public interface CartDao {
    //创建用户的购物车
    public boolean createCart(int uid);
    //删除购物车项
    public int del(int uid,int fid);
    //显示购物车列表
    public List<Cart> show(int uid);
    //加入购物车
    public int add(int uid,Cart cart);
    //查找
    public Cart find(int uid,int fid);
    //修改
    public int update(int uid,Cart cart);

}
