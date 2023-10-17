CREATE DATABASE databaseddne1;
USE databaseddne1; 

-- LAS TABLAS SE ENCUENTRAN EN EL ORDEN NECESARIO PARA SU CORRECTA CREACIÓN

CREATE TABLE tipo_identificacion(
	id_tipo_id varchar(4) NOT NULL,
	nombre_identificacion varchar(4) NOT NULL,
	PRIMARY KEY (id_tipo_id)
);

CREATE TABLE tipo_persona(
    id_tpersona VARCHAR(4) NOT NULL,
    persona VARCHAR(11) NOT NULL, -- proveedor
    PRIMARY KEY(id_tpersona)
);

CREATE TABLE datos_persona(
    persona_id VARCHAR(15) NOT NULL,
    fk_tipo_identificacion varchar(4) NOT NULL,
    nombre_1 varchar(25) NOT NULL,
    nombre_2 varchar(25),
    apellido_1 varchar(25) NOT NULL,
    apellido_2 varchar(25),
    telefono varchar(15) NOT NULL,
    direccion varchar(65) NOT NULL, -- transversal 112B norte # 202A - 90 int 20 apto 1104 (51)
    correo varchar(70) NOT NULL, -- diego_sebastian_ladino_hernandez@correo.udistrital.edu.co (57)
    fk_tipo_persona VARCHAR(5) NOT NULL,
    PRIMARY KEY(persona_id, fk_tipo_identificacion), -- Esta tabla tiene una llave primaria compuesta
    FOREIGN KEY (fk_tipo_identificacion) REFERENCES tipo_identificacion(id_tipo_id),
    FOREIGN KEY (fk_tipo_persona) REFERENCES tipo_persona(id_tpersona)
);

CREATE TABLE empresas(
    id_empresa varchar(4) NOT NULL,
    NIT varchar(20) NOT NULL, -- 20 digitos dependiendo de la generacion de la cedula
    nombre_empresa varchar(90) NOT NULL,
    descripcion_empresa varchar(100), -- comercializadora de papel parafinado y de cocina (48)
    primary key (id_empresa)
);

CREATE TABLE proveedores(
    -- id_p int NOT NULL AUTO_INCREMENT,
    fk_id_proveedor varchar(15) NOT NULL,
    fk_ti_proveedor varchar(4) NOT NULL,
    fk_empresa VARCHAR(4) NOT NULL,
    PRIMARY KEY (fk_ti_proveedor, fk_id_proveedor),
    FOREIGN KEY (fk_id_proveedor, fk_ti_proveedor) REFERENCES datos_persona(persona_id, fk_tipo_identificacion),
    FOREIGN KEY (fk_empresa) REFERENCES empresas(id_empresa)
);

CREATE TABLE clientes(
    -- id_c int NOT NULL AUTO_INCREMENT,
    fk_id_cliente varchar(15) NOT NULL,
    fk_ti_cliente varchar(4) NOT NULL,
    fk_empresa VARCHAR(4) NOT NULL,
    PRIMARY KEY (fk_ti_cliente, fk_id_cliente),
    FOREIGN KEY (fk_id_cliente, fk_ti_cliente) REFERENCES datos_persona(persona_id, fk_tipo_identificacion),
    FOREIGN KEY (fk_empresa) REFERENCES empresas(id_empresa)
);

CREATE TABLE usuarios(
    id_usuario varchar(5) NOT NULL,
    alias varchar(25) NOT NULL, -- jefe de operaciones (19)
    contraseña blob NOT NULL,
    fk_id_empleado varchar(15) NOT NULL,
    fk_ti_empleado varchar(4) NOT NULL,
    estado_usuario TINYINT NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY ( fk_id_empleado, fk_ti_empleado) REFERENCES datos_persona(persona_id, fk_tipo_identificacion)
);

CREATE TABLE permisos(
    id_permiso varchar(5) NOT NULL,
    permiso_sistema varchar(45) NOT NULL,
    PRIMARY KEY (id_permiso)
);

CREATE TABLE usuario_permiso(
    id_usuario_permiso int NOT NULL AUTO_INCREMENT,
    fk_usuario varchar(5) NOT NULL,
    fk_permiso varchar(5) NOT NULL,
    PRIMARY KEY (id_usuario_permiso),
    FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (fk_permiso) REFERENCES permisos(id_permiso)
);

CREATE TABLE estado(
    id_estado varchar(5) NOT NULL,
    tipo_estado varchar(12) NOT NULL, -- En Espera(9)
    PRIMARY KEY (id_estado)
);

CREATE TABLE tipo_insumo(
    id_tipo_insumo varchar(5) NOT NULL,
    nombre_insumo varchar(20) NOT NULL, -- Rollo Carton
    PRIMARY KEY (id_tipo_insumo)
);

CREATE TABLE insumos(
    id_insumo int NOT NULL AUTO_INCREMENT,
    consecutivo_insumo varchar(20) NOT NULL,-- PP3A0231046140(14)
    peso_insumo decimal(6,2),
    fk_tipo_insumo varchar(5) NOT NULL,
    PRIMARY KEY (id_insumo),
    FOREIGN KEY (fk_tipo_insumo) REFERENCES tipo_insumo(id_tipo_insumo)
);

