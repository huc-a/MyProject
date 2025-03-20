package com.example.dao.impl;

import com.example.bean.Student;
import com.example.dao.StudentDao;
import com.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDaoImpl implements StudentDao {
    @Override
    public void add(Student student) throws Exception {
        String sql = "INSERT INTO students (student_name, student_gender, student_age, student_class) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getStudentName());
            pstmt.setString(2, student.getStudentGender());
            pstmt.setInt(3, student.getStudentAge());
            pstmt.setString(4, student.getStudentClass());
            pstmt.executeUpdate();
        }
    }

    @Override
    public void update(Student student) throws Exception {
        String sql = "UPDATE students SET student_name=?, student_gender=?, student_age=?, student_class=? WHERE student_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getStudentName());
            pstmt.setString(2, student.getStudentGender());
            pstmt.setInt(3, student.getStudentAge());
            pstmt.setString(4, student.getStudentClass());
            pstmt.setInt(5, student.getStudentId());
            pstmt.executeUpdate();
        }
    }

    @Override
    public void delete(Integer id) throws Exception {
        String sql = "DELETE FROM students WHERE student_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    @Override
    public Student findById(Integer id) throws Exception {
        String sql = "SELECT * FROM students WHERE student_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }
            return null;
        }
    }

    @Override
    public List<Student> findAll() throws Exception {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
            return students;
        }
    }

    @Override
    public List<Student> search(String keyword) throws Exception {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE student_name LIKE ? OR student_class LIKE ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            pstmt.setString(1, pattern);
            pstmt.setString(2, pattern);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
            return students;
        }
    }

    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setStudentName(rs.getString("student_name"));
        student.setStudentGender(rs.getString("student_gender"));
        student.setStudentAge(rs.getInt("student_age"));
        student.setStudentClass(rs.getString("student_class"));
        return student;
    }
} 