/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import com.mycompany.aguardienteantioqueno.GestionarProductos;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author juand
 */
@WebServlet(name = "SvComprar", urlPatterns = {"/SvComprar"})
public class SvComprar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvComprar</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvComprar at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el ID del producto de la solicitud
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));

        // Obtener la conexión a la base de datos
        Connection conn = null;
        try {
            conn = GestionarProductos.establecerConexion();

            // Llamar al método comprarProducto para actualizar el stock
            GestionarProductos gestionarProductos = new GestionarProductos();
            gestionarProductos.comprarProducto(idProducto, conn);

            // Redireccionar a una página de éxito o a la página principal
            response.sendRedirect("index.jsp");
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo adecuado de errores, por ejemplo, redirigir a una página de error
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
