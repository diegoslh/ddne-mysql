
-- --------------------------------------------------------------------------------------------------------------------------------
-- DATOS DE PRUEBA - DATA BASE DDNE INVENTORY ------------------------------------------------------->

-- Tipo de Identificación 
INSERT INTO tipo_identificacion(nombre_identificacion)
VALUES  
    ("ID01", "C.C"), -- 1
	("ID02", "C.E"), -- 2
    ("ID03", "Otro"); -- 3

-- Tipo Persona 
INSERT INTO tipo_persona(id_tpersona, persona) 
VALUES 
	("TP01", "Empleado"), 
	("TP02", "Proveedor"), 
    ("TP03", "Cliente"); 

-- Datos Persona 
INSERT INTO datos_persona(persona_id, fk_tipo_identificacion, nombre_1, nombre_2, apellido_1, apellido_2, telefono, direccion, correo,fk_tipo_persona) 
VALUES 
-- Empleados
	("20654865", "ID01", "Jorge", "Sebastian", "Mosquera", "Ballen", "3128549685", "Cll 82 # 20a - 12", "jsmosquera@gmail.com", "TP01"), -- 1
	("1007393654", "ID01", "Nelson", "Javier", "Varela", "Hortua", "3114568532", "Cr 68 # 17 - 23", "njvarela@gmail.com", "TP01"), -- 2
	("48456325", "ID01", "Cristian", null, "Moreno", "García", "3008573695", "Cll 12 # 64 - 09", "cristianmg@gmail.com", "TP01"), -- 3
-- Proveedores
	("52965785", "ID02", "Vikram", null, "Watson", null, "6482085", "Cll 120 # 7b - 6", "vikram12@gmail.com", "TP02"), -- 4
	("1032458967", "ID01", "Camila", null, "Delgado", "Perez", "3224568512", "Cll 6d # 72a - 85", "camidp@outlook.com", "TP02"), -- 5
	("45965784", "ID01", "Juan", "Camilo", "Anzola", "Estrada", "3054218576", "Cr 92b # 11a - 20", "janzola@gmail.com", "TP02"), -- 6
-- Clientes	
	("103045685", "ID01", "Jaime", "Miguel", "Orjuela", "Puente", "3226548567", "Cll 102 # 19 - 11", "jmiguelo@hotmail.com", "TP03"), -- 7
    ("204596855", "ID01", "Julio", null, "Munevar", "Ortiz", "3012228547", "Av 19 # 109 - 02", "jmunevaro@outlook.com", "TP03"), -- 8
    ("635847596", "ID02", "Claudio", "Manuel", "Cierafi", "Parrado", "314856932", "Cr 112 # 22sur - 17", "cmanuelc@gmail.com", "TP03"); -- 9


-- Empresas
INSERT INTO empresas(id_empresa, NIT, nombre_empresa, descripcion_empresa) 
VALUES 
	("E001", "Default", "Default", "No registra"), -- 1
	-- E. Proveedores
	("E002", "80234698-4", "Solla S.A.S", "Proveedor de Parafina"), -- 2
	("E003", "10122012334-5", "Carvajal S.A.S", "Proveedor de Papel"), -- 3
    ("E004", "8088754621-3", "Propandina S.A.S", "Proveedor de Papel"), -- 4
	-- E. Clientes
	("E005", "80234698-4", "Bogga Waffles", "Empresa Cliente"), -- 5
    ("E006", "2684596-2", "Restaurante El Ajillo", "Empresa Cliente"), -- 6
    ("E007", "90995264-5", "La Salchipaperia", "Empresa Cliente"); -- 7

-- Proveedores
INSERT INTO proveedores(fk_id_proveedor, fk_ti_proveedor, fk_empresa)  
VALUES
	("52965785", "ID02","E002"),
	("1032458967", "ID01","E003"),
	("45965784", "ID01","E004");

--Clientes
INSERT INTO clientes(fk_id_cliente, fk_ti_cliente, fk_empresa)
VALUES
	("103045685", "ID01", "E005"),
    ("204596855", "ID01", "E006"),
    ("635847596", "ID02", "E007");

-- Usuarios
INSERT INTO usuarios(id_usuario, alias, contraseña, fk_id_empleado, fk_ti_empleado, estado_usuario) 
VALUES 
-- Encriptar Contraseña
	("U001", "Contabilidad", aes_encrypt("C0nt4", 'user1'), "20654865", "ID01"),
	("U002", "Operario", aes_encrypt("O123", 'user2') , "1007393654", "ID01"),
    ("U003", "Jefe de Operaciones", aes_encrypt("J123O456",'user3'), "48456325", "ID01");

-- Permisos
INSERT INTO permisos(id_permiso, permiso_sistema)
VALUES 
	("P001", "Control de Existencias"),
	("P002", "Inventario"),
	("P003", "Informe de Inventario"),
	("P004", "Contabilidad"),
	("P005", "Proveedores"),
	("P006", "Clientes"),
	("P007", "Usuarios");

