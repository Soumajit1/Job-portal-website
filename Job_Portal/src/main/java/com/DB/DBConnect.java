package com.DB;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

    private static Connection conn;

    public static Connection getConn() {

        try {

            if (conn == null || conn.isClosed()) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                String host = System.getenv("DB_HOST");
                String port = System.getenv("DB_PORT");
                String database = System.getenv("DB_NAME");
                String username = System.getenv("DB_USER");
                String password = System.getenv("DB_PASSWORD");

                String url = "jdbc:mysql://" + host + ":" + port + "/" + database
                        + "?useSSL=true"
                        + "&requireSSL=true"
                        + "&serverTimezone=UTC"
                        + "&useUnicode=true"
                        + "&characterEncoding=UTF-8";

                conn = DriverManager.getConnection(
                        url,
                        username,
                        password
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }
}
