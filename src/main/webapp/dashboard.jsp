<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty sessionScope.studentId}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title>Student Dashboard - AI Skill Gap Analyzer</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Arial, sans-serif;
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
                flex-wrap: wrap;
                gap: 15px;
            }

            header h2 {
                font-size: 21px;
            }

            header a {
                color: white;
                text-decoration: none;
                background: #e85d75;
                padding: 10px 18px;
                border-radius: 8px;
                font-weight: 600;
            }

            .container {
                max-width: 1100px;
                margin: 40px auto;
                padding: 0 20px;
            }

            .welcome {
                margin-bottom: 30px;
            }

            .welcome h1 {
                font-size: 29px;
                margin-bottom: 10px;
                color: #1e293b;
            }

            .welcome p {
                color: #64748b;
            }

            .profile {
                background: white;
                padding: 25px;
                border-radius: 14px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.05);
                margin-bottom: 25px;
            }

            .profile h3 {
                margin-bottom: 15px;
                color: #1e3a8a;
            }

            .profile-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 15px;
            }

            .profile-item {
                background: #f8fafc;
                padding: 12px 16px;
                border-radius: 8px;
                border-left: 3px solid #3b82f6;
            }

            .profile-item span {
                display: block;
                font-size: 12px;
                color: #64748b;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 4px;
            }

            .profile-item strong {
                color: #1e293b;
                font-size: 15px;
            }

            .cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
                gap: 22px;
            }

            .card {
                background: white;
                padding: 28px;
                border-radius: 14px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.05);
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .card h3 {
                margin-bottom: 12px;
                color: #1e3a8a;
            }

            .card p {
                color: #64748b;
                line-height: 1.6;
                margin-bottom: 22px;
            }

            .card a {
                display: inline-block;
                background: #3156c9;
                color: white;
                padding: 11px 18px;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                text-align: center;
                transition: background 0.2s;
            }

            .card a:hover {
                background: #1e40af;
            }

            @media(max-width: 500px) {
                .welcome h1 {
                    font-size: 23px;
                }
                header {
                    padding: 18px 5%;
                }
            }
        </style>
    </head>

    <body>

        <header>
            <h2>🎓 AI Skill Gap Analyzer</h2>
            <a href="LogoutServlet">Logout</a>
        </header>

        <div class="container">

            <div class="welcome">
                <h1>Welcome, <c:out value="${sessionScope.studentName}"/>!</h1>
                <p>Track your technical skills and discover what's needed for your dream career.</p>
            </div>

            <div class="profile">
                <h3>Student Overview</h3>
                <div class="profile-grid">
                    <div class="profile-item">
                        <span>Student ID</span>
                        <strong>#<c:out value="${sessionScope.studentId}"/></strong>
                    </div>
                    <div class="profile-item">
                        <span>Full Name</span>
                        <strong><c:out value="${sessionScope.studentName}"/></strong>
                    </div>
                    <div class="profile-item">
                        <span>Email Address</span>
                        <strong><c:out value="${sessionScope.studentEmail}"/></strong>
                    </div>
                    <div class="profile-item">
                        <span>Target Career Goal</span>
                        <strong><c:out value="${not empty sessionScope.studentCareerGoal ? sessionScope.studentCareerGoal : 'General Software Engineering'}"/></strong>
                    </div>
                </div>
            </div>

            <div class="cards">

                <div class="card">
                    <div>
                        <h3>📚 Manage Skills</h3>
                        <p>Add technical skills, self-assess your proficiency level, and keep your skills inventory up to date.</p>
                    </div>
                    <a href="SkillServlet">Manage Skills →</a>
                </div>

                <div class="card">
                    <div>
                        <h3>🎯 AI Skill Gap Analysis</h3>
                        <p>Compare your current skills with industry standards, see your readiness score, and receive an AI study roadmap.</p>
                    </div>
                    <a href="SkillGapServlet">Analyze Skills →</a>
                </div>

                <div class="card">
                    <div>
                        <h3>👤 My Profile</h3>
                        <p>View your registered student account information and career objectives.</p>
                    </div>
                    <a href="profile.jsp">View Profile →</a>
                </div>

            </div>

        </div>

    </body>
</html>
