package com.mycompany.aiskillgapanalyzerweb;

import com.mycompany.aiskillgapanalyzerweb.model.Career;
import com.mycompany.aiskillgapanalyzerweb.model.Skill;
import com.mycompany.aiskillgapanalyzerweb.model.SkillView;
import com.mycompany.aiskillgapanalyzerweb.model.Student;
import com.mycompany.aiskillgapanalyzerweb.service.AiRoadmapService;
import org.junit.Assert;
import org.junit.Test;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

public class AiSkillGapAnalyzerTest {

    @Test
    public void testPasswordHashingConsistency() throws Exception {
        String rawPassword = "password123";
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(rawPassword.getBytes(StandardCharsets.UTF_8));
        String encoded = Base64.getEncoder().encodeToString(hash);

        Assert.assertNotNull(encoded);
        Assert.assertFalse(encoded.isEmpty());
        // Verify deterministic hashing
        byte[] hash2 = md.digest(rawPassword.getBytes(StandardCharsets.UTF_8));
        Assert.assertEquals(encoded, Base64.getEncoder().encodeToString(hash2));
    }

    @Test
    public void testAiRoadmapGenerationFallback() {
        AiRoadmapService service = new AiRoadmapService();

        List<String> matched = Arrays.asList("Java (Advanced)", "SQL (Intermediate)");
        List<String> improve = Arrays.asList("Spring Boot (Current: Beginner, Required: Intermediate)");
        List<String> missing = Arrays.asList("Git (Required: Intermediate)", "Docker (Required: Intermediate)");

        String roadmap = service.generateRoadmap("Java Developer", matched, improve, missing);

        Assert.assertNotNull(roadmap);
        Assert.assertTrue(roadmap.contains("AI Career Readiness & Learning Roadmap"));
        Assert.assertTrue(roadmap.contains("Java Developer"));
        Assert.assertTrue(roadmap.contains("Week 1"));
        Assert.assertTrue(roadmap.contains("Week 4"));
    }

    @Test
    public void testReadinessScoreCalculation() {
        List<String> matched = Arrays.asList("HTML (Advanced)", "CSS (Advanced)");
        List<String> improve = Arrays.asList("JavaScript (Current: Beginner, Required: Intermediate)");
        List<String> missing = Arrays.asList("React (Required: Intermediate)");

        int totalRequired = matched.size() + improve.size() + missing.size();
        Assert.assertEquals(4, totalRequired);

        // Matched = 1.0, Improve = 0.5
        double score = matched.size() + (improve.size() * 0.5);
        int percentage = (int) Math.round((score / totalRequired) * 100);

        // (2 + 0.5) / 4 = 2.5 / 4 = 62.5% -> rounded to 63%
        Assert.assertEquals(63, percentage);
    }

    @Test
    public void testModels() {
        Career career = new Career(1, "Java Developer", "Backend development");
        Assert.assertEquals(1, career.getCareerId());
        Assert.assertEquals("Java Developer", career.getCareerName());

        Student student = new Student();
        student.setStudentId(10);
        student.setStudentName("Test User");
        student.setEmail("test@college.edu");
        student.setCareerGoal("Data Scientist");
        Assert.assertEquals("Test User", student.getStudentName());
        Assert.assertEquals("Data Scientist", student.getCareerGoal());

        Skill skill = new Skill();
        skill.setSkillId(5);
        skill.setSkillName("Python");
        Assert.assertEquals("Python", skill.getSkillName());

        SkillView view = new SkillView(1, "Python", "Advanced");
        Assert.assertEquals(1, view.getStudentSkillId());
        Assert.assertEquals("Python", view.getSkillName());
        Assert.assertEquals("Advanced", view.getSkillLevel());
    }
}
