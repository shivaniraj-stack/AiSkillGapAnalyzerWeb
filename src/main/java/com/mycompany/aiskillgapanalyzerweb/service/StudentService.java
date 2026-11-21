package com.mycompany.aiskillgapanalyzerweb.service;

import com.mycompany.aiskillgapanalyzerweb.dao.StudentDAO;
import com.mycompany.aiskillgapanalyzerweb.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    private StudentDAO studentDAO;

    public Student loginStudent(String email, String passwordHash) {
        return studentDAO.loginStudent(email, passwordHash);
    }

    public boolean registerStudent(Student student) {
        return studentDAO.saveStudent(student);
    }

    public boolean isEmailRegistered(String email) {
        return studentDAO.isEmailRegistered(email);
    }

    public Student getStudentById(int studentId) {
        return studentDAO.getStudentById(studentId);
    }

    public boolean updateCareerGoal(int studentId, String careerGoal) {
        return studentDAO.updateCareerGoal(studentId, careerGoal);
    }

    public String getWelcomeMessage(String studentName) {
        return "Welcome " + studentName + "! Welcome to AI Skill Gap Analyzer.";
    }
}
