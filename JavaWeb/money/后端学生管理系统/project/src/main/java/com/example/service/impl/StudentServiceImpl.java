package com.example.service.impl;

import com.example.bean.Student;
import com.example.dao.StudentDao;
import com.example.dao.impl.StudentDaoImpl;
import com.example.service.StudentService;
import java.util.List;

public class StudentServiceImpl implements StudentService {
    private StudentDao studentDao = new StudentDaoImpl();

    @Override
    public void addStudent(Student student) throws Exception {
        studentDao.add(student);
    }

    @Override
    public void updateStudent(Student student) throws Exception {
        studentDao.update(student);
    }

    @Override
    public void deleteStudent(Integer id) throws Exception {
        studentDao.delete(id);
    }

    @Override
    public Student getStudentById(Integer id) throws Exception {
        return studentDao.findById(id);
    }

    @Override
    public List<Student> getAllStudents() throws Exception {
        return studentDao.findAll();
    }

    @Override
    public List<Student> searchStudents(String keyword) throws Exception {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllStudents();
        }
        return studentDao.search(keyword.trim());
    }
} 