package org.example.dao;

import org.example.dbConnection;
import org.example.model.ReclamoResumen;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReclamoDAO {

	public void eliminarReclamoPorId(int reclamoId) throws SQLException {
		String deleteRellamados = "DELETE FROM Rellamado WHERE Nro_reclamo = ?";
		String deleteReclamo = "DELETE FROM Reclamo WHERE Nro_reclamo = ?";
		try (Connection con = dbConnection.getConnection()) {
			try (PreparedStatement ps1 = con.prepareStatement(deleteRellamados)) {
				ps1.setInt(1, reclamoId);
				ps1.executeUpdate();
			}
			try (PreparedStatement ps2 = con.prepareStatement(deleteReclamo)) {
				ps2.setInt(1, reclamoId);
				ps2.executeUpdate();
			}
		}
	}

	public List<ReclamoResumen> listarReclamosPorUsuarioConRellamados(int usuarioId) throws SQLException {
		String sql = "SELECT reclamos.id, reclamos.descripcion, COUNT(rellamados.id)" +
                "FROM reclamos" +
                "LEFT JOIN rellamados ON rellamados.reclamo_id = reclamos.id" +
                "WHERE reclamos.usuario_id = ?" +
                "GROUP BY reclamos.id, reclamos.descripcion" +
                "ORDER BY reclamos.id";
		List<ReclamoResumen> lista = new ArrayList<>();
		try (Connection con = dbConnection.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, usuarioId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					int id = rs.getInt("id");
					String descripcion = rs.getString("descripcion");
					long cantidad = rs.getLong("cantidad_rellamados");
					lista.add(new ReclamoResumen(id, descripcion, cantidad));
				}
			}
		}
		return lista;
	}
}


