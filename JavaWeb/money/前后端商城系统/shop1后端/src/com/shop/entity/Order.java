package com.shop.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单实体类
 */
public class Order {

    /** 主键id */
    private String id;

    /** 用户名 */
    private String userPhone;

    /** 总价格 */
    private BigDecimal totalPrice;

    /** 发货时间 */
    private Date issueDatetime;

    /** 签收时间 */
    private Date receivedDatetime;

    /** 创建日期 */
    private Date createDatetime;

    /** 更新时间 */
    private Date updateDatetime;

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setIssueDatetime(Date issueDatetime) {
        this.issueDatetime = issueDatetime;
    }

    public Date getIssueDatetime() {
        return issueDatetime;
    }

    public void setReceivedDatetime(Date receivedDatetime) {
        this.receivedDatetime = receivedDatetime;
    }

    public Date getReceivedDatetime() {
        return receivedDatetime;
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
        return "Order{" +
                "id=" + id +
                ", userPhone=" + userPhone +
                ", totalPrice=" + totalPrice +
                ", issueDatetime=" + issueDatetime +
                ", receivedDatetime=" + receivedDatetime +
                ", createDatetime=" + createDatetime +
                ", updateDatetime=" + updateDatetime +
        '}';
    }
}
