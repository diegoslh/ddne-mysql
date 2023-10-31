
-- --------------------------------------------------------------------------------------------------------------------------------
-- Consultas de Tablas
--                                                 --------------------------------------------------------------------------------

SHOW TABLES;
-- /////////////////////////////////////////////////////////////////

	-- Entidades Fuertes --
-- ----------------------------------------------------------------
--                                        Consultas Simples  -----
--                                    -----------------------------
SELECT * FROM tipo_documento;
SELECT * FROM tipo_transaccion;
SELECT * FROM tipo_insumo;
SELECT * FROM estado;
SELECT * FROM tipo_producto;
SELECT * FROM estilos;
SELECT * FROM medidas_resmas;
SELECT * FROM medidas_rollos;
SELECT * FROM tipo_identificacion;
SELECT * FROM tipo_persona;
SELECT * FROM empresas;	
SELECT * FROM permisos;

	-- Entidades Débiles --
-- ----------------------------------------------------------------
--                               					  Joins  -----
--                                    -----------------------------

SELECT * FROM datos_persona;

SELECT dp.id_datos_persona, dp.persona_id,  -- datos persona
		ti.nombre_identificacion as identificacion,  -- tipo identificacion
        dp.nombre_1, dp.nombre_2, dp.apellido_1, dp.apellido_2, dp.telefono, dp.direccion, dp.correo -- datos persona
FROM datos_persona dp
LEFT JOIN tipo_identificacion ti ON fk_tipo_identificacion = id_tipo_id;

-- ----------------------------
SELECT * FROM usuarios;

SELECT u.id_usuario, u. alias, u.contraseña, -- usuarios
		dp.persona_id, dp.nombre_1, dp.apellido_1, dp.correo, -- datos persona
        u.estado_usuario -- usuarios
FROM usuarios u
LEFT JOIN personas p ON fk_empleado = id_persona
LEFT JOIN datos_persona dp ON fk_empleado = id_datos_persona;

-- Desencriptar contraseña
select u.alias, convert(aes_decrypt(contraseña, 'user3') using utf8mb3) as dato_desencriptado 
from usuarios u;
-- ----------------------------
SELECT * FROM insumos;

SELECT i.id_insumo,  -- insumo
		ti.nombre_insumo as insumo,  -- tipo insumo
        i. consecutivo_insumo, i.peso_insumo -- insumo
FROM tipo_insumo ti
RIGHT JOIN insumos i ON fk_tipo_insumo = id_tipo_insumo;

-- ----------------------------
SELECT * FROM tipo_medidas;
	-- Si el producto es Resma
SELECT tm.id_tipo_medida, tm.selec_producto, -- tipo medidas
		mr.medida_1, mr.medida_2, mr.medida_3 -- medidas resmas
FROM tipo_medidas tm
LEFT JOIN medidas_resmas mr ON fk_medida_producto = id_medida_resma
WHERE tm.selec_producto LIKE 'Resma'; -- Solo seleccione resmas

	-- Si el Producto es Rollo
SELECT tm.id_tipo_medida, tm.selec_producto, -- tipo medidas
		mr.medida -- medidas rollos
FROM tipo_medidas tm
LEFT JOIN medidas_rollos mr ON fk_medida_producto = id_medida_rollo
WHERE tm.selec_producto LIKE 'Rollo'; -- Solo seleccione rollos

-- ----------------------------    
SELECT * FROM usuario_permiso;

SELECT up.id_usuario_permiso, -- usuario permiso
		u.alias, -- usuarios
		up.fk_permiso, -- usuario permiso
		p.permiso_sistema as permiso-- usuarios
FROM usuarios u
RIGHT JOIN usuario_permiso up ON fk_usuario = id_usuario
LEFT JOIN permisos p ON fk_permiso = id_permiso;

-- ----------------------------
SELECT * FROM personas;

SELECT p.id_persona, -- personas
		tp.persona, -- tipo persona
		e.nombre_empresa, e.descripcion_empresa, -- empresas
		ti.nombre_identificacion as tipo_id, -- tipo identificacion
		dp.persona_id, dp.nombre_1, dp.apellido_1, dp.telefono, dp.correo ,dp.direccion  -- datos persona
FROM personas p
JOIN tipo_persona tp ON fk_tipo_persona = id_tipo_persona
JOIN empresas e ON fk_empresa = id_empresa
JOIN datos_persona dp ON fk_datos_persona = id_datos_persona LEFT JOIN tipo_identificacion ti ON fk_tipo_identificacion = id_tipo_id;

-- ----------------------------
SELECT * FROM producto;

	-- Si el producto es Resma
SELECT p.id_producto,  -- producto
		tp.tipo_producto,  -- tipo producto
		e.tipo_estilo, e.figura_color,  -- estilos
		mre.medida_1, mre.medida_2, mre.medida_3,  -- medidas resmas
		p.peso_producto, p.precio_producto -- producto
