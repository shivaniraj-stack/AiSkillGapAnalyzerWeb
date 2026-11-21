
package com.mycompany.aiskillgapanalyzerweb.model;

import javax.persistence.*;

@Entity
@Table(name = "student_skills")
public class StudentSkill {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "student_skill_id")
    private int studentSkillId;

    @Column(name = "student_id")
    private int studentId;

    @Column(name = "skill_id")
    private int skillId;

    @Column(name = "skill_level")
    private String skillLevel;

    public StudentSkill() {
    }

    public int getStudentSkillId() {
        return studentSkillId;
    }

    public void setStudentSkillId(int studentSkillId) {
        this.studentSkillId = studentSkillId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getSkillId() {
        return skillId;
    }

    public void setSkillId(int skillId) {
        this.skillId = skillId;
    }

    public String getSkillLevel() {
        return skillLevel;
    }

    public void setSkillLevel(String skillLevel) {
        this.skillLevel = skillLevel;
    }
}