CREATE TABLE inventario_insumos(
    id_inventario_insumos int NOT NULL AUTO_INCREMENT,
    fk_insumo int NOT NULL,
    fk_estado  varchar(5) NOT NULL,
    unidades int NOT NULL,
    fecha_planificada date,
    fecha_registro datetime NOT NULL,
    fk_proveedor varchar(15) NOT NULL, 
    fk_ti_proveedor varchar(4) NOT NULL,
    fk_usuario varchar(5) NOT NULL,
    estado_registro TINYINT NOT NULL,
    PRIMARY KEY (id_inventario_insumos),
    FOREIGN KEY (fk_estado) REFERENCES estado(id_estado),
    FOREIGN KEY (fk_insumo) REFERENCES insumos(id_insumo),
    FOREIGN KEY (fk_ti_proveedor, fk_proveedor) REFERENCES proveedores(fk_ti_proveedor, fk_id_proveedor),
    FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE tipo_producto(
    id_tipo_producto varchar(5) NOT NULL,
    tipo_producto varchar(17) NOT NULL, -- Rollo Jumbo(11)
    PRIMARY KEY(id_tipo_producto)
);

CREATE TABLE estilos(
    id_estilo varchar(5) NOT NULL,
    tipo_estilo varchar(12) NOT NULL, -- cuadro o custom (6)
    figura_color varchar(17) NOT NULL, -- Hamburguesa(11)
    PRIMARY KEY (id_estilo)
);

CREATE TABLE medida_producto(
    id_medida varchar(5) NOT NULL,
    medi_1 varchar(4) NOT NULL,
    medi_2 varchar(4),
    medi_3 varchar(4),
    PRIMARY KEY (id_medida)
);

CREATE TABLE productos( -- verificar si la tabla va a generar demasiados registros ó si son contables para determinar un PK varchar(5)
    id_producto int NOT NULL AUTO_INCREMENT,
    fk_tipo_producto varchar(5) NOT NULL,
    fk_estilo varchar(5) NOT NULL,
    fk_medida_producto varchar(5) NOT NULL,
    peso_producto decimal(6,2),
    precio_producto varchar(15), -- 10.200.200 (10)
    PRIMARY KEY (id_producto),
    FOREIGN KEY (fk_tipo_producto) REFERENCES tipo_producto(id_tipo_producto),
    FOREIGN KEY (fk_estilo) REFERENCES estilos(id_estilo),
    FOREIGN KEY (fk_medida_producto) REFERENCES medida_producto(id_medida)
);

CREATE TABLE inventario_produccion(
    id_produccion INT NOT NULL AUTO_INCREMENT,
    fk_producto int NOT NULL,
    unidades int NOT NULL,
    parafina_consumida decimal(6,2) NOT NULL,
    fecha_registro date NOT NULL,
    fk_usuario varchar(5) NOT NULL,
    estado_registro TINYINT NOT NULL,
    PRIMARY KEY (id_produccion),
    FOREIGN KEY (fk_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE tipo_documento(
    id_tipo_documento varchar(5) NOT NULL,
    documento_transaccion varchar(15) NOT NULL UNIQUE, -- Remisión(8)
    PRIMARY KEY (id_tipo_documento)
); 

CREATE TABLE tipo_transaccion(
    id_tipo_transaccion varchar(5) NOT NULL,
    transaccion varchar(10) NOT NULL UNIQUE, -- venta (5)
    PRIMARY KEY (id_tipo_transaccion)
);

CREATE TABLE transacciones(
    id_transacciones int NOT NULL AUTO_INCREMENT,
    fk_tipo_transaccion varchar(5) NOT NULL,
    fk_tipo_documento  varchar(5) NOT NULL,
    fk_articulo int NOT NULL,
    fk_t_identi varchar(4) NOT NULL, 
    fk_persona varchar(13) NOT NULL, -- Cliente o Proveedor(9)
    fecha_registro date NOT NULL,
    precio varchar(15) NOT NULL,
    comprobante varchar(150) NOT NULL, -- La idea seria guardar el enlace de la ruta, donde se vaya a guardar el documento para no llenar la BD con ese tipo de archivos
    PRIMARY KEY (id_transacciones),
    FOREIGN KEY (fk_tipo_transaccion) REFERENCES tipo_transaccion(id_tipo_transaccion),
    FOREIGN KEY (fk_tipo_documento) REFERENCES tipo_documento(id_tipo_documento),
    -- dependiendo el tipo de transaccion se elige entre producto o insumo
    FOREIGN KEY (fk_articulo) REFERENCES insumos(id_insumo),
    FOREIGN KEY (fk_articulo) REFERENCES productos(id_producto),
    -- dependiendo el tipo de transaccion se elige entre cliente o proveedor
    FOREIGN KEY (fk_t_identi, fk_persona) REFERENCES proveedores(fk_ti_proveedor, fk_id_proveedor),
    FOREIGN KEY (fk_t_identi, fk_persona) REFERENCES clientes(fk_ti_cliente, fk_id_cliente)
);

