# 🎓 ACADEMIC PROJECT REPORT

# AI SKILL GAP ANALYZER WEB
### An Intelligent Skill Gap Analysis & Career Roadmap Recommendation System

---

**Degree / Course:** Bachelor of Technology / Computer Science & Engineering  
**Subject / Specialization:** Advanced Java Web Technology / Enterprise Application Development  
**Academic Year:** 2026 – 2027  
**Submission Status:** Final Submission Ready  

---

## TABLE OF CONTENTS

1. [Abstract](#1-abstract)
2. [Introduction & Problem Statement](#2-introduction--problem-statement)
3. [Objectives of the Project](#3-objectives-of-the-project)
4. [System Requirements Specification (SRS)](#4-system-requirements-specification-srs)
5. [System Architecture & Design Patterns](#5-system-architecture--design-patterns)
6. [Database Design & Data Dictionary](#6-database-design--data-dictionary)
7. [Module Description & Implementation](#7-module-description--implementation)
8. [Security & Session Management](#8-security--session-management)
9. [Artificial Intelligence Integration (Gemini API)](#9-artificial-intelligence-integration-gemini-api)
10. [Testing & Quality Assurance](#10-testing--quality-assurance)
11. [Deployment Guide](#11-deployment-guide)
12. [Conclusion & Future Enhancements](#12-conclusion--future-enhancements)

---

## 1. ABSTRACT

In the rapidly evolving software engineering industry, computer science students frequently face challenges in mapping their academic competencies to actual industry requirements. Conventional learning management systems lack personalized evaluation mechanisms to highlight technical deficiencies or provide structured recovery plans.

**AI Skill Gap Analyzer Web** is an enterprise-grade Java web application engineered to bridge the disconnect between student proficiencies and industry career benchmarks. Built on the **Java EE 8 / Servlet 4.0** standard with **Spring IoC (5.3)** and **Hibernate ORM (5.6)**, the system enables students to inventory their technical skills, evaluate their readiness against standardized career profiles (e.g., Java Developer, Data Analyst, Cloud/DevOps Engineer), and receive automated gap analyses categorized into Matched Skills, Skills to Improve, and Missing Skills.

Furthermore, the application integrates with **Google's Gemini API** to dynamically construct a personalized 4-week learning roadmap with project milestones, practical labs, and curated learning resources. A weighted Readiness Percentage score provides immediate visual feedback. For offline evaluations, an intelligent expert rule-based curriculum engine acts as a fallback to guarantee zero system downtime.

---

## 2. INTRODUCTION & PROBLEM STATEMENT

### 2.1 Background
The technological landscape requires modern software engineers to master multifaceted technology stacks comprising programming languages, frameworks, cloud platforms, and DevOps workflows. However, university curricula often emphasize foundational concepts without explicitly detailing the proficiency thresholds required for specialized job roles.

### 2.2 The Problem
1. **Lack of Role Transparency**: Students often do not know which specific libraries, tools, or frameworks are mandatory versus optional for target roles.
2. **Binary Self-Assessment**: Most student resumes state skills as a list without acknowledging depth of proficiency (Beginner vs. Intermediate vs. Advanced).
3. **No Actionable Feedback**: Even when a student recognizes a skill gap, they lack a personalized, milestone-driven roadmap to address it efficiently.

### 2.3 Proposed Solution
The *AI Skill Gap Analyzer Web* provides an automated, centralized platform where:
* Students maintain a validated inventory of their skills and proficiency levels.
* Benchmark career profiles outline required competencies with expected proficiency thresholds.
* An automated engine compares current versus required skills to generate a weighted readiness score.
* A contextual AI advisor recommends a tailored study roadmap and portfolio project recommendations.

---

## 3. OBJECTIVES OF THE PROJECT

1. **Develop a Modular Enterprise MVC Web Application**: Use standard Java Servlets, Spring Framework, Hibernate ORM, and MySQL.
2. **Implement Benchmark Career Matching**: Provide structured comparison algorithms that evaluate both skill presence and depth of proficiency.
3. **Prevent Data Duplication**: Implement upsert mechanisms ensuring students cannot register duplicate skill records.
4. **Deliver Generative AI Career Guidance**: Integrate the Google Gemini API securely using standard Java protocols to generate 4-week study roadmaps.
5. **Ensure Robust Security**: Protect student credentials using SHA-256 cryptographic hashing and mitigate session fixation attacks.
6. **Support Multi-Environment Deployment**: Containerize the solution with Docker and Docker Compose for zero-configuration execution.

---

## 4. SYSTEM REQUIREMENTS SPECIFICATION (SRS)

### 4.1 Hardware Requirements
* **Processor**: Intel Core i3 / AMD Ryzen 3 or higher (Quad-core recommended).
* **RAM**: 4 GB minimum (8 GB recommended for Docker/IDE).
* **Disk Space**: 500 MB free hard drive space.

### 4.2 Software Requirements
* **Operating System**: Windows 10/11, Linux (Ubuntu/Debian), or macOS.
* **Java Development Kit (JDK)**: JDK 8, 11, 17, or 21.
* **Application Server**: Apache Tomcat 9.0.x (Java EE 8 / Servlet 4.0 compliant).
* **Database Engine**: MySQL Server 8.0+ / MariaDB 10.3+.
* **Build Tool**: Apache Maven 3.6+.
* **IDE**: Apache NetBeans 12-28, Eclipse IDE for Enterprise Java, or IntelliJ IDEA.

---

## 5. SYSTEM ARCHITECTURE & DESIGN PATTERNS

The application is structured following the classical **Model-View-Controller (MVC)** architectural pattern combined with a **Layered Service-Oriented Architecture (SOA)**:

```text
┌─────────────────────────────────────────────────────────────┐
│                    VIEW LAYER (JSP / CSS)                   │
│   index.jsp, login.jsp, register.jsp, dashboard.jsp,       │
│   manage-skills.jsp, skill-gap.jsp, skill-gap-result.jsp    │
└──────────────────────────────┬──────────────────────────────┘
                               │ HTTP Request / JSTL Forward
┌──────────────────────────────▼──────────────────────────────┐
│                  CONTROLLER LAYER (Servlets)                │
│    LoginServlet, RegisterServlet, SkillServlet,             │
│    SkillGapServlet, LogoutServlet                           │
└──────────────┬──────────────────────────────┬───────────────┘
               │ Service Calls                │ Direct Queries
┌──────────────▼──────────────┐ ┌─────────────▼───────────────┐
│        SERVICE LAYER        │ │      RAW JDBC UTILITY       │
│  StudentService,            │ │  DBConnection.java          │
│  SkillService,              │ │  (Analytical multi-table    │
│  AiRoadmapService           │ │   joins in SkillGapServlet) │
└──────────────┬──────────────┘ └─────────────┬───────────────┘
               │ DAO Calls                    │
┌──────────────▼──────────────┐               │
│          DATA ACCESS        │               │
│  StudentDAO, SkillDAO       │               │
│  (Hibernate 5.6 ORM)        │               │
└──────────────┬──────────────┘               │
               │ Session Factory              │ SQL Execution
┌──────────────▼──────────────────────────────▼───────────────┐
│                    RELATIONAL DATABASE                      │
│            MySQL Server (ai_skill_gap_analyzer)             │
└─────────────────────────────────────────────────────────────┘
```

### Design Patterns Utilized
1. **Model-View-Controller (MVC)**: Decouples business logic (Servlets/Services) from data representation (JSP).
2. **Data Access Object (DAO)**: Abstract database operations behind `StudentDAO` and `SkillDAO`.
3. **Dependency Injection (Inversion of Control)**: Managed via Spring Framework `@Service` and `@Repository` annotations.
4. **Data Transfer Object (DTO)**: `SkillView` and `Career` classes encapsulate multi-table join data for presentation.
5. **Hybrid Persistence Architecture**:
   * *Hibernate ORM* handles transactional entities (`Student`, `Skill`, `StudentSkill`) with full object-relational mapping.
   * *Raw JDBC (`java.sql`)* executes multi-table benchmark queries with high performance in `SkillGapServlet`.

---

## 6. DATABASE DESIGN & DATA DICTIONARY

The relational database is named **`ai_skill_gap_analyzer`** and consists of 5 normalized tables.

### 6.1 Entity Relationship Diagram (ERD)

```text
[ STUDENTS ] 1 ────< M [ STUDENT_SKILLS ] M >──── 1 [ SKILLS ]
                              │                         │
                              │                         │
[ CAREERS ]  1 ────< M [ CAREER_SKILLS ]  M >───────────┘
```

### 6.2 Table Specifications

#### Table 1: `students`
| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| `student_id` | INT | Primary Key, Auto Increment | Unique student identifier |
| `student_name` | VARCHAR(100) | NOT NULL | Full name of the student |
| `email` | VARCHAR(100) | NOT NULL, UNIQUE | User login email address |
| `career_goal` | VARCHAR(100) | NULL | Target career aspiration |
| `password_hash` | VARCHAR(255) | NOT NULL | SHA-256 Base64 password hash |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Registration timestamp |

#### Table 2: `skills`
| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| `skill_id` | INT | Primary Key, Auto Increment | Unique skill identifier |
| `skill_name` | VARCHAR(100) | NOT NULL, UNIQUE | Canonical skill title (e.g., Java) |

#### Table 3: `student_skills`
| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| `student_skill_id` | INT | Primary Key, Auto Increment | Mapping identifier |
| `student_id` | INT | Foreign Key -> `students(student_id)` | Student owner |
| `skill_id` | INT | Foreign Key -> `skills(skill_id)` | Selected skill |
| `skill_level` | VARCHAR(50) | NOT NULL | Beginner, Intermediate, or Advanced |
| `updated_at` | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP | Last proficiency update |
| *Constraint* | UNIQUE (`student_id`, `skill_id`) | Ensures no duplicate skills per student |

#### Table 4: `careers`
| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| `career_id` | INT | Primary Key, Auto Increment | Career identifier |
| `career_name` | VARCHAR(100) | NOT NULL, UNIQUE | Professional role title |
| `description` | VARCHAR(255) | NULL | Brief role summary |

#### Table 5: `career_skills`
| Column Name | Data Type | Key / Constraints | Description |
| :--- | :--- | :--- | :--- |
| `career_skill_id` | INT | Primary Key, Auto Increment | Mapping identifier |
| `career_id` | INT | Foreign Key -> `careers(career_id)` | Target role |
| `skill_id` | INT | Foreign Key -> `skills(skill_id)` | Required skill |
| `required_level` | VARCHAR(50) | NOT NULL | Required benchmark level |
| *Constraint* | UNIQUE (`career_id`, `skill_id`) | Ensures unique benchmark per career |

---

## 7. MODULE DESCRIPTION & IMPLEMENTATION

### Module 1: Authentication & Account Management
* **`RegisterServlet`**: Receives student registration data. Verifies field length, executes duplicate email checks via `studentDAO.isEmailRegistered()`, hashes passwords using SHA-256, and saves the entity via Hibernate.
* **`LoginServlet`**: Authenticates users against hashed password records. Generates a secure HTTP session and resets session identifiers using `request.changeSessionId()` to protect against session fixation.
* **`LogoutServlet`**: Invalidates existing session objects and safely redirects users to the login screen.

### Module 2: Technical Skill Inventory
* **`SkillServlet`**: Dispatches CRUD operations for student competencies.
* **Upsert Optimization**: When a student adds a skill, `SkillDAO.addSkill()` queries whether that skill is already registered for that student. If found, it updates the proficiency level in-place instead of creating duplicate rows.

### Module 3: Automated Gap Analysis Engine
* **`SkillGapServlet`**: Compares student competencies against required career benchmarks using numeric rank values:
  $$\text{Level Value}(\text{level}) = \begin{cases} 1 & \text{Beginner} \\ 2 & \text{Intermediate} \\ 3 & \text{Advanced} \end{cases}$$
* **Categorization Rules**:
  1. $\text{Level}_{\text{student}} \ge \text{Level}_{\text{required}} \implies$ **Matched Skill**
  2. $\text{Level}_{\text{student}} < \text{Level}_{\text{required}} \implies$ **Skill to Improve**
  3. $\text{Level}_{\text{student}} = \text{null} \implies$ **Missing Skill**

### Module 4: Career Readiness Fit Scoring
* Evaluates comprehensive role readiness using a weighted metric:
  $$\text{Readiness Score} = \frac{\text{Count}(\text{Matched}) + 0.5 \times \text{Count}(\text{Improve})}{\text{Count}(\text{Total Required})} \times 100\%$$
* Renders a progress bar with dynamic color indicators on `skill-gap-result.jsp`.

---

## 8. SECURITY & SESSION MANAGEMENT

1. **Password Hashing**:
   Passwords are never stored in plaintext. They are encrypted using the SHA-256 algorithm via `java.security.MessageDigest` and stored as Base64 strings.
2. **Session Fixation Defense**:
   Upon authentication, `request.changeSessionId()` is invoked to force a new session cookie identifier, neutralizing malicious session hijacking attempts.
3. **Session Guards**:
   All internal JSP pages (`dashboard.jsp`, `manage-skills.jsp`, `profile.jsp`, `skill-gap.jsp`, `skill-gap-result.jsp`) check for session existence via JSTL `<c:if test="${empty sessionScope.studentId}">` and redirect unauthorized traffic to `login.jsp`.
4. **Credential Isolation**:
   Database and API keys are read from externalized environment variables (`DB_URL`, `DB_USER`, `DB_PASSWORD`, `GEMINI_API_KEY`) and are not committed to source repositories.

---

## 9. ARTIFICIAL INTELLIGENCE INTEGRATION (GEMINI API)

### 9.1 Overview
The **`AiRoadmapService`** utilizes the Google Gemini Large Language Model (`gemini-1.5-flash`) to generate contextual, high-yield study roadmaps.

### 9.2 API Invocation Flow
1. **Key Resolution**: Searches for `GEMINI_API_KEY` in environment variables or an uncommitted property file.
2. **Context Compilation**: Assembles the target career, matched proficiencies, skills needing improvement, and completely missing competencies into a structured prompt.
3. **HTTP Connection**: Issues a secure POST request to the Google Generative Language API using native `java.net.HttpURLConnection`.
4. **Response Parsing & Formatting**: Cleans and extracts the returned recommendations for direct HTML rendering.

### 9.3 Zero-Downtime Rule-Based Fallback
If the application is deployed offline or evaluated in an environment without internet or API keys, `AiRoadmapService` switches to an internal expert curriculum engine that constructs a 4-week structured milestone plan, ensuring 100% operational availability.

---

## 10. TESTING & QUALITY ASSURANCE

### 10.1 Unit Testing Suite
Automated unit tests are implemented using **JUnit 4** in `AiSkillGapAnalyzerTest.java`:

| Test Case | Method | Objective | Result |
| :--- | :--- | :--- | :--- |
| **TC-01** | `testPasswordHashingConsistency` | Verify deterministic SHA-256 Base64 encryption | **PASSED** |
| **TC-02** | `testAiRoadmapGenerationFallback` | Validate structured curriculum generation in offline mode | **PASSED** |
| **TC-03** | `testReadinessScoreCalculation` | Validate mathematical accuracy of weighted readiness fit | **PASSED** |
| **TC-04** | `testModels` | Verify model integrity across entities and DTOs | **PASSED** |

**Execution Result:**
```text
[INFO] Running com.mycompany.aiskillgapanalyzerweb.AiSkillGapAnalyzerTest
[INFO] Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.075 s
[INFO] BUILD SUCCESS
```

---

## 11. DEPLOYMENT GUIDE

### Option 1: Apache Tomcat 9 Deployment (Local)
1. Ensure MySQL is running on `localhost:3306`.
2. Execute `database/schema.sql` to initialize tables and seed data.
3. Build the project using Maven:
   ```bash
   mvn clean package
   ```
4. Copy `target/AiSkillGapAnalyzerWeb-1.0-SNAPSHOT.war` into your Tomcat `webapps/` folder.
5. Launch Tomcat (`bin/startup.bat`) and navigate to `http://localhost:8080/AiSkillGapAnalyzerWeb/`.

### Option 2: Docker Containerization (Cloud Ready)
Execute from the project root:
```bash
docker-compose up --build
```
The multi-stage `Dockerfile` compiles the WAR artifact and launches it on an official Tomcat 9 container linked to MySQL 8.0.

---

## 12. CONCLUSION & FUTURE ENHANCEMENTS

### 12.1 Conclusion
The **AI Skill Gap Analyzer Web** satisfies all academic criteria for an Advanced Java Enterprise web application. By pairing standard Java EE 8 MVC architecture with Spring IoC, Hibernate ORM, and the Google Gemini API, it delivers a practical, secure, and production-ready solution that guides students toward successful career outcomes.

### 12.2 Future Enhancements
1. **Automated Resume Parsing**: Integrate Apache Tika / PDFBox to parse student resumes and extract skills automatically.
2. **Interactive Career Benchmarks Admin Portal**: Add an administrator interface allowing faculty to add and update career benchmarks dynamically.
3. **Course API Integration**: Partner with platforms like Coursera or YouTube to link directly to verified free courses for missing skills.

---
*Report Prepared by: Shivani Raj*  
*Project Repository: AiSkillGapAnalyzerWeb*
