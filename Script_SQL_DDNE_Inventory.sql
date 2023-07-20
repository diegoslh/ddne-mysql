create database databaseddne;
use databaseddne; 

-- LAS TABLAS SE ENCUENTRAN EN EL ORDEN NECESARIO PARA SU CORRECTA CREACIÓN

CREATE TABLE tipo_identificacion(
id_tipo_id int NOT NULL AUTO_INCREMENT,
nombre_identificacion varchar(4) NOT NULL,
PRIMARY KEY (id_tipo_id)
);

CREATE TABLE datos_persona(
id_datos_persona int NOT NULL AUTO_INCREMENT,
persona_id int NOT NULL,
fk_tipo_identificacion int NOT NULL,
nombre_1 varchar(45) NOT NULL,
nombre_2 varchar(45),
apellido_1 varchar(45) NOT NULL,
apellido_2 varchar(45),
telefono varchar(20) NOT NULL,
direccion varchar(250),
correo varchar(100) NOT NULL,
PRIMARY KEY(id_datos_persona, persona_id), -- Esta tabla tiene una llave primaria compuesta
FOREIGN KEY (fk_tipo_identificacion) REFERENCES tipo_identificacion(id_tipo_id)
);

CREATE TABLE tipo_persona(
id_tipo_persona int NOT NULL AUTO_INCREMENT,
persona  varchar(45) NOT NULL,
PRIMARY KEY (id_tipo_persona)
);

CREATE TABLE empresas(
id_empresa int NOT NULL AUTO_INCREMENT,
NIT varchar(20) NOT NULL,
nombre_empresa varchar(100) NOT NULL,
descripcion_empresa varchar(250),
primary key (id_empresa)
);

CREATE TABLE personas(
id_persona int NOT NULL AUTO_INCREMENT,
fk_tipo_persona int NOT NULL,
fk_empresa int NOT NULL,
fk_datos_persona int NOT NULL,
PRIMARY KEY (id_persona),
FOREIGN KEY (fk_tipo_persona) REFERENCES tipo_persona(id_tipo_persona),
FOREIGN KEY (fk_empresa) REFERENCES empresas(id_empresa),
FOREIGN KEY (fk_datos_persona) REFERENCES datos_persona(id_datos_persona)
);

CREATE TABLE usuarios(
id_usuario int NOT NULL AUTO_INCREMENT,
alias varchar(45) NOT NULL,
fk_empleado int NOT NULL,
estado_usuario TINYINT NOT NULL,
PRIMARY KEY (id_usuario),
FOREIGN KEY (fk_empleado) REFERENCES personas(id_persona)
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
FOREIGN KEY (fk_permiso) REFERENCES permisos(id_permiso)
);

CREATE TABLE estado(
id_estado int NOT NULL AUTO_INCREMENT,
tipo_estado varchar(45) NOT NULL, 
PRIMARY KEY (id_estado)
);

CREATE TABLE tipo_insumo(
id_tipo_insumo int NOT NULL AUTO_INCREMENT,
nombre_insumo varchar(45) NOT NULL,
PRIMARY KEY (id_tipo_insumo)
);

CREATE TABLE insumo(
id_insumo int NOT NULL AUTO_INCREMENT,
consecutivo_insumo varchar(20) NOT NULL,
peso_insumo decimal(6,2),
fk_tipo_insumo int NOT NULL,
PRIMARY KEY (id_insumo),
FOREIGN KEY (fk_tipo_insumo) REFERENCES tipo_insumo(id_tipo_insumo)
);

