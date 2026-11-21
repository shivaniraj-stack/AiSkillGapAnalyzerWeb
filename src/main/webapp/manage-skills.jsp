
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty sessionScope.studentId}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Skills - AI Skill Gap Analyzer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f1f5f9;
            color: #172554;
        }

        header {
            background: linear-gradient(120deg, #172554, #3156c9);
            color: white;
            padding: 22px 7%;
        }

        .container {
            max-width: 1100px;
            margin: 35px auto;
            padding: 20px;
        }

        .heading { margin-bottom: 25px; }

        .heading p {
            color: #64748b;
            margin-top: 8px;
        }

        .panel {
            background: white;
            padding: 25px;
            border-radius: 14px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        label {
            display: block;
            margin: 15px 0 7px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
        }

        button {
            margin-top: 12px;
            background: #3156c9;
            color: white;
            border: none;
            padding: 11px 17px;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover { opacity: 0.85; }

        .delete-btn { background: #dc3545; }

        .message {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            background: #dcfce7;
            color: #166534;
        }

        .error {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            background: #fee2e2;
            color: #991b1b;
        }

        .table-wrap { overflow-x: auto; }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            min-width: 650px;
        }

        th, td {
            padding: 14px;
            border-bottom: 1px solid #e2e8f0;
            text-align: left;
        }

        th { background: #eff4ff; }

        td form { min-width: 130px; }

        .back {
            display: inline-block;
            margin-top: 20px;
            color: #3156c9;
            text-decoration: none;
            font-weight: bold;
        }

        @media(max-width: 600px) {
            .panel { padding: 17px; }
            header { padding: 18px 5%; }
        }
    </style>
</head>

<body>

<header>
    <h2>🎓 AI Skill Gap Analyzer</h2>
    <p>Manage Your Skills</p>
</header>

<div class="container">

    <div class="heading">
        <h1>My Skills</h1>
        <p>Add, view, update and delete your skills.</p>
    </div>

    <!-- Success Messages -->

    <c:if test="${param.success eq 'added'}">
        <div class="message">Skill added successfully!</div>
    </c:if>

    <c:if test="${param.success eq 'updated'}">
        <div class="message">Skill updated successfully!</div>
    </c:if>

    <c:if test="${param.success eq 'deleted'}">
        <div class="message">Skill deleted successfully!</div>
    </c:if>

    <!-- Error Message -->

    <c:if test="${not empty param.error}">
        <div class="error">
            Operation failed. Please check your input and try again.
        </div>
    </c:if>

    <!-- Add Skill -->

    <div class="panel">
        <h2>Add New Skill</h2>

        <form action="SkillServlet" method="post">

            <input type="hidden" name="action" value="add">

            <label>Skill Name</label>
            <input type="text" name="skill_name"
                   placeholder="Example: Java, Python, HTML"
                   required maxlength="100">

            <label>Skill Level</label>
            <select name="skill_level" required>
                <option value="">Select your level</option>
                <option value="Beginner">Beginner</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Advanced">Advanced</option>
            </select>

            <button type="submit">+ Add Skill</button>

        </form>
    </div>

    <!-- View, Update and Delete Skills -->

    <div class="panel">
        <h2>My Skill List</h2>

        <div class="table-wrap">
            <table>

                <tr>
                    <th>Skill Name</th>
                    <th>Current Level</th>
                    <th>Update Level</th>
                    <th>Delete</th>
                </tr>

                <c:forEach var="skill" items="${skillList}">

                    <tr>

                        <td>
                            <c:out value="${skill.skillName}"/>
                        </td>

                        <td>
                            <c:out value="${skill.skillLevel}"/>
                        </td>

                        <td>
                            <form action="SkillServlet" method="post">

                                <input type="hidden" name="action"
                                       value="update">

                                <input type="hidden"
                                       name="studentSkillId"
                                       value="${skill.studentSkillId}">

                                <select name="skill_level" required>
                                    <option value="Beginner"
                                        ${skill.skillLevel eq 'Beginner' ? 'selected' : ''}>
                                        Beginner
                                    </option>

                                    <option value="Intermediate"
                                        ${skill.skillLevel eq 'Intermediate' ? 'selected' : ''}>
                                        Intermediate
                                    </option>

                                    <option value="Advanced"
                                        ${skill.skillLevel eq 'Advanced' ? 'selected' : ''}>
                                        Advanced
                                    </option>
                                </select>

                                <button type="submit">Update</button>

                            </form>
                        </td>

                        <td>
                            <form action="SkillServlet" method="post"
                                  onsubmit="return confirm('Are you sure you want to delete this skill?');">

                                <input type="hidden" name="action"
                                       value="delete">

                                <input type="hidden"
                                       name="studentSkillId"
                                       value="${skill.studentSkillId}">

                                <button type="submit"
                                        class="delete-btn">
                                    Delete
                                </button>

                            </form>
                        </td>

                    </tr>

                </c:forEach>

                <c:if test="${empty skillList}">
                    <tr>
                        <td colspan="4">No skills added yet.</td>
                    </tr>
                </c:if>

            </table>
        </div>
    </div>

    <a class="back" href="dashboard.jsp">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>