-- Usuario-Permiso
INSERT INTO usuario_permiso(fk_usuario, fk_permiso) 
VALUES 
-- Contabilidad
	("U001", "P003"),
	("U001", "P004"),
	("U001", "P005"),
	("U001", "P006"),
-- Operario	
	("U002", "P001"), 
-- Jefe de Operaciones
	("U003", "P001"), 
	("U003", "P002"),
	("U003", "P007");

-- Estado
INSERT INTO estado(id_estado, tipo_estado) 
VALUES 
	("ES01", "En Espera"), 
	("ES02", "Recibido"), 
	("ES03", "Cancelado"); 

-- Tipo Insumo
INSERT INTO tipo_insumo(id_tipo_insumo, nombre_insumo) 
VALUES 
	("TI01", "Parafina"), 
	("TI02", "Papel"), 
	("TI03", "Rollo Carton"); 

-- Insumo  // EVALUAR SI VALE LA PENA MANTENER ESTA TABLA O INTEGRAR ESTOS DATOS AL INVENTARIO DE INSUMOS DEBIDO A QUE SE CREAN MUCHOS REGISTROS Y A LA VEZ ESOS MISMOS REGISTROS SE TRASLADAN AL INVENTARIO
INSERT INTO insumos(consecutivo_insumo, peso_insumo, fk_tipo_insumo) 
VALUES 
-- Parafina	
	("No Registra", 25, "TI01"), -- 1
-- Rollo Carton	
	("No Registra", 40, "TI03"); -- 2
-- Papel
	("PP3A0231046140", 215, "TI02"), -- 3
	("PP3A0231049587", 210.5 , "TI02"), -- 4

-- I. Insumos
INSERT INTO inventario_insumos (fk_insumo, fk_estado, unidades, fecha_planificada, fecha_registro, fk_proveedor, fk_ti_proveedor, fk_usuario, estado_registro) 
VALUES 
-- Papel
	("1", "ES01", "2", "2023-12-07", now(), "3", "5", "1"),
	("2", "ES02", "1", "2023-04-12", "2023-04-01", "1", "6", "1"),
-- Parafina
	("3", "ES02", "10","2023-03-20","2023-03-08", "1", "4","1"),
-- Rollo Carton
	("4", "ES03", "20", "2019-01-01","2018-12-27","3","6", "0");

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

-- M. Rollos
INSERT INTO medidas_rollos(medida) 
VALUES 
	("20"), -- 1 
	("50"), -- 2
	("100"), -- 3 
	("200"), -- 4
	("300"), -- 5
	("500"); -- 6

-- M. Resmas
INSERT INTO medidas_resmas(medida_1, medida_2, medida_3) 
VALUES 
	("30", "30", "100"), -- 1
	("30", "40", "80"); -- 2

-- T. Medidas
INSERT INTO tipo_medidas(selec_producto,fk_medida_producto) 
VALUES 
	("Resma", "1"), -- 1
	("Resma", "2"), -- 2
 	("Rollo", "1"), -- 3 
 	("Rollo", "2"); -- 4

-- Producto 
INSERT INTO producto(fk_tipo_producto, fk_estilo, fk_tipo_medida, peso_producto, precio_producto) 
VALUES 
-- Jumbo
--  ("1", "1", "8", "80.3","215.000"), 
-- Rollitos
	("2", "2", "3", "20", "90.000"), -- 1
	("2", "3", "4", "30", "100.000"), -- 2
-- 	("2", "4", "5", "40", "110.000"), 
-- 	("2", "1", "6", "50", "130.000"), 
-- Resmas
	("3", "4", "1", "7.5", "60.000"), -- 3
	("3", "2", "2", "8", "85.000"); -- 4

-- I. Produccion
INSERT INTO inventario_produccion(fk_producto, unidades, parafina_consumida, fecha_registro, fk_usuario, estado_registro) 
VALUES -- Evaluar si los registros los puede realizar el operario
	("1", "3", "10.5", curdate(),"3","1"),
	("2", "2", "7.8", curdate(), "3","1"),
	("2", "3", "12", curdate(), "3", "2"),
	("1", "1", "5.6", curdate(), "3", "1"),
	("3", "9", "22.3", curdate(), "3", "1"),
	("4", "4", "12", curdate(), "3", "1");

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
INSERT INTO transacciones(fk_tipo_transaccion, fk_tipo_documento, fk_articulo, fk_persona, fecha_registro, precio, comprobante) 
VALUES -- de pronto no deja crear el registro por el not null de artículo
-- Compras
	("1", "1", "1", "4", curdate(), "1.112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg"),
    ("1", "2", "1", "4", curdate(), "1.112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg"),
    ("1", "1", "3", "4", curdate(), "112.050", "https://www.tuaplicacionweb.com/images/ejemplo.jpg"),
-- Ventas
	("2", "2", "2", "7", curdate(), "623.200", "https://www.tuaplicacionweb.com/docs/ejemplo.pdf"),
    ("2", "1", "2", "7", curdate(), "623.200", "https://www.tuaplicacionweb.com/docs/ejemplo.pdf");

