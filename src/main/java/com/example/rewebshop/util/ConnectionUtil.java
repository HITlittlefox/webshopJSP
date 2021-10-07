package com.example.rewebshop.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionUtil {
    private static final String user = "root";
    private static final String password = "123456";
    private static final String database = "web2021";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/" + database + "?serverTimezone=GMT" + "&user=" + user + "&password=" + password;
        return DriverManager.getConnection(url);
    }
}
