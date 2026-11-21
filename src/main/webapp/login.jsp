<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - SkillGap AI</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(120deg, #263b9b, #7454d6);
            padding: 20px;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 45px rgba(0,0,0,0.2);
        }

        .logo {
            text-align: center;
            font-size: 35px;
            margin-bottom: 12px;
        }

        h2 {
            text-align: center;
            color: #303f9f;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #7b849b;
            margin-bottom: 25px;
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

        .alert-success {
            background: #dcfce7;
            color: #166534;
            border-left: 4px solid #16a34a;
        }

        label {
            display: block;
            margin: 16px 0 8px;
            font-weight: 600;
            color: #34405b;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #dce1ef;
            border-radius: 9px;
            outline: none;
            font-size: 15px;
        }

        input:focus {
            border-color: #6654d7;
            box-shadow: 0 0 0 3px rgba(102,84,215,0.12);
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 14px;
            border: none;
            border-radius: 9px;
            background: linear-gradient(120deg, #3949ab, #7454d6);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: opacity 0.2s;
        }

        button:hover {
            opacity: 0.92;
        }

        .bottom {
            text-align: center;
            margin-top: 22px;
            color: #737d94;
            font-size: 14px;
        }

        a {
            color: #5144b7;
            text-decoration: none;
            font-weight: bold;
        }

        .home {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
    </style>
</head>

<body>

    <div class="login-card">

        <div class="logo">🎓</div>

        <h2>Welcome Back!</h2>

        <p class="subtitle">
            Login to continue your career journey.
        </p>

        <!-- Feedback Alert Messages -->
        <c:if test="${param.error eq 'invalid'}">
            <div class="alert alert-error">❌ Invalid email or password. Please try again.</div>
        </c:if>
        <c:if test="${param.error eq 'empty'}">
            <div class="alert alert-error">⚠️ Please fill in all required fields.</div>
        </c:if>
        <c:if test="${param.error eq 'failed'}">
            <div class="alert alert-error">❌ Authentication failed due to a server error. Please try again.</div>
        </c:if>
        <c:if test="${param.success eq 'registered'}">
            <div class="alert alert-success">✅ Account created successfully! Please log in below.</div>
        </c:if>
        <c:if test="${param.logout eq 'success'}">
            <div class="alert alert-success">👋 You have been logged out successfully.</div>
        </c:if>

        <form action="LoginServlet" method="post">

            <label>Email Address</label>
            <input type="email" name="email"
                   placeholder="Enter your email" required>

            <label>Password</label>
            <input type="password" name="password"
                   placeholder="Enter your password" required>

            <button type="submit">Login →</button>

        </form>

        <p class="bottom">
            Don't have an account?
            <a href="register.jsp">Register</a>
        </p>

        <a class="home" href="index.jsp">← Back to Home</a>

    </div>

</body>
</html>
