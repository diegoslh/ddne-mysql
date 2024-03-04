
-- ----------------------------------------------------------------------------------------------------------------->|
-- DATOS DE PRUEBA - DATA BASE DDNE INVENTORY  ------------------------------------------------------->|

-- Tipo de Identificación 
INSERT INTO tipo_identificacion(tipo_id)
VALUES  
  ("CC"), 
	("CE"), 
  ("Otro"); 

-- Tipo Persona 
INSERT INTO tipo_persona(tipo_persona) 
VALUES 
	("Empleado"), 
	("Proveedor"), 
  ("Cliente"); 

-- Datos Persona 
INSERT INTO datos_persona(persona_id, fk_tipo_identificacion, nombre_1, nombre_2, apellido_1, apellido_2, telefono, direccion, correo, fk_tipo_persona) 
VALUES 
-- Empleados
	("20654865", "CC", "Jorge", "Sebastian", "Mosquera", "Ballen", "3128549685", "Cll 82 # 20a - 12", "jsmosquera@gmail.com", "Empleado"), -- 1
	("1007393654", "CC", "Nelson", "Javier", "Varela", "Hortua", "3114568532", "Cr 68 # 17 - 23", "njvarela@gmail.com", "Empleado"), -- 2
	("48456325", "CC", "Cristian", null, "Moreno", "García", "3008573695", "Cll 12 # 64 - 09", "cristianmg@gmail.com", "Empleado"), -- 3
-- Proveedores
	("52965785", "CE", "Vikram", null, "Watson", null, "6482085", "Cll 120 # 7b - 6", "vikram12@gmail.com", "Proveedor"), -- 4
	("1032458967", "CC", "Camila", null, "Delgado", "Perez", "3224568512", "Cll 6d # 72a - 85", "camidp@outlook.com", "Proveedor"), -- 5
	("45965784", "CC", "Juan", "Camilo", "Anzola", "Estrada", "3054218576", "Cr 92b # 11a - 20", "janzola@gmail.com", "Proveedor"), -- 6
-- Clientes	
	("103045685", "CC", "Jaime", "Miguel", "Orjuela", "Puente", "3226548567", "Cll 102 # 19 - 11", "jmiguelo@hotmail.com", "Cliente"), -- 7
  ("204596855", "CC", "Julio", null, "Munevar", "Ortiz", "3012228547", "Av 19 # 109 - 02", "jmunevaro@outlook.com", "Cliente"), -- 8
  ("635847596", "CE", "Claudio", "Manuel", "Cierafi", "Parrado", "314856932", "Cr 112 # 22sur - 17", "cmanuelc@gmail.com", "Cliente"); -- 9


-- Empresas
INSERT INTO empresas(nit, nombre_empresa, descripcion_empresa) 
VALUES 
	("Default", "Default", "No registra"), 
	-- E. Proveedores
	("80234698-4", "Solla S.A.S", "Proveedor de Parafina"), 
	("10122012334-5", "Carvajal S.A.S", "Proveedor de Papel"), 
  ("8088754621-3", "Propandina S.A.S", "Proveedor de Papel"), 
	-- E. Clientes
	("80234688-4", "Bogga Waffles", "Empresa Cliente"), 
  ("2684596-2", "Restaurante El Ajillo", "Empresa Cliente"), 
  ("90995264-5", "La Salchipaperia", "Empresa Cliente"); 

-- Proveedores
INSERT INTO proveedores(fk_id_proveedor, fk_ti_proveedor, fk_empresa, estado_proveedor)  
VALUES
	("52965785", "CE", "80234698-4", 1),
	("1032458967", "CC", "10122012334-5", 1),
	("45965784", "CC", "8088754621-3", 1);

-- Clientes
INSERT INTO clientes(fk_id_cliente, fk_ti_cliente, fk_empresa, estado_cliente)
VALUES
	("103045685", "CC", "80234688-4", 1),
  ("204596855", "CC", "2684596-2", 1),
  ("635847596", "CE", "90995264-5", 1);

