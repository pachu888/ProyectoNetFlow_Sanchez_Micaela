USE netflow;

-- Vista 1: Lista de clientes con sus servicios y planes
CREATE OR REPLACE VIEW vista_clientes_servicios AS
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    c.dni,
    p.nombre AS nombre_plan,
    p.velocidad,
    p.unidad,
    p.precio
FROM clientes c
JOIN cliente_servicio cs ON c.id_cliente = cs.id_cliente
JOIN servicios s ON cs.id_servicio = s.id_servicio
JOIN planes p ON s.id_plan = p.id_plan;

-- Vista 2: Stock de cablemodems con su estado
CREATE OR REPLACE VIEW vista_stock_cablemodems AS
SELECT 
    id_cablemodem,
    modelo,
    marca,
    nro_serie,
    estado
FROM cablemodems;

-- Vista 3: Asignaciones con detalle de cliente, empleado y cablemodem
CREATE OR REPLACE VIEW vista_asignaciones_detalle AS
SELECT 
    a.id_asignacion,
    e.nombre AS nombre_empleado,
    e.apellido AS apellido_empleado,
    c.nombre AS nombre_cliente,
    c.apellido AS apellido_cliente,
    cm.modelo AS modelo_cablemodem,
    cm.marca AS marca_cablemodem,
    a.fecha_entrega
FROM asignaciones a
JOIN empleados e ON a.id_empleado = e.id_empleado
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN cablemodems cm ON a.id_cablemodem = cm.id_cablemodem;

-- Vista 4: Movimientos de stock con detalle
CREATE OR REPLACE VIEW vista_movimientos_stock AS
SELECT 
    m.id_movimiento,
    cm.modelo,
    cm.marca,
    cm.nro_serie,
    m.tipo_movimiento,
    m.fecha,
    m.detalle,
    e.nombre AS nombre_empleado,
    e.apellido AS apellido_empleado
FROM movimientos_stock m
JOIN cablemodems cm ON m.id_cablemodem = cm.id_cablemodem
JOIN empleados e ON m.id_empleado = e.id_empleado;

-- Vista 5: Cablemodems disponibles
CREATE OR REPLACE VIEW vista_cablemodems_disponibles AS
SELECT 
    id_cablemodem,
    modelo,
    marca,
    nro_serie,
    estado
FROM cablemodems
WHERE estado = 'disponible';
