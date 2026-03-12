package com.health;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            // Read Railway environment variables
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String database = System.getenv("MYSQLDATABASE");
            String username = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD");

            // Construct JDBC URL
            String url = "jdbc:mysql://" + host + ":" + port + "/" + database +
                         "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to DB
            con = DriverManager.getConnection(url, username, password);

            System.out.println("DATABASE CONNECTED SUCCESSFULLY");

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION FAILED");
            e.printStackTrace();
        }

        return con;
    }
}