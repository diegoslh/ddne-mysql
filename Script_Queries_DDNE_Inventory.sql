
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
SELECT * FROM medida_producto;
SELECT * FROM tipo_identificacion;
SELECT * FROM tipo_persona;
SELECT * FROM empresas;	
SELECT * FROM permisos;

	-- Entidades Débiles --
-- ----------------------------------------------------------------
--                               					  Joins  -----
--                                    -----------------------------

SELECT * FROM datos_persona;

SELECT dp.persona_id,  -- datos persona
		ti.nombre_identificacion as tipo_doc,  -- tipo identificacion
        dp.nombre_1, dp.nombre_2, dp.apellido_1, dp.apellido_2, dp.telefono, dp.direccion, dp.correo -- datos persona
FROM datos_persona dp
LEFT JOIN tipo_identificacion ti ON fk_tipo_identificacion = id_tipo_id;

-- ----------------------------
SELECT * FROM usuarios;

SELECT u.id_usuario, u. alias, u.contraseña, -- usuarios
		dp.persona_id, dp.nombre_1, dp.apellido_1, dp.correo, -- datos persona
        u.estado_usuario -- usuarios
FROM usuarios u
LEFT JOIN datos_persona dp ON persona_id = fk_id_empleado and fk_tipo_identificacion = fk_ti_empleado;

-- Desencriptar contraseña
select u.alias, convert(aes_decrypt(contraseña, 'users') using utf8mb3) as dato_desencriptado 
from usuarios u;

-- ----------------------------
SELECT * FROM clientes;

SELECT ti.nombre_identificacion as tipo_doc, dp.persona_id, dp.nombre_1, dp.apellido_1, dp.telefono, dp.correo, e.NIT, e.nombre_empresa, dp.direccion
FROM clientes c
INNER JOIN datos_persona dp ON persona_id = fk_id_cliente and fk_tipo_identificacion = fk_ti_cliente 
LEFT JOIN tipo_identificacion ti ON id_tipo_id = fk_tipo_identificacion
JOIN empresas e ON id_empresa = fk_empresa;

-- ----------------------------
SELECT * FROM proveedores;

SELECT ti.nombre_identificacion as tipo_doc, dp.persona_id, dp.nombre_1, dp.apellido_1, dp.telefono, dp.correo, e.NIT, e.nombre_empresa, e.descripcion_empresa, dp.direccion
FROM proveedores pr
INNER JOIN datos_persona dp ON persona_id = fk_id_proveedor and fk_tipo_identificacion = fk_ti_proveedor 
LEFT JOIN tipo_identificacion ti ON id_tipo_id = fk_tipo_identificacion
JOIN empresas e ON id_empresa = fk_empresa;

-- ----------------------------
SELECT * FROM insumos;

SELECT i.id_insumo,  -- insumo
        i. consecutivo_insumo, i.peso_insumo, -- insumo
        ti.nombre_insumo as insumo  -- tipo insumo
FROM tipo_insumo ti
RIGHT JOIN insumos i ON fk_tipo_insumo = id_tipo_insumo;

-- ----------------------------    
SELECT * FROM usuario_permiso;

SELECT up.id_usuario_permiso as registro, -- usuario permiso
		u.alias, -- usuarios
		-- up.fk_permiso as cod_permiso, -- usuario permiso
		p.permiso_sistema as permiso-- usuarios
FROM usuarios u
RIGHT JOIN usuario_permiso up ON fk_usuario = id_usuario
LEFT JOIN permisos p ON fk_permiso = id_permiso;

-- ----------------------------
SELECT * FROM productos;

	-- Si el producto es Resma
SELECT p.id_producto as registro,  -- producto
		tp.tipo_producto,  -- tipo producto
		e.tipo_estilo, e.figura_color,  -- estilos
		mp.medi_1, mp.medi_2, mp.medi_3,  -- medidas resmas
		p.peso_producto, p.precio_producto -- producto
