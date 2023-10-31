
-- --------------------------------------------------------------------------------------------------------------------------------
-- DATOS DE PRUEBA - DATA BASE DDNE INVENTORY ------------------------------------------------------->

-- Tipo de Identificación 
INSERT INTO tipo_identificacion( nombre_identificacion)
VALUES  
    ("C.C"), 
	("C.E"), 
    ("Otro"); 

-- Tipo Persona 
INSERT INTO tipo_persona(persona) 
VALUES 
	("Empleado"), 
	("Proveedor"), 
    ("Cliente"); 

-- Datos Persona 
INSERT INTO datos_persona(persona_id, fk_tipo_identificacion, nombre_1, nombre_2, apellido_1, apellido_2, telefono, direccion, correo, fk_tipo_persona) 
VALUES 
-- Empleados
	("20654865", "1", "Jorge", "Sebastian", "Mosquera", "Ballen", "3128549685", "Cll 82 # 20a - 12", "jsmosquera@gmail.com", "1"), -- 1
	("1007393654", "1", "Nelson", "Javier", "Varela", "Hortua", "3114568532", "Cr 68 # 17 - 23", "njvarela@gmail.com", "1"), -- 2
	("48456325", "1", "Cristian", null, "Moreno", "García", "3008573695", "Cll 12 # 64 - 09", "cristianmg@gmail.com", "1"), -- 3
-- Proveedores
	("52965785", "2", "Vikram", null, "Watson", null, "6482085", "Cll 120 # 7b - 6", "vikram12@gmail.com", "2"), -- 4
	("1032458967", "1", "Camila", null, "Delgado", "Perez", "3224568512", "Cll 6d # 72a - 85", "camidp@outlook.com", "2"), -- 5
	("45965784", "1", "Juan", "Camilo", "Anzola", "Estrada", "3054218576", "Cr 92b # 11a - 20", "janzola@gmail.com", "2"), -- 6
-- Clientes	
	("103045685", "1", "Jaime", "Miguel", "Orjuela", "Puente", "3226548567", "Cll 102 # 19 - 11", "jmiguelo@hotmail.com", "3"), -- 7
    ("204596855", "1", "Julio", null, "Munevar", "Ortiz", "3012228547", "Av 19 # 109 - 02", "jmunevaro@outlook.com", "3"), -- 8
    ("635847596", "2", "Claudio", "Manuel", "Cierafi", "Parrado", "314856932", "Cr 112 # 22sur - 17", "cmanuelc@gmail.com", "3"); -- 9


-- Empresas
INSERT INTO empresas(NIT, nombre_empresa, descripcion_empresa) 
VALUES 
	("Default", "Default", "No registra"), 
	-- E. Proveedores
	("80234698-4", "Solla S.A.S", "Proveedor de Parafina"), 
	("10122012334-5", "Carvajal S.A.S", "Proveedor de Papel"), 
    ("8088754621-3", "Propandina S.A.S", "Proveedor de Papel"), 
	-- E. Clientes
	("80234698-4", "Bogga Waffles", "Empresa Cliente"), 
    ("2684596-2", "Restaurante El Ajillo", "Empresa Cliente"), 
    ("90995264-5", "La Salchipaperia", "Empresa Cliente"); 

-- Proveedores
INSERT INTO proveedores(fk_id_proveedor, fk_ti_proveedor, fk_empresa)  
VALUES
	("52965785", "2", "2"),
	("1032458967", "1", "3"),
	("45965784", "1", "4");

-- Clientes
INSERT INTO clientes(fk_id_cliente, fk_ti_cliente, fk_empresa)
VALUES
	("103045685", "1", "5"),
    ("204596855", "1", "6"),
    ("635847596", "2", "7");

-- Usuarios
INSERT INTO usuarios( alias, contraseña, fk_id_empleado, fk_ti_empleado, estado_usuario) 
VALUES 
-- Encriptar Contraseña
	( "Contabilidad", aes_encrypt("C0nt4", 'users'), "20654865", "1", 1),
	( "Operario", aes_encrypt("O123", 'users') , "1007393654", "1", 1),
    ( "Jefe de Operaciones", aes_encrypt("J123O456",'users'), "48456325", "1", 1);

-- Permisos
INSERT INTO permisos( permiso_sistema)
VALUES 
	( "Control de Existencias"),
	("Inventario"),
	( "Informe de Inventario"),
	( "Contabilidad"),
	("Proveedores"),
	( "Clientes"),
	( "Usuarios");

-- Usuario-Permiso
INSERT INTO usuario_permiso(fk_usuario, fk_permiso) 
VALUES 
-- Contabilidad
	("1", "3"),
	("1", "4"),
	("1", "5"),
	("1", "6"),
-- Operario	
	("2", "1"), 
-- Jefe de Operaciones
	("3", "1"), 
	("3", "2"),
	("3", "7");

-- Estado
INSERT INTO estado( tipo_estado) 
VALUES 
	( "En Espera"), 
	( "Recibido"), 
	( "Cancelado"); 

-- Tipo Insumo
INSERT INTO tipo_insumo( nombre_insumo) 
VALUES 
	("Parafina"), 
	("Papel"), 
	("Rollo Carton"); 

