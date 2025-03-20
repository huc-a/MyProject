package com.shop.service;

import java.util.List;
import com.shop.entity.Goods;

import com.shop.dao.GoodsDao;

/**
 * 商品业务处理类
 */
public class GoodsService {

    // 创建数据库操作对象
    private GoodsDao goodsDao = new GoodsDao();

    /**
     * 添加商品
     * @param goods
     * @return
     */
    public int add(Goods goods) {
        return goodsDao.add(goods);
    }

    /**
     * 删除商品
     * @param id
     * @return
     */
    public int delete(String id) {
        return goodsDao.delete(id);
    }

    /**
     * 更新商品
     * @param goods
     * @return
     */
    public int update(Goods goods) {
        return goodsDao.update(goods);
    }

    /**
     * 获取商品
     * @return
     */
    public List<Goods> getAllGoods(String name, String brand) {
        return goodsDao.getAllGoods(name, brand);
    }

    /**
     * 根据id获取商品详情
     * @param id
     * @return
     */
    public Goods getGoodsById(String id) {
        return goodsDao.getGoodsById(id);
    }
}