-- Usuarios
INSERT INTO usuarios( alias, contraseña, fk_id_empleado, fk_ti_empleado, estado_usuario) 
VALUES 
-- Encriptar Contraseña
	( "Admin", "$2b$10$ZwREz01eXuHnIBXgCM7EN.gCbMl7/zn3WzbgBlLa82jWS5konu1lC" , "1007393654", "CC", 1),
  ( "J.operaciones", "$2b$10$ZwREz01eXuHnIBXgCM7EN.gCbMl7/zn3WzbgBlLa82jWS5konu1lC" , "48456325", "CC", 1),
  ( "Contabilidad", "$2b$10$ZwREz01eXuHnIBXgCM7EN.gCbMl7/zn3WzbgBlLa82jWS5konu1lC" , "20654865", "CC", 1);

-- Permisos
INSERT INTO permisos( permiso_sistema)
VALUES 
	("Insumos"), -- Ingresar al módulo de Inventarios
	("Produccion"),
	("Transacciones"), -- ingresar a la pagina de transacciones
  ("Informes"), -- El modulo debe replantearse debido a que productos deberia tener acceso solo por medio de J.Operaciones y el informe de inventarios es una página en comun que se puede ver, por otro lado transacciones solo tiene acceso Contabilidad
  ("Productos"),
  ("Proveedores"), -- Gestionar (Contabilidad)
	("Clientes"), -- Gestionar (Contabilidad)
	("Usuarios"); -- Gestionar (Admon)

-- Usuario-Permiso
INSERT INTO usuario_permiso(fk_usuario, fk_permiso)
VALUES 
-- Admin
	("1", "1"), 
	("1", "2"),
  ("1", "3"),
	("1", "4"),
	("1", "5"),
	("1", "6"),
  ("1", "7"),
  ("1", "8"),
-- Jefe de Operaciones
	("2", "1"),
  ("2", "3"),
  ("2", "5"),
-- Contabilidad
  ("3", "2"),
  ("3", "4"),
  ("3", "6"),
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

-- I. Insumos
INSERT INTO inventario_insumos (fk_tipo_insumo, consecutivo_insumo, peso_insumo, unidades, fk_estado, fecha_planificada, fecha_recepcion, fecha_registro, fk_proveedor, fk_ti_proveedor, fk_usuario, estado_registro) 
VALUES 
	-- Papel
	("Papel", "PP3A0231046140", 220, "3", "Recibido", "2023-04-12", "2023-04-11", "2023-04-6", "1032458967", "CC", "2", 1),
	( "Papel", "PP3A0231049587", 215, "3", "Recibido","2023-05-10", "2023-05-9", "2023-04-27", "1032458967", "CC", "2", 1),
	-- Parafina
	("Parafina", "N/A", 25, "10", "Recibido","2023-03-21", "2023-03-20", "2023-03-12", "52965785", "CE","2", 1),
	-- Rollo Carton
	("Rollo Carton", "N/A", 40, "30", "Cancelado", "2023-06-25", null, "2023-06-01","45965784","CC", "2", 1);

-- T. Producto
INSERT INTO tipo_producto(producto) 
VALUES 
	("Jumbo"),
	("Rollito"),
	("Resma"),
	("Vinipel");

-- Categorías
INSERT INTO categorias(tipo_categoria) 
VALUES
	("Papel Parafinado"),
	("Envoltura");

-- Colores
INSERT INTO colores(color) 
VALUES 
	("Transparente"),
	("Blanco"),
	("Negro"),
	("Verde"),
	("Rojo"),
	("Azul"),
	("Amarillo"),
	("Naranja"),
	("Custom");

