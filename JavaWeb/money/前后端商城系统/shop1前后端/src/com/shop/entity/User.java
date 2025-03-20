package com.shop.entity;

import java.util.Date;

/**
 * 用户实体类
 */
public class User {

    /** 手机号 */
    private String phone;

    /** 用户名 */
    private String username;

    /** 密码 */
    private String password;

    /** 真实姓名 */
    private String realName;

    /** 性别 */
    private String sex;

    /** 生日 */
    private Date birthday;

    /** 收货地址 */
    private String address;

    /** 创建时间 */
    private Date createDatetime;

    /** 更新时间 */
    private Date updateDatetime;

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPhone() {
        return phone;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getRealName() {
        return realName;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getSex() {
        return sex;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress() {
        return address;
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
        return "User{" +
                "phone=" + phone +
                ", username=" + username +
                ", password=" + password +
                ", realName=" + realName +
                ", sex=" + sex +
                ", birthday=" + birthday +
                ", address=" + address +
                ", createDatetime=" + createDatetime +
                ", updateDatetime=" + updateDatetime +
        '}';
    }
}
