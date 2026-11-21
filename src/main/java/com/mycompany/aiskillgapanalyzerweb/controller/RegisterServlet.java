package com.mycompany.aiskillgapanalyzerweb.controller;

import com.mycompany.aiskillgapanalyzerweb.config.SpringConfig;
import com.mycompany.aiskillgapanalyzerweb.model.Student;
import com.mycompany.aiskillgapanalyzerweb.service.StudentService;

import java.io.IOException;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private AnnotationConfigApplicationContext context;
    private StudentService studentService;

    @Override
    public void init() throws ServletException {
        context = new AnnotationConfigApplicationContext(SpringConfig.class);
        studentService = context.getBean(StudentService.class);
    }

    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(hash);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("student_name");
        String email = request.getParameter("email");
        String careerGoal = request.getParameter("career_goal");
        String password = request.getParameter("password");

        if (name == null || email == null ||
            careerGoal == null || password == null ||
            name.trim().isEmpty() || email.trim().isEmpty() ||
            careerGoal.trim().isEmpty() || password.length() < 6) {

            response.sendRedirect("register.jsp?error=invalid");
            return;
        }

        try {
            // Check if email already registered
            if (studentService.isEmailRegistered(email.trim())) {
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            Student student = new Student();
            student.setStudentName(name.trim());
            student.setEmail(email.trim());
            student.setCareerGoal(careerGoal.trim());
            student.setPasswordHash(hashPassword(password));

            boolean result = studentService.registerStudent(student);

            if (result) {
                response.sendRedirect("login.jsp?success=registered");
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=failed");
        }
    }

    @Override
    public void destroy() {
        if (context != null) {
            context.close();
        }
    }
}
