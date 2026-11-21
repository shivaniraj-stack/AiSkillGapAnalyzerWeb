package com.mycompany.aiskillgapanalyzerweb.service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.stereotype.Service;

@Service
public class AiRoadmapService {

    private static final String GEMINI_MODEL = "gemini-1.5-flash";
    private static final String GEMINI_API_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/" + GEMINI_MODEL + ":generateContent?key=";

    /**
     * Resolves API key securely from:
     * 1. Environment variable: GEMINI_API_KEY
     * 2. System property: gemini.api.key
     * 3. Optional classpath file: gemini.properties (key: gemini.api.key)
     */
    public String getApiKey() {
        String key = System.getenv("GEMINI_API_KEY");
        if (key != null && !key.trim().isEmpty()) {
            return key.trim();
        }

        key = System.getProperty("gemini.api.key");
        if (key != null && !key.trim().isEmpty()) {
            return key.trim();
        }

        try (InputStream in = getClass().getClassLoader().getResourceAsStream("gemini.properties")) {
            if (in != null) {
                Properties props = new Properties();
                props.load(in);
                key = props.getProperty("gemini.api.key");
                if (key != null && !key.trim().isEmpty()) {
                    return key.trim();
                }
            }
        } catch (Exception ignored) {
        }

        return null;
    }

    public boolean isAiConfigured() {
        String key = getApiKey();
        return key != null && !key.isEmpty();
    }

    /**
     * Generates a tailored 4-week learning roadmap and actionable recommendations.
     * Uses Gemini API if configured; otherwise provides an intelligent rule-based curriculum.
     */
    public String generateRoadmap(String careerName, List<String> matchedSkills,
                                  List<String> improveSkills, List<String> missingSkills) {
        String apiKey = getApiKey();

        if (apiKey != null && !apiKey.isEmpty()) {
            try {
                String aiResponse = callGeminiApi(apiKey, careerName, matchedSkills, improveSkills, missingSkills);
                if (aiResponse != null && !aiResponse.trim().isEmpty()) {
                    return aiResponse;
                }
            } catch (Exception e) {
                System.err.println("Gemini API call failed, using rule-based roadmap: " + e.getMessage());
            }
        }

        return generateFallbackRoadmap(careerName, matchedSkills, improveSkills, missingSkills);
    }