-- Producto 
INSERT INTO productos(fk_tipo_producto, fk_categoria, fk_color, precio_producto, comentario) 
VALUES 
	-- Rollos Jumbo
	("Jumbo", 1 , "Blanco", "215.000", null), -- 1
	("Jumbo", 1 , "Rojo", "185.000", null), -- 2
	-- Rollitos
	("Rollito", 1 , "Verde", "100.000", null), -- 3
 	("Rollito", 1 , "Rojo", "110.000", null), -- 4
 	("Rollito", 1 , "Amarillo", "130.000", null), -- 5
	-- Resmas
	("Resma", 1 , "Azul", "60.000", null), -- 6
	("Resma", 1 , "Negro", "85.000", null), -- 7
	("Resma", 1 , "Rojo", "85.000", null), -- 8
	-- Vinipel
	("Vinipel", 2 , "Transparente", "110.000", null), -- 9

	-- Productos (continuación)
	-- Rollos Jumbo
	("Jumbo", 1 , "Custom","215.000", null), -- 10
	("Jumbo", 1 , "Negro","215.000", null), -- 11
	("Jumbo", 1 , "Verde","215.000", null), -- 12
	("Jumbo", 1 , "Azul","215.000", null), -- 13
	("Jumbo", 1 , "Amarillo","215.000", null), -- 14
	("Jumbo", 1 , "Naranja","215.000", null), -- 15
	-- Rollitos
	("Rollito", 1 , "Blanco", "100.000", null), -- 16
 	("Rollito", 1 , "Custom", "110.000", null), -- 17
 	("Rollito", 1 , "Azul", "130.000", null), -- 18
	("Rollito", 1 , "Naranja", "110.000", null), -- 19
 	("Rollito", 1 , "Negro", "130.000", null), -- 20
	-- Resmas
	("Resma", 1 , "Blanco",  "60.000", null), -- 21
	("Resma", 1 , "Custom", "85.000", null), -- 22
	("Resma", 1 , "Amarillo", "85.000", null), -- 23
	("Resma", 1 , "Naranja", "85.000", null), -- 24
	("Resma", 1 , "Verde", "85.000", null); -- 25

-- Alistamiento Rollos Medianos (Impresos)
INSERT INTO rollos_medianos ( fecha_registro, fk_insumo, fk_color_1, fk_color_2, peso, fk_usuario, estado_registro)
VALUES
	(curdate(), 100, "Rojo", "Rojo", 116, "2", "1"),
	(curdate(), 100, "Rojo", "Custom", 110, "2", "1"),
	(curdate(), 100, "Custom", "Custom", 118, "2", "1"),
	(curdate(), 101, "Negro", "Negro", 112, "2", "1"),
	(curdate(), 101, "Blanco", "Rojo", 109, "2", "1"),
	(curdate(), 101, "Verde", "Blanco", 113, "2", "1");

