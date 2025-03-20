package com.shop.service;

import java.math.BigDecimal;
import java.util.List;

import com.shop.dao.GoodsDao;
import com.shop.entity.Goods;
import com.shop.entity.OrderDetails;

import com.shop.dao.OrderDetailsDao;
import com.shop.entity.ShopCar;

/**
 * 订单详情业务处理类
 */
public class OrderDetailsService {

    // 创建数据库操作对象
    private OrderDetailsDao orderDetailsDao = new OrderDetailsDao();
    private GoodsDao goodsDao = new GoodsDao();

    /**
     * 添加订单详情
     * @param orderDetails
     * @return
     */
    public int add(OrderDetails orderDetails) {
        return orderDetailsDao.add(orderDetails);
    }

    /**
     * 删除订单详情
     * @param orderId
     * @return
     */
    public int delete(String orderId) {
        return orderDetailsDao.delete(orderId);
    }

    /**
     * 更新订单详情
     * @param orderDetails
     * @return
     */
    public int update(OrderDetails orderDetails) {
        return orderDetailsDao.update(orderDetails);
    }

    /**
     * 获取订单详情
     * @return
     */
    public List<OrderDetails> getAllOrderDetails(String orderId) {
        List<OrderDetails> list = orderDetailsDao.getAllOrderDetails(orderId);
        Goods goods = null;
        for (OrderDetails item: list){
            goods = goodsDao.getGoodsById(item.getGoodsId());
            item.setGoodsInfo(goods);
        }
        return list;
    }

    /**
     * 根据orderId获取订单详情详情
     * @param orderId
     * @return
     */
    public OrderDetails getOrderDetailsByOrderId(String orderId) {
        return orderDetailsDao.getOrderDetailsByOrderId(orderId);
    }
}
