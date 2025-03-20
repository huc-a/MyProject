package com.example.service;

import com.example.bean.Student;
import java.util.List;

public interface StudentService {
    void addStudent(Student student) throws Exception;
    void updateStudent(Student student) throws Exception;
    void deleteStudent(Integer id) throws Exception;
    Student getStudentById(Integer id) throws Exception;
    List<Student> getAllStudents() throws Exception;
    List<Student> searchStudents(String keyword) throws Exception;
} 