-- Cortes Jumbo
INSERT INTO cortes_jumbo(fecha_registro, pfk_rollo_mediano, rollo_jumbo, peso_jumbo, fk_color, fk_usuario, estado_registro)
VALUES
	(curdate(), 1, "1", 17.45, "Rojo", "2", "1"),
	(curdate(), 1, "2", 17.5, "Rojo", "2", "1"),
	(curdate(), 1, "3", 17.75, "Rojo", "2", "1"),
	(curdate(), 1, "4", 17.4, "Rojo", "2", "1"),
	(curdate(), 1, "5", 19.45, "Rojo", "2", "1"),
	(curdate(), 1, "6", 19.1, "Rojo", "2", "1"),
	(curdate(), 1, "7", 18.55, "Rojo", "2", "1"),
	(curdate(), 1, "8", 18, "Rojo", "2", "1"),
	
	(curdate(), 2, "1", 17.45, "Rojo" , "2", "1"),
	(curdate(), 2, "2", 17, "Custom" , "2", "1"),
	(curdate(), 2, "3", 17.25, "Rojo" , "2", "1"),
	(curdate(), 2, "4", 17.75, "Custom" , "2", "1"),
	(curdate(), 2, "5", 18.3, "Rojo" , "2", "1"),
	(curdate(), 2, "6", 16.42, "Custom" , "2", "1"),
	(curdate(), 2, "7", 18.25, "Rojo", "2", "1"),
	(curdate(), 2, "8", 18, "Rojo", "2", "1"),

	(curdate(), 3, "1", 17.8, "Custom", "2", "1"),
	(curdate(), 3, "2", 18.2, "Custom", "2", "1"),
	(curdate(), 3, "3", 17.6, "Custom", "2", "1"),
	(curdate(), 3, "4", 18.1, "Custom", "2", "1"),
	(curdate(), 3, "5", 17.9, "Custom", "2", "1"),
	(curdate(), 3, "6", 18.5, "Custom", "2", "1"),
	(curdate(), 3, "7", 17.3, "Custom", "2", "1"),
	(curdate(), 3, "8", 17.7, "Custom", "2", "1"),

	(curdate(), 4, "1", 18.3, "Negro", "2", "1"),
	(curdate(), 4, "2", 18.8, "Negro", "2", "1"),
	(curdate(), 4, "3", 17.9, "Negro", "2", "1"),
	(curdate(), 4, "4", 18.5, "Negro", "2", "1"),
	(curdate(), 4, "5", 17.5, "Negro", "2", "1"),
	(curdate(), 4, "6", 18.2, "Negro", "2", "1"),
	(curdate(), 4, "7", 17.7, "Negro", "2", "1"),
	(curdate(), 4, "8", 18.0, "Negro", "2", "1"),

	(curdate(), 5, "1", 17.2, "Blanco", "2", "1"),
	(curdate(), 5, "2", 17.6, "Rojo", "2", "1"),
	(curdate(), 5, "3", 17.9, "Blanco", "2", "1"),
	(curdate(), 5, "4", 17.3, "Rojo", "2", "1"),
	(curdate(), 5, "5", 18.1, "Blanco", "2", "1"),
	(curdate(), 5, "6", 17.5, "Rojo", "2", "1"),
	(curdate(), 5, "7", 18.0, "Blanco", "2", "1"),
	(curdate(), 5, "8", 17.4, "Rojo", "2", "1"),
	
	(curdate(), 6, "1", 17, "Verde", "2", "1"),
	(curdate(), 6, "2", 17.7, "Blanco", "2", "1"),
	(curdate(), 6, "3", 17.6, "Verde", "2", "1"),
	(curdate(), 6, "4", 17.1, "Blanco", "2", "1"),
	(curdate(), 6, "5", 18.6, "Verde", "2", "1"),
	(curdate(), 6, "6", 17.2, "Blanco", "2", "1"),
	(curdate(), 6, "7", 18.1, "Verde", "2", "1"),
	(curdate(), 6, "8", 17.6, "Blanco", "2", "1");

