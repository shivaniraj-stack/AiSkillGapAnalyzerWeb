package com.mycompany.aiskillgapanalyzerweb.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {

    private static String driver = "com.mysql.cj.jdbc.Driver";
    private static String url = "jdbc:mysql://localhost:3306/ai_skill_gap_analyzer?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static String user = "root";
    private static String password = "";

    static {
        try {
            // 1. Try to load from db.properties
            try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
                if (in != null) {
                    Properties props = new Properties();
                    props.load(in);
                    if (props.getProperty("db.driver") != null) driver = props.getProperty("db.driver");
                    if (props.getProperty("db.url") != null) url = props.getProperty("db.url");
                    if (props.getProperty("db.user") != null) user = props.getProperty("db.user");
                    if (props.getProperty("db.password") != null) password = props.getProperty("db.password");
                }
            } catch (Exception ignored) {
            }

            // 2. Allow environment variables to override for cloud/docker deployment
            String envUrl = System.getenv("DB_URL");
            String envUser = System.getenv("DB_USER");
            String envPass = System.getenv("DB_PASSWORD");
            if (envUrl != null && !envUrl.trim().isEmpty()) url = envUrl;
            if (envUser != null && !envUser.trim().isEmpty()) user = envUser;
            if (envPass != null) password = envPass;

            Class.forName(driver);
        } catch (Exception e) {
            System.err.println("DBConnection Initialization Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        Connection con = null;
        try {
            con = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            System.err.println("Database Connection Failed to URL: " + url);
            e.printStackTrace();
        }
        return con;
    }

    public static String getUrl() { return url; }
    public static String getUser() { return user; }
    public static String getPassword() { return password; }
    public static String getDriver() { return driver; }
}
