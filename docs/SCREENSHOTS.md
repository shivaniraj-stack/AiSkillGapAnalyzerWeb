# 📸 Project UI Walkthrough & Screenshots Guide

This document catalogs the user interface workflows and screens of the **AI Skill Gap Analyzer Web** project for evaluation and viva demonstration.

---

## Screen Catalog

### 1. Landing Page (`index.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/`
* **Purpose**: Public home page welcoming university students.
* **Key Components**:
  * Navigation bar with branded logo and links.
  * Hero banner: *"Discover Your Skills. Build Your Future."*
  * Quick action buttons: **Get Started →** and **Create Account**.
  * Feature highlight cards: Skill Assessment, Career Analysis, and AI Roadmap Guidance.
  * Modern, responsive layout with embedded CSS3.

---

### 2. Student Authentication

#### A. Registration Page (`register.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/register.jsp`
* **Features**:
  * Capture Full Name, Email Address, Target Career Goal, and Password.
  * Client-side validation: HTML5 `required`, email format, and `minlength="6"`.
  * **Alert Banners**: Displays warning banner if an email already exists in the system (`?error=exists`) or if validation fails.
  * Back navigation to Home and Login.

#### B. Login Page (`login.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/login.jsp`
* **Features**:
  * Email and Password entry.
  * **Dynamic Feedback Alerts**:
    * ❌ *Invalid email or password* (on credential mismatch).
    * ✅ *Account created successfully! Please log in below* (after new registration).
    * 👋 *You have been logged out successfully* (after logging out).
  * Direct submission to `LoginServlet` with SHA-256 password hash comparison.

---

### 3. Student Dashboard (`dashboard.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/dashboard.jsp`
* **Security**: Session-guarded; redirects to `login.jsp` if not authenticated.
* **Key Components**:
  * Personalized greeting: *"Welcome, [Student Name]!"*.
  * **Student Overview Grid**: Displays Student ID, Full Name, Email, and current **Target Career Goal**.
  * Navigation Hub cards:
    1. **Manage Skills**: View, add, update, and delete competencies.
    2. **AI Skill Gap Analysis**: Dynamic career benchmarking and AI roadmap.
    3. **My Profile**: Detailed student account and security overview.
  * Quick logout button in the top navigation header.

---

### 4. Technical Skills Inventory (`manage-skills.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/SkillServlet`
* **Features**:
  * **Add New Skill Form**: Dropdown for proficiency (`Beginner`, `Intermediate`, `Advanced`).
  * **Automatic Upsert**: Adding an existing skill updates its level in-place instead of creating duplicate records.
  * **My Skill List Table**:
    * Column 1: Skill Name (alphabetically sorted).
    * Column 2: Current Level.
    * Column 3: Quick Update Level selector with instant submission.
    * Column 4: Delete button with JavaScript confirmation modal.
  * Color-coded status feedback banners (`Skill added successfully`, `Skill updated successfully`, `Skill deleted successfully`).

---

### 5. Career Selection (`skill-gap.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/SkillGapServlet`
* **Features**:
  * Dynamic dropdown pre-populated from the MySQL `careers` table:
    * *Java Developer*
    * *Web Developer*
    * *Data Analyst*
    * *AI / Machine Learning Engineer*
    * *Cloud & DevOps Engineer*
  * Description of benchmark competencies.
  * Submission triggers full gap analysis and AI curriculum generation.

---

### 6. Gap Analysis & AI Roadmap Results (`skill-gap-result.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/SkillGapServlet?careerId=[id]`
* **Key Components**:
  1. **Career Readiness Score**:
     * Visual animated progress bar displaying overall % fit.
     * Evaluated against total benchmark skills (e.g., 67% Match).
  2. **Three-Column Categorization**:
     * 🟩 **Matched Skills**: Acquired at or above required benchmark level.
     * 🟨 **Skills to Improve**: Acquired, but proficiency is below benchmark.
     * 🟥 **Missing Skills**: Competencies completely absent from student inventory.
  3. **AI Career Roadmap & Learning Path Card**:
     * **AI Powered Badge**: Indicates whether generated via Google Gemini LLM or the intelligent fallback curriculum engine.
     * **4-Week Milestone Timeline**:
       * *Week 1: Core Fundamentals & Quick Wins*
       * *Week 2: Practical Application & Labs*
       * *Week 3: Project Integration & API Development*
       * *Week 4: Portfolio, Mock Interviews & Review*
     * Actionable portfolio project suggestions and curated learning guidance.
  4. Quick action buttons: **Analyze Another Career**, **Update My Skills**, and **Back to Dashboard**.

---

### 7. Student Profile (`profile.jsp`)
* **URL**: `http://localhost:8080/AiSkillGapAnalyzerWeb/profile.jsp`
* **Features**:
  * Clean profile summary displaying ID, Student Name, Email Address, and Career Goal.
  * Security indicator: `🔒 Password Hashed (SHA-256)`.
  * Quick links to dashboard and skill manager.
