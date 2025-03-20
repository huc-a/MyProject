package com.example.bean;

public class Student {
    private Integer studentId;
    private String studentName;
    private String studentGender;
    private Integer studentAge;
    private String studentClass;
    
    // 构造函数
    public Student() {}
    
    public Student(Integer studentId, String studentName, String studentGender, 
                  Integer studentAge, String studentClass) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.studentGender = studentGender;
        this.studentAge = studentAge;
        this.studentClass = studentClass;
    }
    
    // getter和setter方法
    public Integer getStudentId() {
        return studentId;
    }
    
    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getStudentGender() {
        return studentGender;
    }
    
    public void setStudentGender(String studentGender) {
        this.studentGender = studentGender;
    }
    
    public Integer getStudentAge() {
        return studentAge;
    }
    
    public void setStudentAge(Integer studentAge) {
        this.studentAge = studentAge;
    }
    
    public String getStudentClass() {
        return studentClass;
    }
    
    public void setStudentClass(String studentClass) {
        this.studentClass = studentClass;
    }
} 