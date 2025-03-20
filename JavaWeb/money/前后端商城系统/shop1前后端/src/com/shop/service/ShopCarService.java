package com.shop.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.shop.dao.GoodsDao;
import com.shop.entity.Goods;
import com.shop.entity.ShopCar;

import com.shop.dao.ShopCarDao;

/**
 * 购物车业务处理类
 */
public class ShopCarService {

    // 创建数据库操作对象
    private ShopCarDao shopCarDao = new ShopCarDao();
    private GoodsDao goodsDao = new GoodsDao();

    /**
     * 添加购物车
     * @param shopCar
     * @return
     */
    public int add(ShopCar shopCar) {
        return shopCarDao.add(shopCar);
    }

    /**
     * 删除购物车
     * @param id
     * @return
     */
    public int delete(Integer id) {
        return shopCarDao.delete(id);
    }

    /**
     * 更新购物车
     * @param shopCar
     * @return
     */
    public int update(ShopCar shopCar) {
        return shopCarDao.update(shopCar);
    }

    /**
     * 获取购物车
     * @return
     */
    public List<ShopCar> getAllShopCar(String createUser) {
        List<ShopCar> list = shopCarDao.getAllShopCar(createUser);
        Goods goods = null;
        for (ShopCar item: list){
            goods = goodsDao.getGoodsById(item.getGoodsId());
            item.setGoodsInfo(goods);
            item.setSubTotal(goods.getPrice().multiply(new BigDecimal(item.getCount())));
        }
        return list;
    }

    /**
     * 根据id获取购物车详情
     * @param id
     * @return
     */
    public ShopCar getShopCarById(Integer id) {
        return shopCarDao.getShopCarById(id);
    }

    /**
     * 根据用户和商品查询
     * @param phone
     * @param goodsId
     * @return
     */
    public ShopCar getShopCarByUserAndGoodsId(String phone, String goodsId) {
        return shopCarDao.getShopCarByUserAndGoodsId(phone, goodsId);
    }
}
