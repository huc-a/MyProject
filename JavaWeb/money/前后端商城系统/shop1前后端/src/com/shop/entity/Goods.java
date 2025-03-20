package com.shop.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 商品实体类
 */
public class Goods {

    /** 主键id */
    private String id;

    /** 名称 */
    private String name;

    /** 品牌 */
    private String brand;

    /** 价格 */
    private BigDecimal price;

    /** 库存 */
    private Integer stock;

    /** 图片 */
    private String fileName;

    /** 备注 */
    private String remark;

    /** 是否删除 默认0 0:未删除  1：已删除*/
    private String isDelete;

    /** 创建时间 */
    private Date createDatetime;

    /** 更新时间 */
    private Date updateDatetime;

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getBrand() {
        return brand;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Integer getStock() {
        return stock;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileName() {
        return fileName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete;
    }

    public String getIsDelete() {
        return isDelete;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setUpdateDatetime(Date updateDatetime) {
        this.updateDatetime = updateDatetime;
    }

    public Date getUpdateDatetime() {
        return updateDatetime;
    }


    @Override
    public String toString() {
        return "Goods{" +
                "id=" + id +
                ", name=" + name +
                ", brand=" + brand +
                ", price=" + price +
                ", stock=" + stock +
                ", fileName=" + fileName +
                ", remark=" + remark +
                ", isDelete=" + isDelete +
                ", createDatetime=" + createDatetime +
                ", updateDatetime=" + updateDatetime +
        '}';
    }
}
