<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - AI Skill Gap Analyzer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px;
            background: linear-gradient(135deg, #101b3d, #3156a5);
        }

        .register-card {
            width: 100%;
            max-width: 460px;
            background: white;
            padding: 38px;
            border-radius: 18px;
            box-shadow: 0 15px 45px rgba(0,0,0,0.2);
        }

        .logo {
            font-size: 38px;
            text-align: center;
            margin-bottom: 12px;
        }

        h2 {
            text-align: center;
            color: #172554;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #64748b;
            margin-bottom: 24px;
            font-size: 14px;
        }

        .alert {
            padding: 12px 14px;
            border-radius: 8px;
            margin-bottom: 18px;
            font-size: 14px;
            line-height: 1.4;
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border-left: 4px solid #dc2626;
        }

        label {
            display: block;
            margin: 15px 0 7px;
            color: #334155;
            font-weight: bold;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            outline: none;
            font-size: 14px;
        }

        input:focus {
            border-color: #4169e1;
            box-shadow: 0 0 0 3px rgba(65,105,225,0.12);
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 14px;
            border: none;
            border-radius: 9px;
            background: #3156c9;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }

        button:hover {
            background: #203fa5;
        }

        .bottom {
            text-align: center;
            margin-top: 22px;
            color: #64748b;
            font-size: 14px;
        }

        a {
            color: #3156c9;
            font-weight: bold;
            text-decoration: none;
        }

        .home {
            display: block;
            text-align: center;
            margin-top: 18px;
            font-size: 14px;
        }

        @media(max-width: 480px) {
            .register-card {
                padding: 25px 20px;
            }
        }
    </style>
</head>

<body>
    <div class="register-card">
        <div class="logo">🎓</div>

        <h2>Create Account</h2>
        <p class="subtitle">Start your personalized skill gap analysis</p>

        <!-- Feedback Alert Messages -->
        <c:if test="${param.error eq 'exists'}">
            <div class="alert alert-error">⚠️ An account with this email address already exists. Please log in instead.</div>
        </c:if>
        <c:if test="${param.error eq 'invalid'}">
            <div class="alert alert-error">❌ Please fill all fields correctly. Password must be at least 6 characters.</div>
        </c:if>
        <c:if test="${param.error eq 'failed'}">
            <div class="alert alert-error">❌ Registration failed. Please verify database connectivity and try again.</div>
        </c:if>

        <form action="RegisterServlet" method="post">

            <label>Full Name</label>
            <input type="text" name="student_name"
                   placeholder="Enter your full name" required maxlength="100">

            <label>Email Address</label>
            <input type="email" name="email"
                   placeholder="Enter your email" required maxlength="100">

            <label>Target Career Goal</label>
            <input type="text" name="career_goal"
                   placeholder="Example: Java Developer, Data Analyst" required maxlength="100">

            <label>Password (min 6 characters)</label>
            <input type="password" name="password"
                   placeholder="Create a secure password" minlength="6" required>

            <button type="submit">Create Account →</button>
        </form>

        <p class="bottom">
            Already have an account?
            <a href="login.jsp">Login</a>
        </p>

        <a class="home" href="index.jsp">← Back to Home</a>
    </div>
</body>
</html>
