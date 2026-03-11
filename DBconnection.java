package com.health;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnection {

    public static Connection getConnection() {
        Connection con = null;

        try {

            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String database = System.getenv("MYSQLDATABASE");
            String username = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD");
            System.out.println("Host: " + host);
            System.out.println("Port: " + port);
            System.out.println("DB: " + database);

            String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?useSSL=false&serverTimezone=UTC";

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(url, username, password);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}