package org.example;

import java.sql.*;

public class dbConnection {
    static String url = "jdbc:mysql://localhost:3306/proyectobd";

    static String dbUser = "root";
    static String dbPassword = "root";

    public static Connection conectar() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPassword);
            System.out.println("Conectado con Exito!");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.out.println("No se encontró el driver de MySQL en el classpath.");
            e.printStackTrace();
        }

        return con;
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, dbUser, dbPassword);
    }

}
