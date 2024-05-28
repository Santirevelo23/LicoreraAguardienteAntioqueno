<%@include file= "templates/header.jsp" %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Agregar Nuevo Producto</h5>
                </div>
                <div class="card-body">
                    <form action="SvAgregarProducto" method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="nombre">Nombre del Producto</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                        </div>
                        <div class="form-group">
                            <label for="precio">Precio</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input type="number" class="form-control" id="precio" name="precio" min="0" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="stock">Stock</label>
                            <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                        </div>
                        <div class="form-group">
                            <label for="imagen">Imagen del Producto</label>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="imagen" name="imagen" accept="image/*" required>
                                <label class="custom-file-label" for="imagen">Seleccionar archivo...</label>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Agregar Producto</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file= "templates/footer.jsp" %>
