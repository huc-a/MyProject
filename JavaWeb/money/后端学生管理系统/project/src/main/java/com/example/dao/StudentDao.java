package com.example.dao;

import com.example.bean.Student;
import java.util.List;

public interface StudentDao {
    void add(Student student) throws Exception;
    void update(Student student) throws Exception;
    void delete(Integer id) throws Exception;
    Student findById(Integer id) throws Exception;
    List<Student> findAll() throws Exception;
    List<Student> search(String keyword) throws Exception;
} 