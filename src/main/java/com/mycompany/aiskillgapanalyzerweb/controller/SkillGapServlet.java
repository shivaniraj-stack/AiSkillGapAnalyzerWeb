package com.mycompany.aiskillgapanalyzerweb.controller;

import com.mycompany.aiskillgapanalyzerweb.config.SpringConfig;
import com.mycompany.aiskillgapanalyzerweb.model.Career;
import com.mycompany.aiskillgapanalyzerweb.service.AiRoadmapService;
import com.mycompany.aiskillgapanalyzerweb.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

@WebServlet("/SkillGapServlet")
public class SkillGapServlet extends HttpServlet {

    private AnnotationConfigApplicationContext context;
    private AiRoadmapService aiRoadmapService;

    @Override
    public void init() throws ServletException {
        context = new AnnotationConfigApplicationContext(SpringConfig.class);
        aiRoadmapService = context.getBean(AiRoadmapService.class);
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");
        String careerParam = request.getParameter("careerId");

        // If careerId is not passed, load all careers and display the selection page
        if (careerParam == null || careerParam.trim().isEmpty()) {
            List<Career> careerList = getAllCareers();
            request.setAttribute("careerList", careerList);
            request.getRequestDispatcher("skill-gap.jsp").forward(request, response);
            return;
        }

        try {
            int careerId = Integer.parseInt(careerParam.trim());

            String careerName = "";
            List<String> matchedSkills = new ArrayList<>();
            List<String> missingSkills = new ArrayList<>();
            List<String> improveSkills = new ArrayList<>();

            try (Connection con = DBConnection.getConnection()) {
                if (con == null) {
                    throw new Exception("Database connection failed. Please ensure MySQL is running.");
                }

                // 1. Fetch career name
                String careerSQL = "SELECT career_name FROM careers WHERE career_id = ?";
                try (PreparedStatement ps = con.prepareStatement(careerSQL)) {
                    ps.setInt(1, careerId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            careerName = rs.getString("career_name");
                        } else {
                            response.sendError(404, "Career not found.");
                            return;
                        }
                    }
                }

                // 2. Query skills required vs student skills
                String sql =
                    "SELECT s.skill_name, cs.required_level, ss.skill_level " +
                    "FROM career_skills cs " +
                    "JOIN skills s ON cs.skill_id = s.skill_id " +
                    "LEFT JOIN student_skills ss " +
                    "ON ss.skill_id = cs.skill_id " +
                    "AND ss.student_id = ? " +
                    "WHERE cs.career_id = ? " +
                    "ORDER BY s.skill_name ASC";

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, studentId);
                    ps.setInt(2, careerId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            String skillName = rs.getString("skill_name");
                            String required = rs.getString("required_level");
                            String current = rs.getString("skill_level");

                            if (current == null) {
                                missingSkills.add(skillName + " (Required: " + required + ")");
                            } else if (levelValue(current) < levelValue(required)) {
                                improveSkills.add(skillName + " (Current: " + current + ", Required: " + required + ")");
                            } else {
                                matchedSkills.add(skillName + " (" + current + ")");
                            }
                        }
                    }
                }
            }

            // 3. Compute Readiness Percentage
            int totalRequired = matchedSkills.size() + improveSkills.size() + missingSkills.size();
            int matchPercentage = 0;
            if (totalRequired > 0) {
                // Matched skills give full credit, improve skills give 50% credit
                double score = matchedSkills.size() + (improveSkills.size() * 0.5);
                matchPercentage = (int) Math.round((score / totalRequired) * 100);
            }

            // 4. Generate AI Career Roadmap (using Gemini or Fallback Expert Engine)
            String aiRoadmap = aiRoadmapService.generateRoadmap(
                    careerName, matchedSkills, improveSkills, missingSkills);

            request.setAttribute("careerName", careerName);
            request.setAttribute("matchedSkills", matchedSkills);
            request.setAttribute("missingSkills", missingSkills);
            request.setAttribute("improveSkills", improveSkills);
            request.setAttribute("totalRequired", totalRequired);
            request.setAttribute("matchPercentage", matchPercentage);
            request.setAttribute("aiRoadmap", aiRoadmap);
            request.setAttribute("isAiConfigured", aiRoadmapService.isAiConfigured());

            request.getRequestDispatcher("skill-gap-result.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(400, "Please select a valid career.");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Skill gap analysis failed.", e);
        }
    }

    private List<Career> getAllCareers() {
        List<Career> list = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            if (con != null) {
                String sql = "SELECT career_id, career_name, description FROM careers ORDER BY career_id ASC";
                try (Statement stmt = con.createStatement();
                     ResultSet rs = stmt.executeQuery(sql)) {
                    while (rs.next()) {
                        list.add(new Career(
                                rs.getInt("career_id"),
                                rs.getString("career_name"),
                                rs.getString("description")
                        ));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private int levelValue(String level) {
        if (level == null) return 0;
        switch (level.trim().toLowerCase()) {
            case "beginner":
                return 1;
            case "intermediate":
                return 2;
            case "advanced":
                return 3;
            default:
                return 0;
        }
    }

    @Override
    public void destroy() {
        if (context != null) {
            context.close();
        }
    }
}