CREATE TABLE inventario_insumos(
id_inventario_insumos int NOT NULL AUTO_INCREMENT,
fk_insumo int NOT NULL,
fk_estado  int NOT NULL,
unidades int NOT NULL,
fecha_planificada date,
fecha_registro datetime NOT NULL,
fk_proveedor int NOT NULL, 
fk_usuario int NOT NULL,
estado_registro TINYINT NOT NULL,
PRIMARY KEY (id_inventario_insumos),
FOREIGN KEY (fk_estado) REFERENCES estado(id_estado),
FOREIGN KEY (fk_insumo) REFERENCES insumo(id_insumo),
FOREIGN KEY (fk_proveedor) REFERENCES personas(id_persona),
FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE tipo_producto(
id_tipo_producto int NOT NULL AUTO_INCREMENT,
tipo_producto varchar(45) NOT NULL,
PRIMARY KEY(id_tipo_producto)
);

CREATE TABLE estilos(
id_estilo int NOT NULL AUTO_INCREMENT,
tipo_estilo varchar(70) NOT NULL,
figura_color varchar(70) NOT NULL,
PRIMARY KEY (id_estilo)
);

CREATE TABLE medidas_resmas(
id_medida_resma int NOT NULL AUTO_INCREMENT,
medida_1 VARCHAR(3) NOT NULL,	
medida_2 VARCHAR(3) NOT NULL,
medida_3 VARCHAR(3) NOT NULL,
PRIMARY KEY (id_medida_resma)
);

CREATE TABLE medidas_rollos(
id_medida_rollo int NOT NULL AUTO_INCREMENT,
medida varchar(3) NOT NULL,
PRIMARY KEY (id_medida_rollo)
);

CREATE TABLE tipo_medidas(
id_tipo_medida int NOT NULL AUTO_INCREMENT,
selec_producto varchar(45) NOT NULL,
fk_medida_producto int NOT NULL,
PRIMARY KEY (id_tipo_medida),
FOREIGN KEY (fk_medida_producto) REFERENCES medidas_rollos(id_medida_rollo),
FOREIGN KEY (fk_medida_producto) REFERENCES medidas_resmas(id_medida_resma)
);

CREATE TABLE producto(
id_producto int NOT NULL AUTO_INCREMENT,
fk_tipo_producto int NOT NULL,
fk_estilo int NOT NULL,
fk_tipo_medida int NOT NULL,
peso_producto decimal(6,2),
precio_producto varchar(15),
PRIMARY KEY (id_producto),
FOREIGN KEY (fk_tipo_producto) REFERENCES tipo_producto(id_tipo_producto),
FOREIGN KEY (fk_estilo) REFERENCES estilos(id_estilo),
FOREIGN KEY (fk_tipo_medida) REFERENCES tipo_medidas(id_tipo_medida)
);

CREATE TABLE inventario_produccion(
id_produccion INT NOT NULL AUTO_INCREMENT,
fk_producto int NOT NULL,
unidades int NOT NULL,
parafina_consumida decimal(6,2) NOT NULL,
fecha_registro date NOT NULL,
fk_usuario int NOT NULL,
estado_registro TINYINT NOT NULL,
PRIMARY KEY (id_produccion),
FOREIGN KEY (fk_producto) REFERENCES producto(id_producto),
FOREIGN KEY (fk_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE tipo_documento(
id_tipo_documento int NOT NULL AUTO_INCREMENT,
documento_transaccion varchar(45) NOT NULL,
PRIMARY KEY (id_tipo_documento)
); 

CREATE TABLE tipo_transaccion(
id_tipo_transaccion int NOT NULL AUTO_INCREMENT,
transaccion varchar(45) NOT NULL,
PRIMARY KEY (id_tipo_transaccion)
);

CREATE TABLE transacciones(
id_transacciones int NOT NULL AUTO_INCREMENT,
fk_tipo_transaccion int NOT NULL,
fk_tipo_documento  int NOT NULL,
fk_articulo int NOT NULL,
fk_persona int NOT NULL, -- Cliente o Proveedor
fecha_registro date NOT NULL,
precio varchar(15) NOT NULL,
comprobante varchar(250) NOT NULL, -- La idea seria guardar el enlace de la ruta, donde se vaya a guardar el documento para no llenar la BD con ese tipo de archivos
PRIMARY KEY (id_transacciones),
FOREIGN KEY (fk_tipo_transaccion) REFERENCES tipo_transaccion(id_tipo_transaccion),
FOREIGN KEY (fk_tipo_documento) REFERENCES tipo_documento(id_tipo_documento),
-- dependiendo el tipo de transaccion se elige entre producto o insumo
FOREIGN KEY (fk_articulo) REFERENCES insumo(id_insumo),
FOREIGN KEY (fk_articulo) REFERENCES producto(id_producto),
-- dependiendo el tipo de transaccion se elige entre cliente o proveedor
FOREIGN KEY (fk_persona) REFERENCES personas(id_persona)
);
