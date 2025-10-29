package org.example.dao;

import org.example.dbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UsuarioDAO {

	public void insertarUsuario(String nombre, String direccion) throws SQLException {
		String sql = "INSERT INTO usuario (nombre, direccion) VALUES (?, ?)";
		try (Connection con = dbConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, nombre);
			ps.setString(2, direccion);
			ps.executeUpdate();
		}
	}
}