FROM producto p
JOIN tipo_producto tp ON fk_tipo_producto = id_tipo_producto 
JOIN estilos e ON fk_estilo = id_estilo
JOIN tipo_medidas tm ON fk_tipo_medida = id_tipo_medida LEFT JOIN medidas_resmas mre ON fk_medida_producto = id_medida_resma 
WHERE tm.selec_producto LIKE 'Resma';

	-- Si el producto es Rollo o Rollito
SELECT p.id_producto,  -- producto
		tp.tipo_producto,  -- tipo producto
		e.tipo_estilo, e.figura_color,  -- estilos
		mro.medida,  -- medidas rollos
		p.peso_producto, p.precio_producto -- producto
FROM producto p
JOIN tipo_producto tp ON fk_tipo_producto = id_tipo_producto 
JOIN estilos e ON fk_estilo = id_estilo
JOIN tipo_medidas tm ON fk_tipo_medida = id_tipo_medida LEFT JOIN medidas_rollos mro ON fk_medida_producto = id_medida_rollo
WHERE tm.selec_producto LIKE 'Roll%'; -- Rollo y Rollito

-- ----------------------------
SELECT * FROM inventario_insumos;

SELECT ii.id_inventario_insumos as id, -- I. insumos
		ti. nombre_insumo, -- tipo insumo
		e.tipo_estado, -- estado 
		ii.unidades, ii.fecha_planificada, ii.fecha_registro, -- I. insumos
		emp.nombre_empresa as proveedor, -- empresas
		u.alias as usuario, -- usuarios
		ii.estado_registro -- I. insumos
FROM inventario_insumos ii
JOIN insumos i ON fk_insumo = id_insumo LEFT JOIN tipo_insumo ti ON fk_tipo_insumo = id_tipo_insumo
JOIN estado e ON fk_estado = id_estado
JOIN personas p ON fk_proveedor = id_persona LEFT JOIN empresas emp ON fk_empresa = id_empresa
JOIN usuarios u ON fk_usuario = id_usuario;

-- ----------------------------
SELECT * FROM inventario_produccion;

SELECT ip.id_produccion as id,  -- I. producción
		tp.tipo_producto as producto,  -- tipo producto
		ip.unidades, ip.parafina_consumida, ip.fecha_registro,  -- I. producción
		u.alias as usuario,  -- Usuarios
		ip.estado_registro -- I. producción
FROM inventario_produccion ip
JOIN producto p ON fk_producto = id_producto LEFT JOIN tipo_producto tp ON fk_tipo_producto = id_tipo_producto
JOIN usuarios u ON fk_usuario = id_usuario;
-- ----------------------------
SELECT * FROM transacciones_compras;
	-- Transacciones de Compras (insumos)
SELECT t.id_transacciones as id,  -- transacciones
		tt.transaccion as tipo_transaccion,  -- tipo transaccion
		td.documento_transaccion,  -- tipo documento
		ti.nombre_insumo as articulo,  -- tipo insumo
		e.nombre_empresa, e.descripcion_empresa,  -- empresas
		t.fecha_registro, t.precio, t.comprobante -- transacciones
FROM transacciones t
JOIN tipo_transaccion tt ON fk_tipo_transaccion = id_tipo_transaccion
JOIN tipo_documento td ON fk_tipo_documento = id_tipo_documento
JOIN insumos i ON fk_articulo = id_insumo LEFT JOIN tipo_insumo ti ON fk_tipo_insumo = id_tipo_insumo
JOIN personas ON fk_persona = id_persona LEFT JOIN empresas e ON fk_empresa = id_empresa
WHERE tt.transaccion LIKE 'Compra%';

SELECT * FROM transacciones_ventas;
	-- Transacciones de Ventas (Productos) 
SELECT t.id_transacciones as id,  -- transacciones
		tt.transaccion as tipo_transaccion,  -- tipo transaccion
		td.documento_transaccion as documento,  -- tipo documento
		tp.tipo_producto as articulo,  -- tipo producto
		tp1.persona,  -- tipo persona
		dp.nombre_1, dp.apellido_1, dp.telefono, dp.correo,  -- datos persona
		t.fecha_registro, t.precio, t.comprobante -- transacciones
FROM transacciones t
JOIN tipo_transaccion tt ON fk_tipo_transaccion = id_tipo_transaccion
JOIN tipo_documento td ON fk_tipo_documento = id_tipo_documento
JOIN producto p ON fk_articulo = id_producto LEFT JOIN tipo_producto tp ON fk_tipo_producto = id_tipo_producto
JOIN personas ON fk_persona = id_persona LEFT JOIN datos_persona dp ON fk_datos_persona = id_datos_persona LEFT JOIN tipo_persona tp1 ON fk_tipo_persona = id_tipo_persona
WHERE tt.transaccion LIKE 'Venta%';