    private String callGeminiApi(String apiKey, String careerName, List<String> matched,
                                 List<String> improve, List<String> missing) throws Exception {
        String prompt = buildPrompt(careerName, matched, improve, missing);

        // Escape JSON string characters
        String escapedPrompt = escapeJson(prompt);
        String requestBody = "{\"contents\":[{\"parts\":[{\"text\":\"" + escapedPrompt + "\"}]}]}";

        URL url = new URL(GEMINI_API_URL + apiKey);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setConnectTimeout(8000);
        conn.setReadTimeout(12000);
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int statusCode = conn.getResponseCode();
        if (statusCode >= 200 && statusCode < 300) {
            StringBuilder response = new StringBuilder();
            try (BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line.trim());
                }
            }
            return extractTextFromGeminiResponse(response.toString());
        } else {
            System.err.println("Gemini API returned HTTP status: " + statusCode);
            return null;
        }
    }

    private String buildPrompt(String career, List<String> matched, List<String> improve, List<String> missing) {
        return "You are an expert AI Career Mentor for university computer science students.\n"
                + "A student is targeting the role: " + career + ".\n"
                + "Current Verified Skills: " + String.join(", ", matched) + ".\n"
                + "Skills Needing Higher Proficiency: " + String.join(", ", improve) + ".\n"
                + "Completely Missing Skills: " + String.join(", ", missing) + ".\n\n"
                + "Generate a structured, actionable 4-week learning roadmap with:\n"
                + "1. A brief encouraging career readiness summary.\n"
                + "2. Week 1 to Week 4 milestone breakdown targeting missing and improve skills.\n"
                + "3. A practical portfolio project idea combining these skills.\n"
                + "4. Top recommended learning resources.\n\n"
                + "Format rules: Return clean HTML directly without markdown ```html fences. Use <h4>, <p>, <ul>, <li>, <strong>, and badges.";
    }

    private String extractTextFromGeminiResponse(String json) {
        // Simple regex extractor for candidate text in Gemini API response
        Pattern pattern = Pattern.compile("\"text\"\\s*:\\s*\"(.*?)(?<!\\\\)\"", Pattern.DOTALL);
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            String text = matcher.group(1);
            // Unescape common JSON escapes
            return text.replace("\\n", "\n")
                    .replace("\\\"", "\"")
                    .replace("\\\\", "\\")
                    .replace("```html", "")
                    .replace("```", "");
        }
        return null;
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    /**
     * Fallback expert system providing deterministic structured roadmaps
     * when offline or when no Gemini API key is supplied.
     */
    private String generateFallbackRoadmap(String careerName, List<String> matched,
                                           List<String> improve, List<String> missing) {
        StringBuilder html = new StringBuilder();

        html.append("<div class='ai-roadmap-box'>");
        html.append("<h4>🤖 AI Career Readiness & Learning Roadmap</h4>");
        html.append("<p>Based on your selected career path <strong>").append(careerName)
                .append("</strong>, here is a customized step-by-step 4-week roadmap to bridge your skill gaps:</p>");

        html.append("<div class='timeline'>");

        // Week 1
        html.append("<div class='timeline-item'>");
        html.append("<h5>📅 Week 1: Core Fundamentals & Quick Wins</h5>");
        html.append("<ul>");
        if (!improve.isEmpty()) {
            html.append("<li><strong>Deepen Current Skills:</strong> Focus on ").append(improve.get(0))
                    .append(". Dedicate 1.5 hours daily to advanced syntax, design patterns, and unit tests.</li>");
        } else {
            html.append("<li><strong>Strengthen Core:</strong> Review core algorithms, time complexity, and data structures.</li>");
        }
        if (!missing.isEmpty()) {
            html.append("<li><strong>Introduction:</strong> Start with official documentation and crash courses on ")
                    .append(missing.get(0)).append(".</li>");
        }
        html.append("</ul></div>");

        // Week 2
        html.append("<div class='timeline-item'>");
        html.append("<h5>📅 Week 2: Practical Application & Labs</h5>");
        html.append("<ul>");
        if (missing.size() > 1) {
            html.append("<li><strong>Tackle Next Gap:</strong> Begin studying ").append(missing.get(1))
                    .append(". Focus on hands-on tutorials rather than passive reading.</li>");
        } else {
            html.append("<li><strong>Practical Exercises:</strong> Build 2 small prototype modules to validate your learning.</li>");
        }
        html.append("<li><strong>Version Control:</strong> Commit daily progress to GitHub with descriptive commit messages.</li>");
        html.append("</ul></div>");

        // Week 3
        html.append("<div class='timeline-item'>");
        html.append("<h5>📅 Week 3: Project Integration & API Development</h5>");
        html.append("<ul>");
        html.append("<li><strong>Capstone Project:</strong> Integrate ")
                .append(!missing.isEmpty() ? missing.get(0) : "new tools")
                .append(" into a functional full-stack or backend project.</li>");
        html.append("<li><strong>Industry Standards:</strong> Apply clean code principles, error handling, and security practices.</li>");
        html.append("</ul></div>");

        // Week 4
        html.append("<div class='timeline-item'>");
        html.append("<h5>📅 Week 4: Portfolio, Mock Interviews & Review</h5>");
        html.append("<ul>");
        html.append("<li><strong>Resume & Showcase:</strong> Document your capstone project on GitHub with a comprehensive README and live demo link.</li>");
        html.append("<li><strong>Viva & Interview Prep:</strong> Practice top 30 interview questions related to ")
                .append(careerName).append(".</li>");
        html.append("</ul></div>");

        html.append("</div>"); // end timeline

        html.append("<div class='ai-note'>");
        html.append("💡 <em>Expert Advice: Focus on building one strong portfolio project demonstrating ")
                .append(!missing.isEmpty() ? String.join(", ", missing) : careerName)
                .append(" rather than multiple shallow tutorials.</em>");
        html.append("</div>");

        html.append("</div>");
        return html.toString();
    }
}
