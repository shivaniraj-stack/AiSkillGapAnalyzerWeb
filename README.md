# 🎓 AI Skill Gap Analyzer Web

An enterprise-ready, AI-augmented web application designed to help university students identify, track, and bridge technical skill gaps between their current proficiencies and industry career benchmarks.

---

## 🌟 Key Features

1. **AI Career Roadmap & Learning Path Generator**:
   - Integrates with the **Google Gemini API** (`gemini-1.5-flash`) to generate personalized, 4-week learning roadmaps targeting a student's specific missing skills and improvement areas.
   - Includes milestone study plans, portfolio project ideas, and free learning resources.
   - **Offline / Graceful Fallback**: Automatically activates a smart rule-based curriculum engine if no API key is supplied or when running offline.

2. **Automated Career Gap Analysis**:
   - Compares student skill proficiency (`Beginner`, `Intermediate`, `Advanced`) against required benchmark levels for top tech career paths.
   - Categorizes skills into:
     - ✅ **Matched Skills**: Proficient at or above the industry standard.
     - ⚠️ **Skills to Improve**: Acquired, but below recommended proficiency.
     - ❌ **Missing Skills**: Essential skills completely absent from student inventory.

3. **Career Readiness Score**:
   - Computes an overall weighted percentage match fit with an animated color-coded progress bar.

4. **Dynamic Career Benchmarks**:
   - Dynamically loads career paths and benchmark requirements from the database (`Java Developer`, `Web Developer`, `Data Analyst`, `AI/ML Engineer`, `DevOps/Cloud Engineer`).

5. **Student Skill Inventory**:
   - Full CRUD management of personal technical skills with automatic duplicate prevention (updating existing proficiencies instead of duplicate entries).

6. **Enterprise Security**:
   - Passwords hashed using **SHA-256** with Base64 encoding.
   - Session fixation mitigation via `request.changeSessionId()` on authentication.
   - Role and session verification across all internal JSPs.

---

## 🛠️ Architecture & Tech Stack

```text
[ Browser / Client ]
       │
       ▼ (HTTP / JSTL / Responsive CSS)
[ Apache Tomcat 9 (Java EE 8 / Servlet 4.0) ]
       │
       ├──► Controllers: Java Servlets (@WebServlet)
       │         │
       │         ├──► Spring Context 5.3 (IoC / Dependency Injection)
       │         │         │
       │         │         ├──► Services: StudentService, SkillService
       │         │         │         │
       │         │         │         └──► Hibernate 5.6 ORM (JPA Entities)
       │         │         │                   │
       │         │         │                   ▼
       │         │         │             [ MySQL Database: ai_skill_gap_analyzer ]
       │         │         │
       │         │         └──► AI Service: AiRoadmapService
       │         │                   │
       │         │                   ▼
       │         │             [ Google Gemini API / Expert Fallback Engine ]
       │         │
       │         └──► Direct JDBC Queries: SkillGapServlet
       │                   │
       │                   ▼
       │             [ MySQL Database: ai_skill_gap_analyzer ]
```

| Layer | Technology | Details |
| :--- | :--- | :--- |
| **Backend** | Java SE 8, Java EE 8 (Servlet 4.0, JSP 2.3, JSTL 1.2) | Enterprise Java web architecture |
| **Dependency Injection** | Spring Framework 5.3.39 | `@Service`, `@Repository`, `@Autowired` |
| **ORM / Data Access** | Hibernate ORM 5.6.15.Final + JPA 2.2 | Maps `Student`, `Skill`, and `StudentSkill` entities |
| **Direct SQL** | Raw JDBC (`java.sql.PreparedStatement`) | High-performance multi-table join queries in `SkillGapServlet` |
| **Database** | MySQL Server / MariaDB | Relational database storage |
| **AI Integration** | Google Gemini API (`gemini-1.5-flash`) | Contextual study roadmap generation |
| **Frontend** | JSP, JSTL, HTML5, Custom Responsive CSS | Card-based UI, mobile-responsive layout |
| **Containerization** | Docker & Docker Compose | Multi-stage build on Tomcat 9 and MySQL 8.0 |

---

## 🚀 Getting Started

### Prerequisites
* **Java Development Kit (JDK 8 or higher)**: (JDK 8, 11, 17, or 21)
* **Apache Maven 3.6+**
* **Apache Tomcat 9.0.x** *(Important: Must be Tomcat 9 because Java EE 8 uses `javax.servlet`; Tomcat 10+ uses `jakarta.servlet`)*
* **MySQL Server** (via XAMPP, WAMP, or standalone MySQL)

---

### Step 1: Database Setup

1. Start **MySQL** via XAMPP Control Panel or command line on port `3306`.
2. Open **phpMyAdmin** (`http://localhost/phpmyadmin`) or your MySQL client.
3. Import or execute the provided setup script located at:
   ```text
   database/schema.sql
   ```
   *This script creates the `ai_skill_gap_analyzer` database, all 5 relational tables, and pre-populates standard skills, careers, and benchmark requirements.*

#### Default Database Credentials
* **Host**: `localhost:3306`
* **Database**: `ai_skill_gap_analyzer`
* **Username**: `root`
* **Password**: *(blank / empty)*

> 💡 **Custom Credentials**: You can customize database credentials without modifying Java files by editing `src/main/resources/db.properties` or setting environment variables (`DB_URL`, `DB_USER`, `DB_PASSWORD`).

---

### Step 2: Configure Gemini AI Key (Optional & Secure)

To enable live Google Gemini AI study roadmaps:

1. Obtain a free API key from [Google AI Studio](https://aistudio.google.com/).
2. Set it as an environment variable on your machine:
   * **Windows (PowerShell)**:
     ```powershell
     $env:GEMINI_API_KEY="your_api_key_here"
     ```
   * **Windows (System Environment Variables)**:
     Add Variable Name: `GEMINI_API_KEY`, Variable Value: `your_api_key_here`.
   * **Alternative (Local file - ignored by Git)**:
     Create `src/main/resources/gemini.properties` with:
     ```properties
     gemini.api.key=your_api_key_here
     ```
     *(This file is pre-configured in `.gitignore` so your key is never committed to GitHub).*

> 💡 **Offline Mode**: If no API key is provided, the application automatically uses its built-in rule-based expert curriculum engine so all features work reliably without crashing.

---

### Step 3: Build & Run

#### Option A: Running via NetBeans IDE
1. Open **Apache NetBeans**.
2. Select **File > Open Project** and choose this project directory.
3. Ensure Apache Tomcat 9 is configured under **Services > Servers**.
4. Right-click the project and click **Run**.
5. The browser will open: `http://localhost:8080/AiSkillGapAnalyzerWeb/`.

#### Option B: Building via Command Line (Maven)
```bash
mvn clean package
```
This builds `target/AiSkillGapAnalyzerWeb-1.0-SNAPSHOT.war`.
Copy this `.war` file to your Tomcat `webapps/` folder and start Tomcat.

#### Option C: Running with Docker Compose (One-Command Setup)
If you have Docker Desktop installed, run:
```bash
docker-compose up --build
```
Access the application at: `http://localhost:8080/`.

---

## 🧪 Demo Credentials

To test the application immediately after importing `database/schema.sql`:
* **Email**: `demo@college.edu`
* **Password**: `password123`
*(Or register a new account on the registration page)*.

---

## 📂 Project Directory Structure

```text
AiSkillGapAnalyzerWeb/
├── pom.xml                                    # Maven dependencies & build settings
├── Dockerfile                                 # Multi-stage container build (Tomcat 9)
├── docker-compose.yml                         # Automated App + MySQL stack
├── .gitignore                                 # Git rules for build outputs & sensitive files
├── README.md                                  # Complete documentation
│
├── database/
│   └── schema.sql                             # Full database DDL schema and seed data
│
└── src/
    └── main/
        ├── java/com/mycompany/aiskillgapanalyzerweb/
        │   ├── config/
        │   │   └── SpringConfig.java          # Spring component scanning configuration
        │   ├── controller/
        │   │   ├── LoginServlet.java          # Login handler with SHA-256 validation
        │   │   ├── LogoutServlet.java         # Session invalidation & logout
        │   │   ├── RegisterServlet.java       # Registration with duplicate check
        │   │   ├── SkillServlet.java          # Skill CRUD controller
        │   │   └── SkillGapServlet.java       # Gap calculation, score & AI roadmap
        │   ├── dao/
        │   │   ├── SkillDAO.java              # Hibernate DAO for skills with duplicate prevention
        │   │   └── StudentDAO.java            # Hibernate DAO for student persistence
        │   ├── model/
        │   │   ├── Career.java                # Career DTO for dynamic career loading
        │   │   ├── Skill.java                 # JPA Entity for skills table
        │   │   ├── SkillView.java             # DTO for display of skills in JSP
        │   │   ├── Student.java               # JPA Entity for students table
        │   │   └── StudentSkill.java          # JPA Entity for student_skills table
        │   ├── service/
        │   │   ├── AiRoadmapService.java      # Gemini API integration & fallback engine
        │   │   ├── SkillService.java          # Business logic for skill operations
        │   │   └── StudentService.java        # Business logic for student authentication
        │   └── util/
        │       ├── DBConnection.java          # JDBC utility reading db.properties / env
        │       └── HibernateUtil.java         # Hibernate SessionFactory configuration
        │
        ├── resources/
        │   ├── db.properties                  # Database connection properties
        │   └── hibernate.cfg.xml              # Hibernate MySQL configuration
        │
        └── webapp/
            ├── index.jsp                      # Landing page with hero section & overview
            ├── login.jsp                      # Login page with dynamic error/success alerts
            ├── register.jsp                   # Account registration with validation alerts
            ├── dashboard.jsp                  # Authenticated student home with career goals
            ├── profile.jsp                    # Student profile & security information
            ├── manage-skills.jsp              # Technical skill CRUD interface
            ├── skill-gap.jsp                  # Dynamic career selection interface
            ├── skill-gap-result.jsp           # Readiness score, gap analysis & AI roadmap
            └── WEB-INF/
                └── web.xml                    # Deployment descriptor (session timeout)
```

---

## 🎯 Viva & Defense Q&A Points for College Submission

1. **Why is password hashing important?**
   - We use `SHA-256` hashing with `Base64` encoding before writing to the database. Even if the database is exposed, cleartext passwords are never revealed.

2. **Why does the project use both Hibernate and JDBC?**
   - Demonstrates a **Hybrid Enterprise Pattern**:
     - **Hibernate ORM** is used for transactional entity management (`Student`, `Skill`, `StudentSkill`), benefiting from JPA object mapping, dirty checking, and session lifecycle.
     - **JDBC (`PreparedStatement`)** is used in `SkillGapServlet` for multi-table analytical joins across `career_skills`, `skills`, and `student_skills`, giving maximum SQL query optimization.

3. **How does the AI Roadmap component work?**
   - The system checks if `GEMINI_API_KEY` is configured. If available, it issues a secure JSON HTTP request to Google's `gemini-1.5-flash` model with contextual student gaps. If offline or without an API key, an intelligent fallback engine constructs an expert 4-week roadmap, ensuring 100% availability during college evaluations.

4. **How are duplicate skills prevented?**
   - `SkillDAO.addSkill()` performs an upsert check: if a student has already added a skill, it updates their proficiency level instead of inserting a duplicate row.
