
-- -----------------------------------------------------------------------------------------------------------------------
--                                                                                  Consultas de Tablas para Vistas  -----
--                                        --------------------------------------------------------------------------------

-- ---------------------------- INV- INSUMOS
SELECT * FROM tipo_insumo;
SELECT * FROM inventario_insumos;

SELECT ii.*, u.alias, e.nombre_empresa FROM inventario_insumos ii JOIN usuarios u ON fk_usuario = id_usuario JOIN proveedores p ON fk_proveedor=fk_id_proveedor and ii.fk_ti_proveedor= p.fk_ti_proveedor LEFT JOIN empresas e ON fk_empresa=nit ORDER BY fecha_registro DESC;

-- ---------------------------- INV. PRODUCCIÓN
SELECT * FROM rollos_medianos;
SELECT rm.*, ii.consecutivo_insumo FROM rollos_medianos rm INNER JOIN inventario_insumos ii ON fk_insumo = id_inventario_insumos;

SELECT * FROM cortes_jumbo;
SELECT *, (SELECT sum(peso_jumbo) FROM cortes_jumbo WHERE pfk_rollo_mediano=1) as peso_corte_total FROM cortes_jumbo WHERE pfk_rollo_mediano=1;

    -- Consulta para Peso Final de Corte
    SELECT sum(peso_jumbo) as peso_final_corte FROM cortes_jumbo where pfk_rollo_mediano = 1;
    -- Consulta para Peso Inicial de Rollo
    SELECT rm.id_rollos_medianos, rm.peso FROM rollos_medianos rm where id_rollos_medianos = 1;

SELECT * FROM inventario_produccion;
SELECT ip.id_inv_produccion, ip.fecha_registro, ii.consecutivo_insumo, rm.peso as peso_inicial, concat(ip.fk_rollo_mediano, ip.fk_rollo_jumbo) as id_rollo_jumbo, p.fk_tipo_producto, p.fk_color, ip.peso_producto, (select peso_jumbo from cortes_jumbo where pfk_rollo_mediano=ip.fk_rollo_mediano and rollo_jumbo= ip.fk_rollo_jumbo) as peso_jumbo, u.alias, ip.fk_estado_registro FROM inventario_produccion ip INNER JOIN cortes_jumbo c ON fk_rollo_mediano = pfk_rollo_mediano and fk_rollo_jumbo = rollo_jumbo LEFT JOIN rollos_medianos rm ON fk_rollo_mediano = id_rollos_medianos INNER JOIN inventario_insumos ii ON fk_insumo = id_inventario_insumos JOIN productos p ON fk_producto = id_producto JOIN usuarios u ON ip.fk_usuario = id_usuario;
-- where ip.fk_rollo_mediano = 1 and ip.fk_rollo_jumbo = 1;

-- ---------------------------- TRANSACCIONES COMPRAS (insumos)
SELECT * FROM tipo_documento;
SELECT * FROM tipo_transaccion;

SELECT * FROM transacciones_compras;
SELECT tc.id_transacciones, tt.tp_transaccion, td.doc_transaccion, ti.nombre_insumo, e.nombre_empresa, e.descripcion_empresa, tc.fecha_registro, tc.precio, tc.comprobante FROM transacciones_compras tc JOIN tipo_transaccion tt ON fk_tipo_transaccion = tp_transaccion JOIN tipo_documento td ON fk_tipo_documento = doc_transaccion JOIN tipo_insumo ti ON fk_articulo = nombre_insumo  JOIN proveedores p ON fk_proveedor = fk_id_proveedor LEFT JOIN empresas e ON fk_empresa = nit ORDER BY id_transacciones DESC;

