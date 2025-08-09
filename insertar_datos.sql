INSERT INTO empleados (nombre, apellido, dni, puesto)
VALUES
('Lucia', 'Gonzalez', 30123456, 'Tecnico'),
('Martin', 'Perez', 28987654, 'Atencion al Cliente'),
('Sofia', 'Ramirez', 31222333, 'Instalador'),
('Carlos', 'Lopez', 29444555, 'Tecnico'),
('Valentina', 'Fernandez', 30333999, 'Administrativo'),
('Tomas', 'Diaz', 27888999, 'Coordinador de Área'),
('Camila', 'Torres', 32111222, 'Instalador'),
('Micaela', 'Sanchez', 28888888, 'Tecnico'),
('Mariana', 'Cordoba', 29999999, 'Atencion al Cliente'),
('Nicolas', 'Castro', 31122334, 'Soporte Tecnico');

INSERT INTO clientes (nombre, apellido, dni, direccion, telefono, email)
VALUES
('Joaquin', 'Martinez', 34111222, 'San Martin 1234', '3511234567', 'joaquinmartinez@email.com'),
('Agustina', 'Rodriguez', 35222333, 'Belgrano 567', '3512345678', 'agustinarodriguez@hotmail.com'),
('Leandro', 'Paz', 33666777, 'Alberdi 12', '3513456789', 'leandropaz@yahoo.com'),
('Florencia', 'Gomez', 32111999, 'Uruguay 144', '3514567890', 'florgomez@email.com'),
('Ramiro', 'Fernandez', 33112233, 'Rivadavia 890', '3515678901', 'ramirofernandez@gmail.com'),
('Micaela', 'Suarez', 34999888, 'San Martin 123', '3516789012', 'micasuarez@email.com'),
('Luciano', 'Vega', 31234567, 'Colon 2000', '3517890123', 'lucianovega@gmail.com'),
('Carla', 'Torres', 32888777, 'Maipu 333', '3518901234', 'carlatorres@yahoo.com'),
('Bruno', 'Luna', 31999887, 'Independencia 44', '3519012345', 'brunoluna@email.com'),
('Julieta', 'Molina', 33000111, 'Esperanza 123', '3519123456', 'julietamolina@hotmail.com');

INSERT INTO cablemodems (modelo, marca, nro_serie, estado)
VALUES
('HG532e', 'Huawei', 'SN200001', 'disponible'),
('TC7210', 'Arris', 'SN200002', 'asignado'),
('WR841N', 'TP-Link', 'SN200003', 'baja'),
('SB6183', 'Arris', 'SN200004', 'disponible'),
('DPC3008', 'Cisco', 'SN200005', 'asignado'),
('CM8200', 'Cisco', 'SN200006', 'disponible'),
('C7000', 'Netgear', 'SN200007', 'disponible'),
('HG8546M', 'Huawei', 'SN200008', 'asignado'),
('DR53KL', 'TP-Link', 'SN200009', 'disponible'),
('E31U2V1', 'Hitron', 'SN200010', 'baja');

INSERT INTO planes (nombre, velocidad, unidad, precio)
VALUES
('Plan Basico', 100, 'Mbs', 1500.00),
('Plan Estandar', 200, 'Mbs', 2500.00),
('Plan Premium', 300, 'Mbs', 4000.00);

INSERT INTO servicios (descripcion, id_plan)
VALUES
('Internet Hogar Basico con soporte 24/7', 1),
('Internet Hogar Estandar con IP dinamica', 2),
('Conexion Premium para Streaming y Gaming', 3);

INSERT INTO cliente_servicio (id_cliente, id_servicio) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1),
(4, 3),
(5, 2),
(6, 2),
(7, 3),
(8, 1),
(9, 1);

INSERT INTO asignaciones (id_empleado, id_cliente, id_cablemodem, fecha_entrega)
VALUES
(4, 3, 1, '2024-03-25'),
(5, 4, 2, '2023-05-26'),
(6, 6, 4, '2025-07-27'),
(7, 7, 6, '2025-01-28'),
(8, 8, 8, '2025-02-11'),
(9, 9, 9, '2024-12-14'),
(10, 10, 10, '2024-11-29');


INSERT INTO movimientos_stock (id_cablemodem, id_empleado, tipo_movimiento, fecha, detalle)
VALUES
(1, 1, 'entrada', '2025-07-20', 'Ingreso por compra nueva'),
(2, 2, 'entrada', '2024-12-15', 'Reposicion de stock'),
(3, 1, 'baja', '2025-03-11', 'Equipo dañado irreparable'),
(4, 3, 'salida', '2025-01-22', 'Asignacion a cliente ID 6'),
(5, 4, 'salida', '2025-07-23', 'Instalacion en domicilio'),
(6, 2, 'entrada', '2025-06-02', 'Recuperado de baja'),
(7, 3, 'salida', '2025-05-25', 'Asignado a cliente empresa'),
(8, 5, 'baja', '2025-07-25', 'Robo reportado'),
(9, 1, 'salida', '2025-07-12', 'Instalado en nueva cuenta'),
(10, 2, 'entrada', '2025-07-27', 'Nuevo lote recibido');