package com.shop.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 购物车实体类
 */
public class ShopCar {

    /** id */
    private Integer id;

    /** 商品id */
    private String goodsId;

    /** 数量 */
    private Integer count;

    /** 小计 */
    private BigDecimal subTotal;

    /** 创建人 */
    private String createUser;

    /** 创建日期 */
    private Date createDatetime;

    private Goods goodsInfo;

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
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

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public Goods getGoodsInfo() {
        return goodsInfo;
    }

    public void setGoodsInfo(Goods goodsInfo) {
        this.goodsInfo = goodsInfo;
    }

    @Override
    public String toString() {
        return "ShopCar{" +
                "id=" + id +
                ", goodsId=" + goodsId +
                ", count=" + count +
                ", subTotal=" + subTotal +
                ", createUser=" + createUser +
                ", createDatetime=" + createDatetime +
        '}';
    }
}
