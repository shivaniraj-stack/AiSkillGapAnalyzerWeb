<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty sessionScope.studentId}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>AI Skill Gap Analysis - Select Career</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

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
            max-width: 800px;
            margin: 45px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        }

        .badge-ai {
            display: inline-block;
            background: #ede9fe;
            color: #6d28d9;
            font-size: 12px;
            font-weight: bold;
            padding: 5px 12px;
            border-radius: 20px;
            margin-bottom: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        h2 {
            color: #1e3a8a;
            margin-bottom: 10px;
            font-size: 24px;
        }

        p.desc {
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 25px;
            font-size: 15px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #334155;
            font-size: 14px;
        }

        select {
            width: 100%;
            padding: 14px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            font-size: 15px;
            outline: none;
            background: white;
            color: #1e293b;
        }

        select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59,130,246,0.15);
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 15px;
            border: none;
            border-radius: 9px;
            background: linear-gradient(120deg, #3156c9, #6366f1);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: opacity 0.2s;
        }

        button:hover {
            opacity: 0.92;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
            color: #3156c9;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
        }

        .tip-box {
            margin-top: 25px;
            padding: 14px;
            background: #eff6ff;
            border-left: 4px solid #3b82f6;
            border-radius: 6px;
            font-size: 13px;
            color: #1e40af;
        }
    </style>
</head>

<body>

<header>
    <h2>🎓 AI Skill Gap Analyzer</h2>
    <a href="LogoutServlet">Logout</a>
</header>

<div class="container">
    <div class="card">

        <span class="badge-ai">✨ Powered by AI & Benchmark Standards</span>
        <h2>🎯 Career Skill Gap Analysis</h2>

        <p class="desc">
            Select your target career path to compare your current verified skills against industry benchmarks. 
            The system will analyze your match readiness and generate a tailored study roadmap.
        </p>

        <form action="SkillGapServlet" method="get">

            <label for="careerId">Select Your Desired Career Path</label>

            <select name="careerId" id="careerId" required>
                <option value="">-- Choose a Career Path --</option>

                <!-- Dynamic Careers populated from Database -->
                <c:forEach var="career" items="${careerList}">
                    <option value="${career.careerId}">
                        <c:out value="${career.careerName}"/>
                        <c:if test="${not empty career.description}"> - <c:out value="${career.description}"/></c:if>
                    </option>
                </c:forEach>

                <!-- Fallback options if direct access without servlet attributes -->
                <c:if test="${empty careerList}">
                    <option value="1">Java Developer</option>
                    <option value="2">Web Developer</option>
                    <option value="3">Data Analyst</option>
                    <option value="4">AI / Machine Learning Engineer</option>
                    <option value="5">Cloud & DevOps Engineer</option>
                </c:if>
            </select>

            <button type="submit">Analyze My Skills & Generate Roadmap →</button>

        </form>

        <div class="tip-box">
            💡 <strong>Tip:</strong> Make sure you have added your skills in 
            <a href="SkillServlet" style="color:#1d4ed8; font-weight: bold;">Manage Skills</a> 
            before running the analysis for the most accurate results.
        </div>

        <a href="dashboard.jsp" class="back">← Back to Dashboard</a>

    </div>
</div>

</body>
</html>
