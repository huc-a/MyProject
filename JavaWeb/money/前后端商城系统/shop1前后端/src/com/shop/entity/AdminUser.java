package com.shop.entity;

import java.util.Date;

/**
 * 管理员用户实体类
 */
public class AdminUser {

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

    /** 创建日期 */
    private Date createDatetime;

    /** 更新时间 */
    private Date updateDatetime;

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
        return "AdminUser{" +
                "username=" + username +
                ", password=" + password +
                ", realName=" + realName +
                ", sex=" + sex +
                ", birthday=" + birthday +
                ", createDatetime=" + createDatetime +
                ", updateDatetime=" + updateDatetime +
        '}';
    }
}