-- I. Produccion
INSERT INTO inventario_produccion( fecha_registro, fk_rollo_mediano, fk_rollo_jumbo, fk_producto, peso_producto, fk_usuario, estado_registro)
VALUES
    -- Rollo Jumbo 1 --
	(curdate(), 1, 1, 8, "0", "2", "1"),
	(curdate(), 1, 1, 8, "0", "2", "1"),
	(curdate(), 1, 1, 4, "20", "2", "1"),
	(curdate(), 1, 1, 4, "20", "2", "1"),
	(curdate(), 1, 1, 4, "50", "2", "1"),
    
	(curdate(), 1, 2, 4, "20", "2", "1"),
	(curdate(), 1, 2, 4, "20", "2", "1"),
	(curdate(), 1, 2, 4, "20", "2", "1"),
	(curdate(), 1, 2, 8, "0", "2", "1"),
	(curdate(), 1, 2, 8, "0", "2", "1"),
    
	(curdate(), 1, 3, 2, "200", "2", "1"),

	(curdate(), 1, 4, 4, "20", "2", "1"),
	(curdate(), 1, 4, 4, "50", "2", "1"),
	(curdate(), 1, 4, 4, "20", "2", "1"),
	(curdate(), 1, 4, 8, "0", "2", "1"),

	(curdate(), 1, 5, 2, "200", "2", "1"),
  
	(curdate(), 1, 6, 2, "200", "2", "1"),

		-- Rollo Jumbo 2 --
	(curdate(), 2, 1, 4, "20", "2", "1"),
	(curdate(), 2, 1, 4, "20", "2", "1"),
	(curdate(), 2, 1, 8, "0", "2", "1"),
	(curdate(), 2, 1, 8, "0", "2", "1"),
	(curdate(), 2, 1, 8, "0", "2", "1"),
    
	(curdate(), 2, 2, 17, "50", "2", "1"),
	(curdate(), 2, 2, 17, "50", "2", "1"),
	(curdate(), 2, 2, 22, "0", "2", "1"),

	(curdate(), 2, 3, 4, "200", "2", "1"),

	(curdate(), 2, 4, 17, "50", "2", "1"),
	(curdate(), 2, 4, 17, "20", "2", "1"),
	(curdate(), 2, 4, 17, "20", "2", "1"),
	(curdate(), 2, 4, 22, "0", "2", "1"),

	(curdate(), 2, 5, 8, "0", "2", "1"),
	(curdate(), 2, 5, 8, "0", "2", "1"),
	(curdate(), 2, 5, 8, "0", "2", "1"),
	(curdate(), 2, 5, 8, "0", "2", "1"),
	(curdate(), 2, 5, 4, "20", "2", "1"),

	(curdate(), 2, 6, 17, "20", "2", "1"),
	(curdate(), 2, 6, 17, "50", "2", "1"),
	(curdate(), 2, 6, 22, "0", "2", "1"),
	(curdate(), 2, 6, 22, "0", "2", "1"),
	
	-- Rollo Jumbo 3 --
	(curdate(), 3, 1, 10, "200", "2", "1"),

	(curdate(), 3, 2, 17, "50", "2", "1"),
	(curdate(), 3, 2, 17, "50", "2", "1"),
	(curdate(), 3, 2, 17, "50", "2", "1"),

	(curdate(), 3, 3, 22, "0", "2", "1"),
	(curdate(), 3, 3, 22, "0", "2", "1"),
	(curdate(), 3, 3, 22, "0", "2", "1"),
	(curdate(), 3, 3, 22, "0", "2", "1"),
	(curdate(), 3, 3, 22, "0", "2", "1"),
	(curdate(), 3, 3, 22, "0", "2", "1"),

	(curdate(), 3, 4, 17, "50", "2", "1"),
	(curdate(), 3, 4, 17, "50", "2", "1"),
	(curdate(), 3, 4, 17, "20", "2", "1"),
	(curdate(), 3, 4, 17, "20", "2", "1"),

	(curdate(), 3, 5, 10, "200", "2", "1"),

	(curdate(), 3, 6, 10, "200", "2", "1"),

	(curdate(), 3, 7, 10, "200", "2", "1"),

	(curdate(), 3, 8, 17, "50", "2", "1"),
	(curdate(), 3, 8, 17, "20", "2", "1"),
	(curdate(), 3, 8, 22, "0", "2", "1"),


	-- Rollo Jumbo 4 --
	(curdate(), 4, 1, 11, "200", "2", "1");


-- T. Documento
INSERT INTO tipo_documento(doc_transaccion) 
VALUES 
	("Factura"), -- 1
	("Remisión"); -- 2

-- T. Transaccion
INSERT INTO tipo_transaccion(tp_transaccion) 
VALUES 
	("Compra"), -- 1
	("Venta"); -- 2

-- Transacciones
    -- Compras
INSERT INTO transacciones_compras(fk_tipo_transaccion, fk_tipo_documento, fk_articulo, fk_proveedor, fk_t_identi, fecha_registro, precio, comprobante) 
VALUES 
	("Compra", "Remisión", "Parafina", "52965785", "CE", curdate(), "623.200", "https://www.tuaplicacionweb.com/docs/ejemplo.pdf"),
  ("Compra", "Factura", "Parafina", "52965785", "CE", curdate(), "623.200", "https://www.tuaplicacionweb.com/docs/ejemplo.pdf");

	-- Ventas
INSERT INTO transacciones_ventas(fk_tipo_transaccion, fk_tipo_documento, fk_articulo, fk_cliente, fk_t_identi, fecha_registro, precio, comprobante) 
VALUES 
	("Venta", "Factura", "Jumbo", "103045685", "CC", curdate(), "1.112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg"),
	("Venta", "Remisión", "Jumbo", "103045685", "CC", curdate(), "1.112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg"),
	("Venta", "Factura", "Rollito", "635847596", "CE", curdate(), "112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg");