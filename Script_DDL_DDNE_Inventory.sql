CREATE DATABASE database_ddne;
USE database_ddne;

-- LAS TABLAS SE ENCUENTRAN EN EL ORDEN NECESARIO PARA SU CORRECTA CREACIÓN

CREATE TABLE tipo_identificacion(
	tipo_id varchar(4) NOT NULL,
	PRIMARY KEY (tipo_id)
);

CREATE TABLE tipo_persona(
    tipo_persona VARCHAR(11) NOT NULL, -- proveedor
    PRIMARY KEY(tipo_persona)
);

CREATE TABLE datos_persona(
    -- id_dpersona int NOT NULL AUTO_INCREMENT,
    persona_id VARCHAR(15) NOT NULL,
    fk_tipo_identificacion varchar(4) NOT NULL,
    nombre_1 varchar(25) NOT NULL,
    nombre_2 varchar(25),
    apellido_1 varchar(25) NOT NULL,
    apellido_2 varchar(25),
    telefono varchar(15) NOT NULL,
    direccion varchar(65) NOT NULL, -- transversal 112B norte # 202A - 90 int 20 apto 1104 (51)
    correo varchar(70) NOT NULL, -- diego_sebastian_ladino_hernandez@correo.udistrital.edu.co (57)
    fk_tipo_persona varchar(11) NOT NULL,
    fecha_registro datetime NOT NULL,
    PRIMARY KEY(persona_id, fk_tipo_identificacion), -- Esta tabla tiene una llave primaria compuesta
    FOREIGN KEY (fk_tipo_identificacion) REFERENCES tipo_identificacion(tipo_id) ON UPDATE CASCADE,
    FOREIGN KEY (fk_tipo_persona) REFERENCES tipo_persona(tipo_persona) ON UPDATE CASCADE
);

CREATE TABLE empresas(
    nit varchar(20) NOT NULL, -- 20 digitos dependiendo de la generacion de la cedula
    nombre_empresa varchar(90) NOT NULL,
    descripcion_empresa varchar(70), -- comercializadora de papel parafinado y de cocina (48)
    primary key (nit)
);

CREATE TABLE proveedores(
    -- id_proveedor int NOT NULL AUTO_INCREMENT,
    fk_id_proveedor varchar(15) NOT NULL,
    fk_ti_proveedor varchar(4) NOT NULL,
    fk_empresa varchar(20) NOT NULL,
    estado_proveedor TINYINT NOT NULL,
    PRIMARY KEY (fk_ti_proveedor, fk_id_proveedor),
    FOREIGN KEY (fk_id_proveedor, fk_ti_proveedor) REFERENCES datos_persona(persona_id, fk_tipo_identificacion) ON UPDATE CASCADE,
    FOREIGN KEY (fk_empresa) REFERENCES empresas(nit) ON UPDATE CASCADE
);

CREATE TABLE clientes(
    -- id_c int NOT NULL AUTO_INCREMENT,
    fk_id_cliente varchar(15) NOT NULL,
    fk_ti_cliente varchar(4) NOT NULL,
    fk_empresa varchar(20) NOT NULL,
    estado_cliente TINYINT NOT NULL,
    PRIMARY KEY (fk_ti_cliente, fk_id_cliente),
    FOREIGN KEY (fk_id_cliente, fk_ti_cliente) REFERENCES datos_persona(persona_id, fk_tipo_identificacion) ON UPDATE CASCADE,
    FOREIGN KEY (fk_empresa) REFERENCES empresas(nit) ON UPDATE CASCADE
);

CREATE TABLE usuarios(
    id_usuario int NOT NULL AUTO_INCREMENT,
    alias varchar(25) NOT NULL, -- jefe de operaciones (19)
    contraseña TEXT NOT NULL,
    fk_id_empleado varchar(15) NOT NULL,
    fk_ti_empleado varchar(4) NOT NULL,
    estado_usuario TINYINT NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY ( fk_id_empleado, fk_ti_empleado) REFERENCES datos_persona(persona_id, fk_tipo_identificacion) ON UPDATE CASCADE
);

CREATE TABLE permisos(
    id_permiso int NOT NULL AUTO_INCREMENT,
    permiso_sistema varchar(45) NOT NULL,
    PRIMARY KEY (id_permiso)
);

CREATE TABLE usuario_permiso(
    id_usuario_permiso int NOT NULL AUTO_INCREMENT,
    fk_usuario int NOT NULL,
    fk_permiso int NOT NULL,
    PRIMARY KEY (id_usuario_permiso),
    FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (fk_permiso) REFERENCES permisos(id_permiso) ON UPDATE CASCADE
);

