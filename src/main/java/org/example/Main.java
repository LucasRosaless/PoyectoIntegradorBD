package org.example;

import org.example.dao.ReclamoDAO;
import org.example.dao.UsuarioDAO;
import org.example.model.ReclamoResumen;

import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        ReclamoDAO reclamoDAO = new ReclamoDAO();

        System.out.println("Conectando a la base de datos...");
        dbConnection.conectar();

        boolean salir = false;
        while (!salir) {
            System.out.println();
            System.out.println("=== Menu ===");
            System.out.println("1) Insertar usuario");
            System.out.println("2) Eliminar reclamo");
            System.out.println("3) Listar reclamos por usuario (con cantidad de rellamados)");
            System.out.println("0) Salir");
            System.out.print("Opcion: ");

            if (!scanner.hasNextLine()) {
                System.out.println();
                System.out.println("Entrada finalizada (EOF). Saliendo...");
                break;
            }

            String opcion = scanner.nextLine().trim();
            
            switch (opcion) {
                case "1":
                    try {
                        System.out.print("Inserte Nombre: ");
                        if (!scanner.hasNextLine()) { System.out.println("Entrada finalizada. Cancelando."); break; }
                        String nombre = scanner.nextLine().trim();
                        System.out.print("Inserte Direccion: ");
                        if (!scanner.hasNextLine()) { System.out.println("Entrada finalizada. Cancelando."); break; }
                        String direccion = scanner.nextLine().trim();
                        usuarioDAO.insertarUsuario(nombre, direccion);
                        System.out.println("Usuario insertado correctamente.");
                    } catch (SQLException e) {
                        System.out.println("Error al insertar usuario: " + e.getMessage());
                    }
                    break;
                case "2":
                    try {
                        System.out.print("ID de reclamo a eliminar: ");
                        if (!scanner.hasNextLine()) { System.out.println("Entrada finalizada. Cancelando."); break; }
                        int reclamoId = Integer.parseInt(scanner.nextLine().trim());
                        reclamoDAO.eliminarReclamoPorId(reclamoId);
                        System.out.println("Reclamo eliminado (y sus rellamados, si existian).");
                    } catch (Exception e) {
                        System.out.println("Error al eliminar reclamo: " + e.getMessage());
                    }
                    break;
                case "3":
                    try {
                        System.out.print("ID de usuario: ");
                        if (!scanner.hasNextLine()) { System.out.println("Entrada finalizada. Cancelando."); break; }
                        int usuarioId = Integer.parseInt(scanner.nextLine().trim());
                        List<ReclamoResumen> lista = reclamoDAO.listarReclamosPorUsuarioConRellamados(usuarioId);
                        if (lista.isEmpty()) {
                            System.out.println("No se encontraron reclamos para el usuario.");
                        } else {
                            System.out.println("ID | Cant. Rellamados | Descripcion");
                            for (ReclamoResumen r : lista) {
                                System.out.println(r.getId() + " | " + r.getCantidadRellamados() + " | " + r.getDescripcion());
                            }
                        }
                    } catch (Exception e) {
                        System.out.println("Error al listar reclamos: " + e.getMessage());
                    }
                    break;
                case "0":
                    salir = true;
                    break;
                default:
                    System.out.println("Opcion invalida.");
            }
        }

        System.out.println("Hasta luego!");
        scanner.close();
    }
}