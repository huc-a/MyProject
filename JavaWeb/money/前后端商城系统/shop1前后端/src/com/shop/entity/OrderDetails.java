package com.shop.entity;

import java.math.BigDecimal;

/**
 * 订单详情实体类
 */
public class OrderDetails {

    /** 订单id */
    private String orderId;

    /** 商品id */
    private String goodsId;

    /** 数量 */
    private Integer count;

    /** 小计 */
    private BigDecimal subTotal;

    // 商品详情
    private Goods goodsInfo;

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsId() {
        return goodsId;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getCount() {
        return count;
    }

    public void setSubTotal(BigDecimal subTotal) {
        this.subTotal = subTotal;
    }

    public BigDecimal getSubTotal() {
        return subTotal;
    }

    public Goods getGoodsInfo() {
        return goodsInfo;
    }

    public void setGoodsInfo(Goods goodsInfo) {
        this.goodsInfo = goodsInfo;
    }

    @Override
    public String toString() {
        return "OrderDetails{" +
                "orderId=" + orderId +
                ", goodsId=" + goodsId +
                ", count=" + count +
                ", subTotal=" + subTotal +
        '}';
    }
}
