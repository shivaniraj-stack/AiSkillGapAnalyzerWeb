package com.mycompany.aiskillgapanalyzerweb.util;

import com.mycompany.aiskillgapanalyzerweb.model.Student;
import com.mycompany.aiskillgapanalyzerweb.model.Skill;
import com.mycompany.aiskillgapanalyzerweb.model.StudentSkill;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            Configuration configuration = new Configuration();

            // Load connection settings from DBConnection (supports db.properties & env vars)
            configuration.setProperty("hibernate.connection.driver_class", DBConnection.getDriver());
            configuration.setProperty("hibernate.connection.url", DBConnection.getUrl());
            configuration.setProperty("hibernate.connection.username", DBConnection.getUser());
            configuration.setProperty("hibernate.connection.password", DBConnection.getPassword());

            // Hibernate settings
            configuration.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
            configuration.setProperty("hibernate.show_sql", "false");
            configuration.setProperty("hibernate.format_sql", "true");

            // Automatically create or update existing tables
            configuration.setProperty("hibernate.hbm2ddl.auto", "update");

            // Register entity classes
            configuration.addAnnotatedClass(Student.class);
            configuration.addAnnotatedClass(Skill.class);
            configuration.addAnnotatedClass(StudentSkill.class);

            return configuration.buildSessionFactory();
        } catch (Throwable e) {
            System.err.println("Hibernate Configuration Failed: " + e.getMessage());
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null && !sessionFactory.isClosed()) {
            sessionFactory.close();
        }
    }
}
