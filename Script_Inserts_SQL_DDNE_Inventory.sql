
-- DATOS DE PRUEBA - DATA BASE DDNE INVENTORY ------------------------------------------------------->

-- Tipo de Identificación 
INSERT INTO tipo_identificacion(nombre_identificacion)
VALUES  
    ("C.C"), -- 1
	("C.E"), -- 2
    ("Otro"); -- 3
            
-- Datos Persona 
INSERT INTO datos_persona(persona_id, fk_tipo_identificacion, nombre_1, nombre_2, apellido_1, apellido_2, telefono, direccion, correo) 
VALUES 
-- Empleados
	("20654865", "1", "Jorge", "Sebastian", "Mosquera", "Ballen", "3128549685", "Cll 82 # 20a - 12", "jsmosquera@gmail.com"), -- 1
	("1007393654", "1", "Nelson", "Javier", "Varela", "Hortua", "3114568532", "Cr 68 # 17 - 23", "njvarela@gmail.com"), -- 2
-- Proveedores
	("52965785", "2", "Vikram", null, "Watson", null, "6482085", "Cll 120 # 7b - 6", "vikram12@gmail.com"), -- 3
	("1032458967", "1", "Camila", null, "Delgado", "Perez", "3224568512", "Cll 6d # 72a - 85", "camidp@outlook.com"), -- 4
	("45965784", "1", "Juan", "Camilo", "Anzola", "Estrada", "3054218576", "Cr 92b # 11a - 20", "janzola@gmail.com"), -- 5
-- Clientes	
	("103045685", "1", "Jaime", "Miguel", "Orjuela", "Puente", "3226548567", "Cll 102 # 19 - 11", "jmiguelo@hotmail.com"), -- 6
    ("204596855", "1", "Julio", null, "Munevar", "Ortiz", "3012228547", "Av 19 # 109 - 02", "jmunevaro@outlook.com"), -- 7
    ("635847596", "2", "Claudio", "Manuel", "Cierafi", "Parrado", "314856932", "Cr 112 # 22sur - 17", "cmanuelc@gmail.com"), -- 8
-- Empleado Extra
	("48456325", "1", "Cristian", null, "Moreno", "García", "3008573695", "Cll 12 # 64 - 09", "cristianmg@gmail.com"); -- 9

-- Tipo Persona 
INSERT INTO tipo_persona(persona) 
VALUES 
	("Empleado"), -- 1
	("Proveedor"), -- 2
    ("Cliente"); -- 3
	
-- Empresas
INSERT INTO empresas(NIT, nombre_empresa, descripcion_empresa) 
VALUES 
	("Default", "Default", "No registra"), -- 1
	("80234698-4", "Solla S.A.S", "Proveedor de Parafina"), -- 2
	("10122012334-5", "Carvajal S.A.S", "Proveedor de Papel"), -- 3
    ("8088754621-3", "Propandina S.A.S", "Proveedor de Papel"), -- 4
	("80234698-4", "Bogga Waffles", "Empresa Cliente"), -- 5
    ("2684596-2", "Restaurante El Ajillo", "Empresa Cliente"), -- 6
    ("90995264-5", "La Salchipaperia", "Empresa Cliente"); -- 7
    
-- Personas
INSERT INTO personas(fk_tipo_persona, fk_empresa, fk_datos_persona) 
VALUES
-- Empleados 
	("1", "1", "1"),
    ("1", "1", "2"),
	("1", "1", "9"),
-- Proveedores    
	("2", "2", "3"), -- Parafina
	("2", "3", "4"), -- Papel
    ("2", "4", "5"), -- Papel
-- Clientes
	("3", "5", "6"),
    ("3", "6", "7"),
    ("3", "7", "8");
    
-- Usuarios
INSERT INTO usuarios(alias, fk_empleado, estado_usuario) 
VALUES 
	("Contabilidad", "1", "1"), -- 1
	("Operario", "2", "1"), -- 2
    ("Jefe de Operaciones", "9", "1"); -- 3

-- Permisos
INSERT INTO permisos(permiso_sistema)
VALUES 
	("Control de Existencias"), -- 1
	("Inventario"), -- 2
	("Informe de Inventario"), -- 3
	("Contabilidad"), -- 4
	("Proveedores"), -- 5
	("Clientes"), -- 6
	("Usuarios"); -- 7

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
INSERT INTO estado(tipo_estado) 
VALUES 
	("En Espera"), -- 1
	("Recibido"), -- 2
	("Cancelado"); -- 3

-- Tipo Insumo
INSERT INTO tipo_insumo(nombre_insumo) 
VALUES 
 ("Parafina"), -- 1
 ("Papel"), -- 2
 ("Rollo Carton"); -- 3

-- Insumo 
INSERT INTO insumo(consecutivo_insumo, peso_insumo, fk_tipo_insumo) 
VALUES 
-- Papel
	("PP3A0231046140", 215, "2"), -- 1
	("PP3A0231049587", 210.5 , "2"), -- 2
-- Parafina	
	("No Registra", 25, "1"), -- 3
-- Rollo Carton	
	("No Registra", 40, "3"); -- 4

-- I. Insumos
INSERT INTO inventario_insumos (fk_insumo, fk_estado, unidades, fecha_planificada, fecha_registro, fk_usuario, fk_proveedor, estado_registro) 
VALUES 
-- Papel
	("1", "1", "2", "2023-10-07", now(), "3", "5", "1"),
	("2", "2", "1", "2023-04-12", "2023-04-01", "1", "6", "1"),
-- Parafina
	("3", "2", "10","2023-03-20","2023-03-08", "1", "4","1"),
-- Rollo Carton
	("4", "3", "20", "2019-01-01","2018-12-27","3","6", "0");

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