-- ---------------------------- TRANSACCIONES VENTAS (Productos)
SELECT * FROM transacciones_ventas;	
SELECT tv.id_transacciones, tt.tp_transaccion, td.doc_transaccion, tp.producto, e.nombre_empresa, tv.fk_cliente, tv.fecha_registro, tv.precio, tv.comprobante FROM transacciones_ventas tv JOIN tipo_transaccion tt ON fk_tipo_transaccion = tp_transaccion JOIN tipo_documento td ON fk_tipo_documento = doc_transaccion JOIN tipo_producto tp ON fk_articulo = producto JOIN clientes c ON fk_cliente = fk_id_cliente LEFT JOIN empresas e ON fk_empresa = nit ORDER BY id_transacciones DESC;

-- ---------------------------- PRODUCTOS
SELECT * FROM tipo_producto;
SELECT * FROM productos ORDER BY id_producto DESC;

SELECT p.id_producto, p.fk_tipo_producto, p.fk_color, p.precio_producto, COUNT(*) AS cantidad_productos, c.tipo_categoria AS categoria FROM productos p INNER JOIN categorias c ON p.fk_categoria = c.id_categoria GROUP BY p.id_producto, c.tipo_categoria, p.fk_tipo_producto, p.fk_color, p.precio_producto ORDER BY p.id_producto DESC;
SELECT p.fk_tipo_producto, GROUP_CONCAT( p.fk_color) AS colores, c.tipo_categoria AS categoria FROM productos p INNER JOIN categorias c ON p.fk_categoria = c.id_categoria GROUP BY  p.fk_tipo_producto, c.tipo_categoria;
-- ---------------------------- CLIENTES
SELECT * FROM datos_persona;
SELECT * FROM clientes;
SELECT * FROM empresas;

SELECT ti.tipo_id , dp.persona_id, dp.nombre_1, dp.apellido_1, dp.telefono, dp.correo, e.NIT, e.nombre_empresa, dp.direccion FROM clientes c INNER JOIN datos_persona dp ON persona_id = fk_id_cliente and fk_tipo_identificacion = fk_ti_cliente LEFT JOIN tipo_identificacion ti ON tipo_id = fk_tipo_identificacion JOIN empresas e ON nit = fk_empresa;

-- ---------------------------- PROVEEDORES
SELECT * FROM datos_persona;
SELECT * FROM proveedores;
SELECT * FROM empresas;

SELECT ti.tipo_id, dp.persona_id, dp.nombre_1, dp.apellido_1, dp.telefono, dp.correo, e.NIT, e.nombre_empresa, e.descripcion_empresa, dp.direccion FROM proveedores pr INNER JOIN datos_persona dp ON persona_id = fk_id_proveedor and fk_tipo_identificacion = fk_ti_proveedor LEFT JOIN tipo_identificacion ti ON tipo_id = fk_tipo_identificacion JOIN empresas e ON nit = fk_empresa;

-- ----------------------------  USUARIOS - PERMISOS
SELECT * FROM usuarios;
SELECT * FROM datos_persona;

SELECT up.fk_usuario as usuario_id, GROUP_CONCAT(p.permiso_sistema) as permisos, u.alias, dp.* FROM usuarios u JOIN datos_persona dp ON persona_id=fk_id_empleado and fk_ti_empleado=fk_tipo_identificacion RIGHT JOIN usuario_permiso up ON fk_usuario = id_usuario LEFT JOIN permisos p ON fk_permiso = id_permiso GROUP BY usuario_id, u.alias, dp.persona_id ORDER BY usuario_id DESC;

-- ---------------------------- USUARIOS
SELECT * FROM usuarios;
SELECT * FROM permisos;

SELECT u.id_usuario, u. alias, u.contraseña, dp.persona_id, dp.nombre_1, dp.apellido_1, dp.correo, u.estado_usuario FROM usuarios u LEFT JOIN datos_persona dp ON persona_id = fk_id_empleado and fk_tipo_identificacion = fk_ti_empleado;