-- Insumo  // EVALUAR SI VALE LA PENA MANTENER ESTA TABLA O INTEGRAR ESTOS DATOS AL INVENTARIO DE INSUMOS DEBIDO A QUE SE CREAN MUCHOS REGISTROS Y A LA VEZ ESOS MISMOS REGISTROS SE TRASLADAN AL INVENTARIO
INSERT INTO insumos(consecutivo_insumo, peso_insumo, fk_tipo_insumo) 
VALUES 
-- Parafina	
	("No Registra", 25, "1"), -- 1
-- Rollo Carton	
	("No Registra", 40, "3"), -- 2
-- Papel
	("PP3A0231046140", 215, "2"), -- 3
	("PP3A0231049587", 210.5 , "2"); -- 4

-- I. Insumos
INSERT INTO inventario_insumos (fk_insumo, fk_estado, unidades, fecha_planificada, fecha_registro, fk_proveedor, fk_ti_proveedor, fk_usuario, estado_registro) 
VALUES 
-- Papel
	("1", "1", "2", "2023-12-07", now(), "1032458967", "1", "3", 1),
	("2", "2", "1", "2023-04-12", "2023-04-01", "1032458967", "1", "3", 1),
-- Parafina
	("3", "2", "10","2023-03-20","2023-03-08", "52965785", "2","3", 1),
-- Rollo Carton
	("4", "3", "20", "2019-01-01","2018-12-27","45965784","1", "3", 1);

-- T. Producto
INSERT INTO tipo_producto(tipo_producto) 
VALUES 
	("Rollo Jumbo"), -- 1
	("Rollito"), -- 2
	("Resma"); -- 3

-- Estilos 
INSERT INTO estilos(tipo_estilo, figura_color) 
VALUES
	("Cuadro", "Rojo"), -- 1
	("Cuadro", "Verde"), -- 2
	("Cuadro", "Negro"), -- 3 
	("Custom", "Hamburguesa"); -- 4

-- M. Producto
	-- M. Rollos
INSERT INTO medida_producto(medi_1) 
VALUES 
	("20"), -- 1 
	("50"), -- 2
	("100"), -- 3 
	("200"), -- 4
	("300"), -- 5
	("500"); -- 6
	-- M. Resmas
INSERT INTO medida_producto(medi_1, medi_2, medi_3) 
VALUES 
	("30", "30", "100"), -- 7
	("30", "40", "80"); -- 8

-- Producto 
INSERT INTO productos(fk_tipo_producto, fk_estilo, fk_medida_producto, peso_producto, precio_producto) 
VALUES 
-- Jumbo
	("1", "1", "4", "80.3","215.000"), -- 1
-- Rollitos
	("2", "2", "3", "20", "90.000"), -- 2
	("2", "3", "2", "30", "100.000"), -- 3
 	("2", "4", "1", "40", "110.000"), -- 4
 	("2", "1", "2", "50", "130.000"), -- 5
-- Resmas
	("3", "4", "8", "7.5", "60.000"), -- 6
	("3", "2", "7", "8", "85.000"); -- 7

-- I. Produccion
INSERT INTO inventario_produccion(fk_producto, unidades, parafina_consumida, fecha_registro, fk_usuario, estado_registro) 
VALUES -- Evaluar si los registros los puede realizar el operario
	("1", "3", "10.5", curdate(),"3","1"),
	("2", "2", "7.8", curdate(), "3","1"),
	("2", "3", "12", curdate(), "3", "2"),
	("1", "1", "5.6", curdate(), "3", "1"),
	("3", "9", "22.3", curdate(), "3", "1"),
	("4", "4", "12", curdate(), "3", "1"),
	("5", "15", "22", curdate(), "3", "1"),
	("6", "6", "10", curdate(), "3", "1");

-- T. Documento
INSERT INTO tipo_documento(documento_transaccion) 
VALUES 
	("Factura"), -- 1
	("Remisión"); -- 2

-- T. Transaccion
INSERT INTO tipo_transaccion(transaccion) 
VALUES 
	("Compra"), -- 1
	("Venta"); -- 2

-- Transacciones
    -- Compras
INSERT INTO transacciones_compras(fk_tipo_transaccion, fk_tipo_documento, fk_articulo, fk_persona, fk_t_identi, fecha_registro, precio, comprobante) 
VALUES 
	("2", "2", "2", "52965785", "2", curdate(), "623.200", "https://www.tuaplicacionweb.com/docs/ejemplo.pdf"),
    ("2", "1", "2", "52965785", "2", curdate(), "623.200", "https://www.tuaplicacionweb.com/docs/ejemplo.pdf");

	-- Ventas
INSERT INTO transacciones_ventas(fk_tipo_transaccion, fk_tipo_documento, fk_articulo, fk_persona, fk_t_identi, fecha_registro, precio, comprobante) 
VALUES 
	("1", "1", "1", "103045685", "1", curdate(), "1.112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg"),
    ("1", "2", "1", "103045685", "1", curdate(), "1.112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg"),
    ("1", "1", "3", "635847596", "2", curdate(), "112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg");