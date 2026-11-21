
package com.mycompany.aiskillgapanalyzerweb.model;

public class SkillView {

    private int studentSkillId;
    private String skillName;
    private String skillLevel;

    public SkillView(int studentSkillId, String skillName,
                     String skillLevel) {
        this.studentSkillId = studentSkillId;
        this.skillName = skillName;
        this.skillLevel = skillLevel;
    }

    public int getStudentSkillId() {
        return studentSkillId;
    }

    public String getSkillName() {
        return skillName;
    }

    public String getSkillLevel() {
        return skillLevel;
    }
}
