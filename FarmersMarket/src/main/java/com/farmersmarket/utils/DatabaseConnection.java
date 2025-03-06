package com.farmersmarket.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/farmersmarket"; // Replace with your database URL
    private static final String USERNAME = "root"; // Replace with your database username
    private static final String PASSWORD = "password"; // Replace with your database password

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load the driver
        Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
//        connection.setAutoCommit(false); // Disable autocommit
        return connection;
    }
}