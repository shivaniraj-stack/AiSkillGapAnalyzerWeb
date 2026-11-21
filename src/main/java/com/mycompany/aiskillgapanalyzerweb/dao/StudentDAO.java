package com.mycompany.aiskillgapanalyzerweb.dao;

import com.mycompany.aiskillgapanalyzerweb.model.Student;
import com.mycompany.aiskillgapanalyzerweb.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDAO {

    public boolean saveStudent(Student student) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(student);
            transaction.commit();
            return true;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    public Student loginStudent(String email, String passwordHash) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Student WHERE email = :email AND passwordHash = :passwordHash";
            return session.createQuery(hql, Student.class)
                    .setParameter("email", email)
                    .setParameter("passwordHash", passwordHash)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean isEmailRegistered(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT count(s) FROM Student s WHERE s.email = :email";
            Long count = session.createQuery(hql, Long.class)
                    .setParameter("email", email)
                    .uniqueResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Student getStudentById(int studentId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Student.class, studentId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean updateCareerGoal(int studentId, String careerGoal) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Student student = session.get(Student.class, studentId);
            if (student != null) {
                student.setCareerGoal(careerGoal);
                session.update(student);
                transaction.commit();
                return true;
            }
            if (transaction != null) transaction.rollback();
            return false;
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }
}