-- -----------------------------------------------------------------------------------------------------------------------
--                                                                                           Updates para Tablas  -----
--                                        --------------------------------------------------------------------------------
-- ACTUALIZACION PARA USUARIO -------
-- TABLA datos persona
	-- N° Identificación
	-- Tipo de Identificación
	-- Nombres
	-- Apellidos
	-- Telefono
	-- Direccion
	-- Correo Electrónico
UPDATE datos_persona SET persona_id ='DatoNuevo', fk_tipo_identificacion ='DatoNuevo', nombre_1 ='DatoNuevo', nombre_2 ='DatoNuevo', apellido_1 ='DatoNuevo', apellido_2 ='DatoNuevo', telefono ='DatoNuevo', direccion ='DatoNuevo', correo ='DatoNuevo', fk_tipo_persona ='DatoNuevo' WHERE persona_id = 'IdUsuario';
	
-- TABLA usuarios
	-- Nombre de Usuario
	-- Contraseña
UPDATE usuarios SET alias='DatoNuevo', contraseña='DatoNuevo', estado_usuario='DatoNuevo' WHERE id_usuario = 'IdUsuario';
    
-- TABLA usuarios-permisos
	-- Permisos
    -- 1Forma: Eliminar todos los registros de permios que tenga ese usuario para que al guardarse, se vuelvan a generar todos los permisos que le queden asignados
    DELETE FROM usuario_permiso WHERE fk_usuario = 1;
    -- 2da forma Validar cuales permisos se deben eliminar, cuales se mantienen y cuales añadir para generar una sentencia DELETE y un INSERT.
    DELETE FROM usuario_permiso WHERE fk_usuario = 1 AND fk_permiso = 1;
    
    
-- ACTUALIZACION PARA CLIENTE/PROVEEDOR -------
-- TABLA datos persona
	--  N° Identificación
	-- Tipo de Identificación
	-- Nombres
	-- Apellidos
	-- Telefono
	-- Direccion
	-- Correo Electrónico
UPDATE datos_persona SET persona_id ='DatoNuevo', fk_tipo_identificacion ='DatoNuevo', nombre_1 ='DatoNuevo', nombre_2 ='DatoNuevo', apellido_1 ='DatoNuevo', apellido_2 ='DatoNuevo', telefono ='DatoNuevo', direccion ='DatoNuevo', correo ='DatoNuevo' WHERE persona_id = 'IdUsuario';

-- TABLA empresas
	-- Numero de NIT
	-- Nombre Empresa
	-- Descripción
UPDATE empresas SET nit = 'DatoNuevo', nombre_empresa = 'DatoNuevo', descripcion_empresa = 'DatoNuevo' WHERE nit = 'DatoNuevo';

-- ACTUALIZACION PARA PRODUCTOS (No implica editar valores de las otras tablas)-------
UPDATE productos SET fk_tipo_producto = 'DatoNuevo', fk_categoria = 'DatoNuevo', fk_color = 'DatoNuevo', peso_producto = 'DatoNuevo', precio_producto = 'DatoNuevo', comentario = 'DatoNuevo' WHERE id_producto = 'IdProducto';


-- ACTUALIZACION PARA REGISTRO TRANSACCIONES(No implica editar valores en las otras tablas) -------
UPDATE transacciones_compras SET fk_tipo_transaccion = 'DatoNuevo', fk_tipo_documento = 'DatoNuevo', fk_articulo = 'DatoNuevo', fk_t_identi = 'DatoNuevo', fk_proveedor = 'DatoNuevo', precio = 'DatoNuevo' WHERE id_transacciones = 'IdRegistro';

UPDATE transacciones_ventas SET fk_tipo_transaccion = 'DatoNuevo', fk_tipo_documento = 'DatoNuevo', fk_articulo = 'DatoNuevo', fk_t_identi = 'DatoNuevo', fk_cliente = 'DatoNuevo', precio = 'DatoNuevo' WHERE id_transacciones = 'IdRegistro';


