package com.hospital.model;

public class User {
    private Long id;
    private String phone;
    private String password;
    private String fullName;
    private String userType;
    private String idCardNumber;
    
    // 构造函数
    public User() {}
    
    public User(String phone, String password, String fullName, String userType, String idCardNumber) {
        this.phone = phone;
        this.password = password;
        this.fullName = fullName;
        this.userType = userType;
        this.idCardNumber = idCardNumber;
    }
    
    // Getter和Setter方法
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getIdCardNumber() {
        return idCardNumber;
    }

    public void setIdCardNumber(String idCardNumber) {
        this.idCardNumber = idCardNumber;
    }
} 