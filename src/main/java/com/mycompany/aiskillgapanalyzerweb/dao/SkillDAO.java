package com.mycompany.aiskillgapanalyzerweb.dao;

import com.mycompany.aiskillgapanalyzerweb.model.Skill;
import com.mycompany.aiskillgapanalyzerweb.model.StudentSkill;
import com.mycompany.aiskillgapanalyzerweb.model.SkillView;
import com.mycompany.aiskillgapanalyzerweb.util.HibernateUtil;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

@Repository
public class SkillDAO {

    // ADD OR UPDATE SKILL (prevents duplicate skills for the same student)
    public boolean addSkill(String skillName, int studentId, String skillLevel) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            // Find or create global skill
            Skill skill = session.createQuery(
                    "FROM Skill WHERE LOWER(skillName) = :name", Skill.class)
                    .setParameter("name", skillName.trim().toLowerCase())
                    .uniqueResult();

            if (skill == null) {
                skill = new Skill();
                skill.setSkillName(skillName.trim());
                session.save(skill);
            }

            // Check if student already has this skill
            StudentSkill existing = session.createQuery(
                    "FROM StudentSkill WHERE studentId = :studentId AND skillId = :skillId",
                    StudentSkill.class)
                    .setParameter("studentId", studentId)
                    .setParameter("skillId", skill.getSkillId())
                    .uniqueResult();

            if (existing != null) {
                // Update existing proficiency level
                existing.setSkillLevel(skillLevel);
                session.update(existing);
            } else {
                // Add new student skill
                StudentSkill studentSkill = new StudentSkill();
                studentSkill.setStudentId(studentId);
                studentSkill.setSkillId(skill.getSkillId());
                studentSkill.setSkillLevel(skillLevel);
                session.save(studentSkill);
            }

            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    public List<SkillView> getSkills(int studentId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT new com.mycompany.aiskillgapanalyzerweb.model.SkillView("
                    + "ss.studentSkillId, s.skillName, ss.skillLevel) "
                    + "FROM StudentSkill ss, Skill s "
                    + "WHERE ss.skillId = s.skillId "
                    + "AND ss.studentId = :id "
                    + "ORDER BY s.skillName ASC";

            return session.createQuery(hql, SkillView.class)
                    .setParameter("id", studentId)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    // UPDATE SKILL LEVEL
    public boolean updateSkill(int studentSkillId, int studentId, String skillLevel) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            StudentSkill skill = session.createQuery(
                    "FROM StudentSkill WHERE studentSkillId = :sid AND studentId = :uid",
                    StudentSkill.class)
                    .setParameter("sid", studentSkillId)
                    .setParameter("uid", studentId)
                    .uniqueResult();

            if (skill == null) {
                tx.rollback();
                return false;
            }

            skill.setSkillLevel(skillLevel);
            session.update(skill);

            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    // DELETE SKILL
    public boolean deleteSkill(int studentSkillId, int studentId) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            StudentSkill skill = session.createQuery(
                    "FROM StudentSkill WHERE studentSkillId = :sid AND studentId = :uid",
                    StudentSkill.class)
                    .setParameter("sid", studentSkillId)
                    .setParameter("uid", studentId)
                    .uniqueResult();

            if (skill == null) {
                tx.rollback();
                return false;
            }

            session.delete(skill);

            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
}
