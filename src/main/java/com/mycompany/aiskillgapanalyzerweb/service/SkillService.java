
package com.mycompany.aiskillgapanalyzerweb.service;

import com.mycompany.aiskillgapanalyzerweb.dao.SkillDAO;
import com.mycompany.aiskillgapanalyzerweb.model.StudentSkill;
import com.mycompany.aiskillgapanalyzerweb.model.SkillView;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SkillService {

    @Autowired
    private SkillDAO skillDAO;

    // ADD SKILL
    public boolean addSkill(String skillName, int studentId,
                            String skillLevel) {

        return skillDAO.addSkill(
                skillName, studentId, skillLevel);
    }

    // VIEW SKILLS
    public List<SkillView> getSkills(int studentId) {

        return skillDAO.getSkills(studentId);
    }

    // UPDATE SKILL
    public boolean updateSkill(int studentSkillId, int studentId,
                               String skillLevel) {

        return skillDAO.updateSkill(
                studentSkillId, studentId, skillLevel);
    }

    // DELETE SKILL
    public boolean deleteSkill(int studentSkillId, int studentId) {

        return skillDAO.deleteSkill(
                studentSkillId, studentId);
    }
}
