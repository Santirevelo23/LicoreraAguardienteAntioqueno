<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.aguardienteantioqueno.GestionarProductos"%>
<%@include file= "templates/header.jsp" %>
<header class="bg-dark text-white text-center py-5">
    <div class="container">
        <h1 class="display-4">Bienvenido a la Tienda de Licores</h1>
        <p class="lead">Somos los mayores distribuidores de licores de toda Colombia.</p>
    </div>
    <hr class="my-4">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h2>Sobre Nosotros</h2>
                <p class="mt-4">En Tienda de Licores, nos enorgullece ser los mayores distribuidores de licores de toda Colombia. Con más de 20 años de experiencia en el mercado, ofrecemos una amplia selección de bebidas alcohólicas de alta calidad, incluyendo vinos, cervezas, y destilados de las mejores marcas nacionales e internacionales. Nuestro compromiso es brindar a nuestros clientes una experiencia de compra excepcional, con precios competitivos y un servicio al cliente inigualable.</p>
            </div>
        </div>
    </div>
</header>


<div class="text-center mt-4">
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#AgregarProductos">
        Añadir Productos
    </button>
    <a href="agregarProducto.jsp" class="btn btn-success">Añadir Productos</a>
</div>

<div class="container mt-5">
    <div class="row justify-content-center">
        <%
            GestionarProductos gestionar = new GestionarProductos();
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = gestionar.establecerConexion();

                String sql = "SELECT idProductos, nombre, precio, stock, imagen FROM productos";

                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int idProducto = rs.getInt("idProductos");
                    String nombre = rs.getString("nombre");
                    int precio = rs.getInt("precio");
                    int stock = rs.getInt("stock");
                    String imagen = rs.getString("imagen");
        %>
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><%= nombre%></h5>
                    <p class="card-text">Precio: $<%= precio%></p>
                    <p class="card-text">Stock: <%= stock%> unidades</p>
                    <img src="imagenes/<%= imagen%>" class="card-img-top" alt="<%= nombre%>">
                    <%
                        // Verificar si el stock es mayor que 0 para habilitar la compra
                        if (stock > 0) {
                    %>
                    <form action="SvComprar" method="POST">
                        <input type="hidden" name="idProducto" value="<%= idProducto%>">
                        <button type="submit" class="btn btn-primary btn-block">
                            <i class="fas fa-cart-plus"></i> Comprar
                        </button>
                    </form>
                    <%
                    } else {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Este producto está agotado.
                    </div>
                    <%
                        }
                    %>
                    <div class="mt-2">
                        <a href="SvAgregarProducto?id=<%= idProducto%>" class="btn btn-danger btn-block">
                            <i class="fas fa-trash-alt"></i> Eliminar
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</div>

<div class="modal fade" id="AgregarProductos" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Agregar Producto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="SvAgregarProducto" method="POST" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre del Producto</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="precio" class="form-label">Precio</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="precio" name="precio" min="0" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="imagen" class="form-label">Imagen del Producto</label>
                        <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Agregar Producto</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<%@include file= "templates/footer.jsp" %>