-- ACTUALIZACION PARA REGISTRO INV-INSUMOS (No implica editar valores de las otras tablas)-------
UPDATE inventario_insumos SET fk_tipo_insumo = 'DatoNuevo', consecutivo_insumo = 'DatoNuevo', peso_insumo = 'DatoNuevo', fk_estado = 'DatoNuevo', fecha_recibido = 'DatoNuevo', unidades = 'DatoNuevo',  fk_proveedor = 'DatoNuevo', fk_ti_proveedor = 'DatoNuevo', estado_registro = 'DatoNuevo' WHERE id_inventario_insumos = 'IdRegistro';

-- ACTUALIZACION PARA REGISTRO INV-PRODUCCCIÓN (No implica editar valores de las otras tablas)-------
-- UPDATE SET WHERE ;

SELECT tc.id_transacciones, tt.tp_transaccion, td.doc_transaccion, ti.nombre_insumo, e.nombre_empresa, e.descripcion_empresa, tc.fecha_registro, tc.precio, tc.comprobante, dt.persona_id, dt.fk_tipo_identificacion FROM transacciones_compras tc JOIN tipo_transaccion tt ON fk_tipo_transaccion = tp_transaccion JOIN tipo_documento td ON fk_tipo_documento = doc_transaccion JOIN tipo_insumo ti ON fk_articulo = nombre_insumo  JOIN proveedores p ON fk_proveedor = fk_id_proveedor JOIN datos_persona dt on persona_id = fk_proveedor LEFT JOIN empresas e ON fk_empresa = nit ORDER BY id_transacciones DESC;

select * from datos_persona;
-- '1032458967', 'CC', '10122012334-5', '1'

SELECT tt.tp_transaccion, td.doc_transaccion, tp.producto, tv.precio, dt.persona_id 
FROM transacciones_ventas tv 
JOIN tipo_transaccion tt ON fk_tipo_transaccion = tp_transaccion 
JOIN tipo_documento td ON fk_tipo_documento = doc_transaccion 
JOIN tipo_producto tp ON fk_articulo = producto 
JOIN clientes c ON fk_cliente = fk_id_cliente 
JOIN datos_persona dt on persona_id = fk_id_cliente 
LEFT JOIN empresas e ON fk_empresa = nit 
ORDER BY id_transacciones DESC;

select * from datos_persona;
select * from transacciones_ventas;

UPDATE transacciones_ventas AS tv
JOIN tipo_transaccion AS tt ON tv.fk_tipo_transaccion = tt.tp_transaccion
JOIN tipo_documento AS td ON tv.fk_tipo_documento = td.doc_transaccion
JOIN tipo_producto AS tp ON tv.fk_articulo = tp.producto
JOIN clientes AS c ON tv.fk_cliente = c.fk_id_cliente
JOIN datos_persona AS dt ON c.persona_id = dt.persona_id
LEFT JOIN empresas AS e ON c.fk_empresa = e.nit
SET 
    tv.doc_transaccion = 'Remisión',
    tv.producto = 'Jumbo',
    tv.precio = 3333,
    dt.persona_id = '103045685'
WHERE
    tv.id_transacciones = 3;
 
UPDATE transacciones_ventas
SET
	fk_tipo_documento = 'Remisión',
    fk_articulo = 'Jumbo',
    precio = 3333,
    fk_cliente = '103045685',
    fk_t_identi = 'CC'
WHERE
	id_transacciones = 3;
 
    

SELECT * FROM clientes WHERE fk_id_cliente = '103045685';
SELECT * FROM proveedores;
SELECT * FROM transacciones_compras;

UPDATE transacciones_compras
SET
    fk_tipo_documento = 'Factura',
    fk_articulo = 'Papel',
    fk_proveedor = 45965784,
    fk_t_identi = 'CC',
	precio = '435353'
WHERE
	id_transacciones = 2;

select * from usuarios;
select * from usuario_permiso;
select * from permisos;

select permiso_sistema from permisos;

select * from tipo_identificacion;
