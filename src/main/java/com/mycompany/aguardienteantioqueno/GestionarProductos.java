/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.aguardienteantioqueno;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GestionarProductos {
    public static Connection establecerConexion() {
         String url = "jdbc:mysql://licoresantioquenomysql.mysql.database.azure.com:3306/tu_base_de_datos?useSSL=true";
        String user = "licores";
        String password = "Jhon12345";

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Conexion exitosa");
            }
        } catch (Exception e) {
            System.out.println("Error de conexion" + e.getMessage());
        }
        return conn;
    }
    
    public static Connection establecerConexionAzure() {
        String url = "jdbc:mysql://licoresantioquenomysql.mysql.database.azure.com";
        String user = "licores";
        String password = "Jhon12345"; // Reemplaza con la contraseña real
        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            if (conn != null) {
                System.out.println("Conexion Azure exitosa");
            }
        } catch (Exception e) {
            System.out.println("Error de conexion Azure: " + e.getMessage());
        }
        return conn;
    }
    
    public static void crearProducto(String nombre, int precio, int stock, String imagen) {
        String sql = "INSERT INTO productos (nombre, precio, stock, imagen) VALUES (?, ?, ?, ?)";

        try (Connection connection = establecerConexion();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, nombre);
            preparedStatement.setInt(2, precio);
            preparedStatement.setInt(3, stock);
            preparedStatement.setString(4, imagen);

            preparedStatement.executeUpdate();
            System.out.println("Producto agregado exitosamente");
        } catch (SQLException e) {
            System.out.println("Error al agregar producto: " + e.getMessage());
        }
    }
    public boolean eliminarProducto(int idProducto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean eliminado = false;

        try {
            conn = establecerConexion();

            String sql = "DELETE FROM productos WHERE idProductos = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idProducto);

            int filasAfectadas = pstmt.executeUpdate();
            eliminado = (filasAfectadas > 0);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return eliminado;
    }
    
    // Método para comprar un producto y actualizar el stock en la base de datos
    public void comprarProducto(int idProducto, Connection conn) throws SQLException {
        String sql = "UPDATE productos SET stock = stock - 1 WHERE idProductos = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idProducto);
            pstmt.executeUpdate();
        }
    }
}
    