-- TABLAS PARA TRANSACCIONES
CREATE TABLE tipo_documento(
    doc_transaccion varchar(15) NOT NULL UNIQUE, -- Remisión(8)
    PRIMARY KEY (doc_transaccion)   
); 

CREATE TABLE tipo_transaccion(
    tp_transaccion varchar(10) NOT NULL UNIQUE, -- venta (5)
    PRIMARY KEY (tp_transaccion)
);

-- TABLAS PARA INVENTARIOS
CREATE TABLE estado(
    tipo_estado varchar(12) NOT NULL, -- En Espera(9)
    PRIMARY KEY (tipo_estado)
);

CREATE TABLE tipo_insumo(
    nombre_insumo varchar(20) NOT NULL, -- Rollo Carton
    PRIMARY KEY (nombre_insumo)
);

-- TABLAS PARA PRODUCTOS
CREATE TABLE tipo_producto(
    producto varchar(17) NOT NULL, -- Rollo Jumbo(11)
    descripcion varchar(250),
    imagen varchar(100) NOT NULL,
    PRIMARY KEY(producto)
);

CREATE TABLE precios_productos(
    id_precios varchar(10) NOT NULL,
    descripcion varchar(20) NOT NULL,
    unidad_medida varchar(3) NOT NULL,
    peso_kg int,	
    medida varchar(10),
    cantidad int,
    precio decimal(6,3) NOT NULL,
    PRIMARY KEY (id_precios)
);

CREATE TABLE productos(
    id_producto int NOT NULL AUTO_INCREMENT,
    fk_tipo_producto varchar(17) NOT NULL,
    fk_precio varchar(10) NOT NULL, 
    comentario varchar(45), -- para posibles medidas o especificaciones
    PRIMARY KEY (id_producto),
    FOREIGN KEY (fk_tipo_producto) REFERENCES tipo_producto(producto) ON UPDATE CASCADE,
    FOREIGN KEY (fk_precio) REFERENCES precios_productos(id_precios) ON UPDATE CASCADE
);

-- --
CREATE TABLE transacciones_compras(
    id_transacciones int NOT NULL AUTO_INCREMENT,
    fk_tipo_transaccion varchar(10) NOT NULL,
    fk_tipo_documento  varchar(15) NOT NULL,
    fk_articulo varchar(20) NOT NULL,
    fk_t_identi varchar(4) NOT NULL, 
    fk_proveedor varchar(15) NOT NULL, -- Proveedor(9)
    fecha_registro date NOT NULL,
    precio varchar(15) NOT NULL,
    comprobante varchar(150) NOT NULL, -- Enlace de la ruta donde guarde
    PRIMARY KEY (id_transacciones),
    FOREIGN KEY (fk_tipo_transaccion) REFERENCES tipo_transaccion(tp_transaccion) ON UPDATE CASCADE,
    FOREIGN KEY (fk_tipo_documento) REFERENCES tipo_documento(doc_transaccion) ON UPDATE CASCADE,
    FOREIGN KEY (fk_articulo) REFERENCES tipo_insumo(nombre_insumo) ON UPDATE CASCADE,
    FOREIGN KEY (fk_t_identi, fk_proveedor) REFERENCES proveedores (fk_ti_proveedor, fk_id_proveedor) ON UPDATE CASCADE
);

CREATE TABLE transacciones_ventas(
    id_transacciones int NOT NULL AUTO_INCREMENT,
    fk_tipo_transaccion varchar(10) NOT NULL,
    fk_tipo_documento  varchar(15) NOT NULL,
    fk_articulo varchar(17) NOT NULL,
    fk_t_identi varchar(4) NOT NULL, 
    fk_cliente varchar(15) NOT NULL, -- Cliente (9)
    fecha_registro date NOT NULL,
    precio varchar(15) NOT NULL,
    comprobante varchar(150) NOT NULL, -- Enlace de la ruta donde guarde
    PRIMARY KEY (id_transacciones),
    FOREIGN KEY (fk_tipo_transaccion) REFERENCES tipo_transaccion(tp_transaccion) ON UPDATE CASCADE,
    FOREIGN KEY (fk_tipo_documento) REFERENCES tipo_documento(doc_transaccion) ON UPDATE CASCADE,
    FOREIGN KEY (fk_articulo) REFERENCES tipo_producto(producto) ON UPDATE CASCADE,
    FOREIGN KEY (fk_t_identi, fk_cliente) REFERENCES clientes(fk_ti_cliente, fk_id_cliente) ON UPDATE CASCADE
);

CREATE TABLE inventario_insumos(
    id_inventario_insumos int NOT NULL AUTO_INCREMENT,
    fk_n_transaccion  int NOT NULL,
    fk_tipo_insumo varchar(20) NOT NULL,
    consecutivo_insumo varchar(20) NOT NULL,-- PP3A0231046140(14)
    peso_insumo decimal(6,2), -- En Papel el peso que se ingresa es el del Rollo Grande, no el de cada rollo impreso y el peso de c/u se asigna en inventario producción
    unidades int NOT NULL,
    fk_estado  varchar(12) NOT NULL,
    fecha_planificada date NOT NULL,
    fecha_recepcion date,
    fecha_registro date NOT NULL,
    fk_proveedor varchar(15) NOT NULL, 
    fk_ti_proveedor varchar(4) NOT NULL,
    fk_usuario int NOT NULL,
    estado_registro TINYINT NOT NULL,
    PRIMARY KEY (id_inventario_insumos),
    FOREIGN KEY (fk_tipo_insumo) REFERENCES tipo_insumo(nombre_insumo) ON UPDATE CASCADE,
    FOREIGN KEY (fk_estado) REFERENCES estado(tipo_estado) ON UPDATE CASCADE,
    FOREIGN KEY (fk_ti_proveedor, fk_proveedor) REFERENCES proveedores(fk_ti_proveedor, fk_id_proveedor) ON UPDATE CASCADE,
    FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario), -- Este Campo no se puede actualizar debido a que los usuarios no se eliminarán sino que solo se inhabilitarán.
    FOREIGN KEY (fk_n_transaccion) REFERENCES transacciones_compras(id_transacciones)
)AUTO_INCREMENT = 100;


-- TABLAS PARA INV-PRODUCCIÓN --
CREATE TABLE colores(
    color varchar(12) NOT NULL, -- amarillo(8)
    PRIMARY KEY (color)
);

CREATE TABLE rollos_medianos(
    id_rollos_medianos int NOT NULL AUTO_INCREMENT,
    fecha_registro date NOT NULL,   
    fk_insumo int NOT NULL,
    fk_color_1 varchar(12) NOT NULL,
    fk_color_2 varchar(12) NOT NULL,
    peso decimal(6,2) NOT NULL,
    fk_usuario int NOT NULL,
    estado_registro TINYINT NOT NULL,

    PRIMARY KEY (id_rollos_medianos),
    FOREIGN KEY (fk_insumo) REFERENCES inventario_insumos(id_inventario_insumos),
    FOREIGN KEY (fk_color_1) REFERENCES colores(color) ON UPDATE CASCADE,
    FOREIGN KEY (fk_color_2) REFERENCES colores(color) ON UPDATE CASCADE
);

CREATE TABLE cortes_jumbo(
    fecha_registro date NOT NULL,
    pfk_rollo_mediano int NOT NULL,
    rollo_jumbo int NOT NULL,
    peso_jumbo decimal(6,2) NOT NULL,
    fk_color varchar(12) NOT NULL,
    fk_usuario int NOT NULL,
    estado_registro TINYINT NOT NULL,

    FOREIGN KEY (pfk_rollo_mediano) REFERENCES rollos_medianos(id_rollos_medianos),
    FOREIGN KEY (fk_color) REFERENCES colores(color) ON UPDATE CASCADE,
    PRIMARY KEY (pfk_rollo_mediano, rollo_jumbo)
);

CREATE TABLE inventario_produccion(
    id_inv_produccion INT NOT NULL AUTO_INCREMENT,
    fecha_registro date NOT NULL,
    fk_rollo_mediano int NOT NULL,
    fk_rollo_jumbo int NOT NULL, -- Se podría generar un unico espacio al concatenar ambos IDs
    fk_color varchar(12) NOT NULL,
    fk_producto int NOT NULL,
    peso_producto decimal(6,2) NOT NULL,
    fk_usuario int NOT NULL,
    estado_registro TINYINT NOT NULL,

    PRIMARY KEY (id_inv_produccion),
    FOREIGN KEY (fk_rollo_mediano, fk_rollo_jumbo) REFERENCES cortes_jumbo(pfk_rollo_mediano, rollo_jumbo),
    FOREIGN KEY (fk_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (fk_color) REFERENCES colores(color) ON UPDATE CASCADE
)AUTO_INCREMENT = 100;

-- CREATE TABLE informe_produccion(
--     id_inf_produccion INT NOT NULL AUTO_INCREMENT,
--     peso_corte decimal(6,2) NOT NULL,
--     parafina_consumida decimal(6,2) NOT NULL,
    
--     PRIMARY KEY (id_inf_produccion)
-- )