FROM productos p
JOIN tipo_producto tp ON fk_tipo_producto = id_tipo_producto 
JOIN estilos e ON fk_estilo = id_estilo
JOIN medida_producto mp ON fk_medida_producto = id_medidas;

-- ----------------------------
SELECT * FROM inventario_insumos;

SELECT ii.id_inventario_insumos as registro, -- I. insumos
		ti. nombre_insumo, -- tipo insumo
		e.tipo_estado, -- estado 
		ii.unidades, ii.fecha_planificada, ii.fecha_registro, -- I. insumos
		emp.nombre_empresa as proveedor, -- empresas
		u.alias as usuario, -- usuarios
		ii.estado_registro -- I. insumos
FROM inventario_insumos ii
JOIN insumos i ON fk_insumo = id_insumo LEFT JOIN tipo_insumo ti ON fk_tipo_insumo = id_tipo_insumo
JOIN estado e ON fk_estado = id_estado
JOIN proveedores p ON fk_proveedor = fk_id_proveedor LEFT JOIN empresas emp ON fk_empresa = id_empresa
JOIN usuarios u ON fk_usuario = id_usuario;

-- ----------------------------
SELECT * FROM inventario_produccion;

SELECT ip.id_produccion as registro,  -- I. producción
		tp.tipo_producto as producto,  -- tipo producto
		ip.unidades, ip.parafina_consumida, ip.fecha_registro,  -- I. producción
		u.alias as usuario,  -- Usuarios
		ip.estado_registro -- I. producción
FROM inventario_produccion ip
JOIN productos p ON fk_producto = id_producto LEFT JOIN tipo_producto tp ON fk_tipo_producto = id_tipo_producto
JOIN usuarios u ON fk_usuario = id_usuario;

-- ----------------------------
SELECT * FROM transacciones_compras;
	-- Transacciones de Compras (insumos)
SELECT tc.id_transacciones as registro,  -- transacciones
		tt.transaccion as tipo_transaccion,  -- tipo transaccion
		td.documento_transaccion,  -- tipo documento
		ti.nombre_insumo as articulo,  -- tipo insumo
		e.nombre_empresa, e.descripcion_empresa,  -- empresas
		tc.fecha_registro, tc.precio, tc.comprobante -- transacciones
FROM transacciones_compras tc
JOIN tipo_transaccion tt ON fk_tipo_transaccion = id_tipo_transaccion
JOIN tipo_documento td ON fk_tipo_documento = id_tipo_documento
JOIN insumos i ON fk_articulo = id_insumo LEFT JOIN tipo_insumo ti ON fk_tipo_insumo = id_tipo_insumo
JOIN proveedores p ON fk_cliente = fk_id_proveedor LEFT JOIN empresas e ON fk_empresa = id_empresa;

-- ----------------------------
SELECT * FROM transacciones_ventas;
	-- Transacciones de Ventas (Productos) 
SELECT tv.id_transacciones as registro,  -- transacciones
		tt.transaccion as transaccion,  -- tipo transaccion
		td.documento_transaccion as documento,  -- tipo documento
		tp.tipo_producto as articulo,  -- tipo producto
		dp.nombre_1, dp.apellido_1, dp.telefono, dp.correo,  -- datos persona
        e.nombre_empresa, -- empresas
		tv.fecha_registro, tv.precio, tv.comprobante -- transacciones
FROM transacciones_ventas tv
JOIN tipo_transaccion tt ON fk_tipo_transaccion = id_tipo_transaccion
JOIN tipo_documento td ON fk_tipo_documento = id_tipo_documento
JOIN productos p ON fk_articulo = id_producto LEFT JOIN tipo_producto tp ON fk_tipo_producto = id_tipo_producto
JOIN clientes c ON fk_proveedor = fk_id_cliente LEFT JOIN empresas e ON fk_empresa = id_empresa INNER JOIN datos_persona dp ON fk_persona = persona_id;

