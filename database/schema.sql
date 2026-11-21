-- =====================================================================
-- AI Skill Gap Analyzer - Database Setup Script
-- Compatible with MySQL 5.7+ / MySQL 8.0+ / MariaDB 10.3+
-- =====================================================================

CREATE DATABASE IF NOT EXISTS ai_skill_gap_analyzer
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ai_skill_gap_analyzer;

-- ---------------------------------------------------------------------
-- 1. Table: students
-- Stores registered students with hashed passwords and career goals
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    career_goal VARCHAR(100),
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 2. Table: skills
-- Global repository of standardized skills
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 3. Table: student_skills
-- Maps a student's personal skills and self-assessed proficiency
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_skills (
    student_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    skill_level VARCHAR(50) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_student_skills_student
        FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_student_skills_skill
        FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_student_skill UNIQUE (student_id, skill_id)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 4. Table: careers
-- Target professional career paths
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS careers (
    career_id INT AUTO_INCREMENT PRIMARY KEY,
    career_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 5. Table: career_skills
-- Defines benchmark skill requirements and proficiency for each career
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS career_skills (
    career_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    career_id INT NOT NULL,
    skill_id INT NOT NULL,
    required_level VARCHAR(50) NOT NULL,
    CONSTRAINT fk_career_skills_career
        FOREIGN KEY (career_id) REFERENCES careers(career_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_career_skills_skill
        FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_career_skill UNIQUE (career_id, skill_id)
) ENGINE=InnoDB;

-- =====================================================================
-- SEED DATA
-- =====================================================================

-- Careers
INSERT INTO careers (career_id, career_name, description) VALUES
(1, 'Java Developer', 'Backend development using modern Java, Spring Boot, microservices and relational databases.')
ON DUPLICATE KEY UPDATE career_name = VALUES(career_name);

INSERT INTO careers (career_id, career_name, description) VALUES
(2, 'Web Developer', 'Full-stack and frontend development using HTML5, CSS3, JavaScript, and modern web frameworks.')
ON DUPLICATE KEY UPDATE career_name = VALUES(career_name);

INSERT INTO careers (career_id, career_name, description) VALUES
(3, 'Data Analyst', 'Data querying, statistical analysis, dashboard reporting, and business intelligence.')
ON DUPLICATE KEY UPDATE career_name = VALUES(career_name);

INSERT INTO careers (career_id, career_name, description) VALUES
(4, 'AI / Machine Learning Engineer', 'Building machine learning models, neural networks, and AI-driven applications.')
ON DUPLICATE KEY UPDATE career_name = VALUES(career_name);

INSERT INTO careers (career_id, career_name, description) VALUES
(5, 'Cloud & DevOps Engineer', 'Containerization, CI/CD pipelines, cloud infrastructure and automation.')
ON DUPLICATE KEY UPDATE career_name = VALUES(career_name);

-- Standard Skills
INSERT INTO skills (skill_id, skill_name) VALUES
(1, 'Java'),
(2, 'SQL'),
(3, 'Spring Boot'),
(4, 'HTML'),
(5, 'CSS'),
(6, 'JavaScript'),
(7, 'Python'),
(8, 'Excel'),
(9, 'Git'),
(10, 'REST APIs'),
(11, 'React'),
(12, 'Power BI'),
(13, 'Machine Learning'),
(14, 'Docker'),
(15, 'Linux')
ON DUPLICATE KEY UPDATE skill_name = VALUES(skill_name);

-- Career Benchmark Skill Requirements
-- 1. Java Developer
INSERT INTO career_skills (career_id, skill_id, required_level) VALUES
(1, 1, 'Advanced'),      -- Java
(1, 2, 'Intermediate'),  -- SQL
(1, 3, 'Intermediate'),  -- Spring Boot
(1, 9, 'Intermediate'),  -- Git
(1, 10, 'Intermediate')  -- REST APIs
ON DUPLICATE KEY UPDATE required_level = VALUES(required_level);

-- 2. Web Developer
INSERT INTO career_skills (career_id, skill_id, required_level) VALUES
(2, 4, 'Advanced'),      -- HTML
(2, 5, 'Advanced'),      -- CSS
(2, 6, 'Intermediate'),  -- JavaScript
(2, 11, 'Intermediate'), -- React
(2, 9, 'Beginner')       -- Git
ON DUPLICATE KEY UPDATE required_level = VALUES(required_level);

-- 3. Data Analyst
INSERT INTO career_skills (career_id, skill_id, required_level) VALUES
(3, 7, 'Advanced'),      -- Python
(3, 2, 'Intermediate'),  -- SQL
(3, 8, 'Advanced'),      -- Excel
(3, 12, 'Intermediate')  -- Power BI
ON DUPLICATE KEY UPDATE required_level = VALUES(required_level);

-- 4. AI / Machine Learning Engineer
INSERT INTO career_skills (career_id, skill_id, required_level) VALUES
(4, 7, 'Advanced'),      -- Python
(4, 13, 'Intermediate'), -- Machine Learning
(4, 2, 'Intermediate'),  -- SQL
(4, 9, 'Intermediate')   -- Git
ON DUPLICATE KEY UPDATE required_level = VALUES(required_level);

-- 5. Cloud & DevOps Engineer
INSERT INTO career_skills (career_id, skill_id, required_level) VALUES
(5, 15, 'Advanced'),     -- Linux
(5, 14, 'Intermediate'), -- Docker
(5, 9, 'Intermediate'),  -- Git
(5, 10, 'Intermediate')  -- REST APIs
ON DUPLICATE KEY UPDATE required_level = VALUES(required_level);

-- Sample Test Student: demo@college.edu / password: password123
-- SHA-256 hash of "password123" Base64 encoded is "ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f" in hex or Base64
-- Java SHA-256 Base64 of "password123":
-- md.digest("password123".getBytes(UTF_8)) -> Base64: 75K3eLr+dx6JJFuJ7LwIpEpOFmwGZZkRiB84PURz6U8=
INSERT INTO students (student_id, student_name, email, career_goal, password_hash) VALUES
(1, 'Demo Student', 'demo@college.edu', 'Java Developer', '75K3eLr+dx6JJFuJ7LwIpEpOFmwGZZkRiB84PURz6U8=')
ON DUPLICATE KEY UPDATE student_name = VALUES(student_name);

-- Sample Student Skills for Demo Student (Student ID 1)
INSERT INTO student_skills (student_id, skill_id, skill_level) VALUES
(1, 1, 'Intermediate'),  -- Has Java at Intermediate (needs Advanced for Java Dev -> will show in "Skills to Improve")
(1, 2, 'Intermediate'),  -- Has SQL at Intermediate (needs Intermediate -> will show in "Matched Skills")
(1, 4, 'Beginner')       -- Has HTML at Beginner
ON DUPLICATE KEY UPDATE skill_level = VALUES(skill_level);
