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
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

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

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
            email.trim().isEmpty() || password.isEmpty()) {

            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        try {
            String passwordHash = hashPassword(password);
            Student student = studentService.loginStudent(email.trim(), passwordHash);

            if (student != null) {
                HttpSession session = request.getSession(true);
                request.changeSessionId();

                session.setAttribute("studentId", student.getStudentId());
                session.setAttribute("studentName", student.getStudentName());
                session.setAttribute("studentEmail", student.getEmail());
                session.setAttribute("studentCareerGoal", student.getCareerGoal());

                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=failed");
        }
    }

    @Override
    public void destroy() {
        if (context != null) {
            context.close();
        }
    }
}
