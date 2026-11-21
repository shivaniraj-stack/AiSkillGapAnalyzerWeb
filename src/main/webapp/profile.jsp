<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty sessionScope.studentId}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile - AI Skill Gap Analyzer</title>
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
            flex-wrap: wrap;
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
            max-width: 750px;
            margin: 45px auto;
            padding: 0 20px;
        }

        .profile-card {
            background: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.06);
        }

        h2 {
            margin-bottom: 20px;
            color: #1e3a8a;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 12px;
        }

        .detail {
            padding: 16px 0;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .detail-label {
            color: #64748b;
            font-weight: 600;
            font-size: 14px;
        }

        .detail-value {
            color: #0f172a;
            font-size: 15px;
            font-weight: 500;
        }

        .badge-career {
            background: #e0e7ff;
            color: #3730a3;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 13px;
        }

        .actions {
            margin-top: 30px;
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

        .btn-primary:hover {
            background: #1e40af;
        }

        .btn-outline {
            background: white;
            color: #3156c9;
            border: 1px solid #3156c9;
        }

        .btn-outline:hover {
            background: #f8fafc;
        }
    </style>
</head>

<body>

<header>
    <h2>🎓 AI Skill Gap Analyzer</h2>
    <a href="LogoutServlet">Logout</a>
</header>

<div class="container">
    <div class="profile-card">

        <h2>👤 Student Profile</h2>

        <div class="detail">
            <span class="detail-label">Student ID</span>
            <span class="detail-value">#<c:out value="${sessionScope.studentId}"/></span>
        </div>

        <div class="detail">
            <span class="detail-label">Full Name</span>
            <span class="detail-value"><c:out value="${sessionScope.studentName}"/></span>
        </div>

        <div class="detail">
            <span class="detail-label">Email Address</span>
            <span class="detail-value"><c:out value="${sessionScope.studentEmail}"/></span>
        </div>

        <div class="detail">
            <span class="detail-label">Target Career Goal</span>
            <span class="detail-value badge-career">
                <c:out value="${not empty sessionScope.studentCareerGoal ? sessionScope.studentCareerGoal : 'General Software Engineering'}"/>
            </span>
        </div>

        <div class="detail">
            <span class="detail-label">Account Security</span>
            <span class="detail-value" style="color: #16a34a; font-weight: 600;">🔒 Password Hashed (SHA-256)</span>
        </div>

        <div class="actions">
            <a href="dashboard.jsp" class="btn btn-outline">← Back to Dashboard</a>
            <a href="SkillServlet" class="btn btn-primary">Manage My Skills →</a>
        </div>

    </div>
</div>

</body>
</html>
