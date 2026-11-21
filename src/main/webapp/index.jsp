
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Skill Gap Analyzer</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background: #f4f6ff;
            color: #202b46;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 22px 8%;
            background: white;
            box-shadow: 0 3px 15px rgba(0,0,0,0.05);
        }

        .logo {
            font-size: 22px;
            font-weight: bold;
            color: #3949ab;
        }

        .nav-links a {
            text-decoration: none;
            margin-left: 25px;
            color: #39445c;
            font-weight: 600;
        }

        .hero {
            min-height: 540px;
            padding: 70px 8%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 40px;
            background: linear-gradient(120deg, #263b9b, #7454d6);
            color: white;
        }

        .hero-content {
            max-width: 600px;
        }

        .tag {
            display: inline-block;
            background: rgba(255,255,255,0.17);
            padding: 9px 18px;
            border-radius: 30px;
            margin-bottom: 25px;
            font-size: 13px;
        }

        .hero h1 {
            font-size: 48px;
            line-height: 1.2;
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 17px;
            line-height: 1.8;
            color: #e3e7ff;
            margin-bottom: 30px;
        }

        .buttons a {
            display: inline-block;
            padding: 14px 28px;
            border-radius: 9px;
            text-decoration: none;
            font-weight: bold;
            margin-right: 12px;
            margin-bottom: 10px;
        }

        .login-btn {
            background: white;
            color: #3949ab;
        }

        .register-btn {
            border: 1px solid white;
            color: white;
        }

        .hero-art {
            width: 320px;
            height: 320px;
            border-radius: 50%;
            background: rgba(255,255,255,0.13);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 125px;
            flex-shrink: 0;
        }

        .features {
            padding: 65px 8%;
            text-align: center;
        }

        .features h2 {
            font-size: 30px;
            margin-bottom: 12px;
        }

        .subtitle {
            color: #75809a;
            margin-bottom: 35px;
        }

        .feature-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
        }

        .feature-card {
            background: white;
            padding: 30px 22px;
            border-radius: 15px;
            box-shadow: 0 5px 22px rgba(40,50,100,0.07);
        }

        .feature-card .icon {
            font-size: 38px;
            margin-bottom: 15px;
        }

        .feature-card h3 {
            margin-bottom: 12px;
            color: #3446a5;
        }

        .feature-card p {
            color: #778198;
            line-height: 1.6;
        }

        footer {
            background: #202b55;
            color: white;
            text-align: center;
            padding: 22px;
        }

        @media(max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
            }

            .nav-links a {
                margin: 0 8px;
            }

            .hero {
                flex-direction: column;
                text-align: center;
                padding: 55px 7%;
            }

            .hero h1 {
                font-size: 34px;
            }

            .hero-art {
                width: 210px;
                height: 210px;
                font-size: 85px;
            }

            .feature-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar">
        <div class="logo">🎓 SkillGap AI</div>

        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="#features">Features</a>
            <a href="login.jsp">Login</a>
        </div>
    </nav>

    <section class="hero">

        <div class="hero-content">

            <span class="tag">YOUR PERSONAL CAREER COMPANION</span>

            <h1>Discover Your Skills.<br>
                Build Your Future.</h1>

            <p>
                Welcome to AI Skill Gap Analyzer!
                Identify your current skills, compare them
                with your dream career requirements and
                discover what you need to improve.
            </p>

            <div class="buttons">
                <a href="login.jsp" class="login-btn">
                    Get Started →
                </a>

                <a href="register.jsp" class="register-btn">
                    Create Account
                </a>
            </div>

        </div>

        <div class="hero-art">
            🎯
        </div>

    </section>

    <section class="features" id="features">

        <h2>Explore Your Potential</h2>

        <p class="subtitle">
            Everything you need to plan your career journey.
        </p>

        <div class="feature-container">

            <div class="feature-card">
                <div class="icon">📊</div>
                <h3>Skill Assessment</h3>
                <p>
                    Add and manage your current technical
                    skills and proficiency levels.
                </p>
            </div>

            <div class="feature-card">
                <div class="icon">🎯</div>
                <h3>Career Analysis</h3>
                <p>
                    Compare your skills with the requirements
                    of your selected career.
                </p>
            </div>

            <div class="feature-card">
                <div class="icon">🚀</div>
                <h3>Improve Your Skills</h3>
                <p>
                    Identify missing skills and understand
                    where you need improvement.
                </p>
            </div>

        </div>

    </section>

    <footer>
        <p>AI Skill Gap Analyzer © 2026 | Learn Today, Lead Tomorrow.</p>
    </footer>

</body>
</html>
