package org.example.model;

public class ReclamoResumen {
	private final int id;
	private final String descripcion;
	private final long cantidadRellamados;

	public ReclamoResumen(int id, String descripcion, long cantidadRellamados) {
		this.id = id;
		this.descripcion = descripcion;
		this.cantidadRellamados = cantidadRellamados;
	}

	public int getId() {
		return id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public long getCantidadRellamados() {
		return cantidadRellamados;
	}
}


