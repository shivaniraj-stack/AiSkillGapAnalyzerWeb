<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty sessionScope.studentId}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Skill Gap Analysis Result - SkillGap AI</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        body {
            background: #f1f5f9;
            color: #172554;
        }

        header {
            background: linear-gradient(120deg, #172554, #3156c9);
            color: white;
            padding: 22px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header a {
            color: white;
            text-decoration: none;
            background: #e85d75;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 600;
        }

        .container {
            max-width: 1000px;
            margin: 35px auto;
            padding: 0 20px 40px;
        }

        .main-card {
            background: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 5px 25px rgba(0,0,0,.06);
            margin-bottom: 30px;
        }

        .header-section {
            border-bottom: 2px solid #f1f5f9;
            padding-bottom: 20px;
            margin-bottom: 25px;
        }

        .header-section h2 {
            color: #1e3a8a;
            font-size: 26px;
            margin-bottom: 8px;
        }

        .header-section .career-tag {
            display: inline-block;
            background: #e0e7ff;
            color: #3730a3;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 15px;
        }

        /* Readiness Score Progress Bar */
        .readiness-container {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 22px;
            margin-bottom: 30px;
        }

        .readiness-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .readiness-title {
            font-weight: 700;
            color: #1e293b;
            font-size: 16px;
        }

        .readiness-badge {
            font-weight: 800;
            font-size: 18px;
            color: #2563eb;
        }

        .progress-bar-bg {
            background: #e2e8f0;
            height: 14px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 12px;
        }

        .progress-bar-fill {
            height: 100%;
            border-radius: 10px;
            transition: width 0.8s ease-in-out;
            background: linear-gradient(90deg, #3b82f6, #10b981);
        }

        .readiness-summary {
            font-size: 13px;
            color: #64748b;
        }

        /* Skills 3-Column Grid */
        .skills-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .section {
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
        }

        .section h3 {
            font-size: 17px;
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .matched {
            background: #f0fdf4;
            border-left: 5px solid #16a34a;
        }
        .matched h3 { color: #166534; }

        .improve {
            background: #fffbeb;
            border-left: 5px solid #f59e0b;
        }
        .improve h3 { color: #92400e; }

        .missing {
            background: #fef2f2;
            border-left: 5px solid #ef4444;
        }
        .missing h3 { color: #991b1b; }

        ul {
            padding-left: 20px;
            line-height: 1.8;
            font-size: 14px;
        }

        li {
            margin-bottom: 6px;
        }

        .empty {
            color: #64748b;
            font-style: italic;
            font-size: 14px;
        }

        /* AI Roadmap Box Styling */
        .ai-card {
            background: linear-gradient(145deg, #ffffff, #f5f7ff);
            border: 2px solid #c7d2fe;
            border-radius: 16px;
            padding: 30px;
            margin-top: 25px;
            box-shadow: 0 8px 30px rgba(99, 102, 241, 0.08);
        }

        .ai-header-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: linear-gradient(90deg, #4f46e5, #7c3aed);
            color: white;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 14px;
        }

        .ai-roadmap-box h4 {
            color: #1e1b4b;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .ai-roadmap-box p {
            color: #475569;
            line-height: 1.6;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .timeline {
            border-left: 3px solid #818cf8;
            margin-left: 10px;
            padding-left: 20px;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 22px;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -27px;
            top: 4px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #4f46e5;
            border: 2px solid white;
        }

        .timeline-item h5 {
            color: #312e81;
            font-size: 15px;
            margin-bottom: 6px;
        }

        .ai-note {
            background: #eef2ff;
            border-left: 4px solid #6366f1;
            padding: 12px 16px;
            border-radius: 6px;
            margin-top: 20px;
            font-size: 14px;
            color: #3730a3;
        }

        .actions {
            margin-top: 35px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #3156c9;
            color: white;
        }
        .btn-primary:hover { background: #1e40af; }

        .btn-outline {
            background: white;
            color: #3156c9;
            border: 1px solid #3156c9;
        }
        .btn-outline:hover { background: #f8fafc; }

        @media(max-width: 600px) {
            .main-card { padding: 20px; }
            .skills-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

<header>
    <h2>🎓 AI Skill Gap Analyzer</h2>
    <a href="LogoutServlet">Logout</a>
</header>

<div class="container">

    <div class="main-card">

        <div class="header-section">
            <h2>🎯 Career Skill Gap Analysis</h2>
            <span>Target Role: </span>
            <span class="career-tag"><c:out value="${careerName}"/></span>
        </div>

        <!-- Readiness Fit Score Card -->
        <div class="readiness-container">
            <div class="readiness-header">
                <span class="readiness-title">Overall Career Readiness Score</span>
                <span class="readiness-badge"><c:out value="${matchPercentage}"/>% Match</span>
            </div>

            <div class="progress-bar-bg">
                <div class="progress-bar-fill" style="width: ${matchPercentage}%;"></div>
            </div>

            <div class="readiness-summary">
                Evaluated against <strong><c:out value="${totalRequired}"/></strong> benchmark skills: 
                <strong><c:out value="${matchedSkills.size()}"/></strong> matched, 
                <strong><c:out value="${improveSkills.size()}"/></strong> to improve, and 
                <strong><c:out value="${missingSkills.size()}"/></strong> missing.
            </div>
        </div>

        <!-- 3-Column Skills Analysis Breakdown -->
        <div class="skills-grid">

            <div class="section matched">
                <h3>✅ Matched Skills (<c:out value="${matchedSkills.size()}"/>)</h3>
                <c:choose>
                    <c:when test="${not empty matchedSkills}">
                        <ul>
                            <c:forEach var="skill" items="${matchedSkills}">
                                <li><c:out value="${skill}"/></li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p class="empty">No matching skills found at the required level yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section improve">
                <h3>⚠️ Skills to Improve (<c:out value="${improveSkills.size()}"/>)</h3>
                <c:choose>
                    <c:when test="${not empty improveSkills}">
                        <ul>
                            <c:forEach var="skill" items="${improveSkills}">
                                <li><c:out value="${skill}"/></li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p class="empty">No existing skills need level upgrades.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section missing">
                <h3>❌ Missing Skills (<c:out value="${missingSkills.size()}"/>)</h3>
                <c:choose>
                    <c:when test="${not empty missingSkills}">
                        <ul>
                            <c:forEach var="skill" items="${missingSkills}">
                                <li><c:out value="${skill}"/></li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p class="empty">Great job! You have acquired all core required skills.</p>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <!-- AI Career Roadmap & Learning Path -->
        <div class="ai-card">
            <span class="ai-header-badge">
                <c:choose>
                    <c:when test="${isAiConfigured}">✨ Powered by Gemini AI</c:when>
                    <c:otherwise>🤖 Intelligent Curriculum Engine</c:otherwise>
                </c:choose>
            </span>

            <c:out value="${aiRoadmap}" escapeXml="false"/>
        </div>

        <!-- Action Buttons -->
        <div class="actions">
            <a href="SkillGapServlet" class="btn btn-primary">Analyze Another Career →</a>
            <a href="SkillServlet" class="btn btn-outline">Update My Skills</a>
            <a href="dashboard.jsp" class="btn btn-outline">Back to Dashboard</a>
        </div>

    </div>

</div>

</body>
</html>
