CREATE DATABASE IF NOT EXISTS netflow;
USE netflow;

-- 2) TABLAS
CREATE TABLE IF NOT EXISTS empleados(
  id_empleado INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  dni INT NOT NULL UNIQUE,
  puesto VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS clientes(
  id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  dni INT NOT NULL UNIQUE,
  direccion VARCHAR(80) NOT NULL,
  telefono VARCHAR(30),
  email VARCHAR(50) UNIQUE
);

CREATE TABLE IF NOT EXISTS cablemodems(
  id_cablemodem INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  marca VARCHAR(50) NOT NULL,
  nro_serie VARCHAR(50) NOT NULL UNIQUE,
  estado ENUM('disponible','asignado','baja') DEFAULT 'disponible'
);

CREATE TABLE IF NOT EXISTS planes(
  id_plan INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(50),
  velocidad INT NOT NULL,
  unidad VARCHAR(10) NOT NULL,
  precio DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS servicios(
  id_servicio INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  descripcion VARCHAR(100),
  id_plan INT NOT NULL,
  FOREIGN KEY (id_plan) REFERENCES planes(id_plan)
);

CREATE TABLE IF NOT EXISTS cliente_servicio(
  id_cliente INT NOT NULL,
  id_servicio INT NOT NULL,
  PRIMARY KEY (id_cliente, id_servicio),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);

CREATE TABLE IF NOT EXISTS asignaciones(
  id_asignacion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  id_empleado INT NOT NULL,
  id_cliente INT NOT NULL,
  id_cablemodem INT NOT NULL,
  fecha_entrega DATE NOT NULL,
  FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_cablemodem) REFERENCES cablemodems(id_cablemodem)
);

CREATE TABLE IF NOT EXISTS movimientos_stock(
  id_movimiento INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  id_cablemodem INT NOT NULL,
  id_empleado INT NOT NULL,
  tipo_movimiento ENUM('entrada','salida','baja') NOT NULL,
  fecha DATE,
  detalle VARCHAR(100),
  FOREIGN KEY (id_cablemodem) REFERENCES cablemodems(id_cablemodem),
  FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- 3) DATOS (SEMILLA)
INSERT INTO empleados (nombre, apellido, dni, puesto) VALUES
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

INSERT INTO clientes (nombre, apellido, dni, direccion, telefono, email) VALUES
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

INSERT INTO cablemodems (modelo, marca, nro_serie, estado) VALUES
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

INSERT INTO planes (nombre, velocidad, unidad, precio) VALUES
('Plan Basico', 100, 'Mbs', 1500.00),
('Plan Estandar', 200, 'Mbs', 2500.00),
('Plan Premium', 300, 'Mbs', 4000.00);

INSERT INTO servicios (descripcion, id_plan) VALUES
('Internet Hogar Basico con soporte 24/7', 1),
('Internet Hogar Estandar con IP dinamica', 2),
('Conexion Premium para Streaming y Gaming', 3);

INSERT INTO cliente_servicio (id_cliente, id_servicio) VALUES
(1, 1),(1, 2),(2, 3),(3, 1),(4, 3),(5, 2),(6, 2),(7, 3),(8, 1),(9, 1);

INSERT INTO asignaciones (id_empleado, id_cliente, id_cablemodem, fecha_entrega) VALUES
(4, 3, 1, '2024-03-25'),
(5, 4, 2, '2023-05-26'),
(6, 6, 4, '2025-07-27'),
(7, 7, 6, '2025-01-28'),
(8, 8, 8, '2025-02-11'),
(9, 9, 9, '2024-12-14'),
(10, 10, 10, '2024-11-29');

INSERT INTO movimientos_stock (id_cablemodem, id_empleado, tipo_movimiento, fecha, detalle) VALUES
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

-- 4) VISTAS
CREATE OR REPLACE VIEW vista_clientes_servicios AS
SELECT c.id_cliente, c.nombre, c.apellido, s.descripcion AS servicio, p.nombre AS plan, p.velocidad, p.unidad, p.precio
FROM clientes c
JOIN cliente_servicio cs ON c.id_cliente = cs.id_cliente
JOIN servicios s ON cs.id_servicio = s.id_servicio
JOIN planes p ON s.id_plan = p.id_plan;

CREATE OR REPLACE VIEW vista_stock_cablemodems AS
SELECT id_cablemodem, modelo, marca, nro_serie, estado
FROM cablemodems
WHERE estado = 'disponible';

CREATE OR REPLACE VIEW vista_asignaciones AS
SELECT a.id_asignacion, e.nombre AS empleado_nombre, e.apellido AS empleado_apellido,
       c.nombre AS cliente_nombre, c.apellido AS cliente_apellido,
       cm.modelo, cm.marca, a.fecha_entrega
FROM asignaciones a
JOIN empleados e ON a.id_empleado = e.id_empleado
JOIN clientes c ON a.id_cliente = c.id_cliente
JOIN cablemodems cm ON a.id_cablemodem = cm.id_cablemodem;

CREATE OR REPLACE VIEW vista_movimientos_stock AS
SELECT m.id_movimiento, cm.modelo, cm.marca, cm.nro_serie,
       m.tipo_movimiento, m.fecha, m.detalle,
       e.nombre AS nombre_empleado, e.apellido AS apellido_empleado
FROM movimientos_stock m
JOIN cablemodems cm ON m.id_cablemodem = cm.id_cablemodem
JOIN empleados e    ON m.id_empleado   = e.id_empleado;

CREATE OR REPLACE VIEW vista_cablemodems_disponibles AS
SELECT id_cablemodem, modelo, marca, nro_serie, estado
FROM cablemodems
WHERE estado = 'disponible';

-- 5) FUNCIONES
DELIMITER //

-- Devuelve el precio de un plan por ID
DROP FUNCTION IF EXISTS fn_precio_plan //
CREATE FUNCTION fn_precio_plan(p_id_plan INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_precio DECIMAL(10,2);
  SELECT precio INTO v_precio FROM planes WHERE id_plan = p_id_plan;
  RETURN IFNULL(v_precio,0.00);
END //

-- Devuelve cuántos servicios tiene un cliente
DROP FUNCTION IF EXISTS fn_cantidad_servicios //
CREATE FUNCTION fn_cantidad_servicios(p_id_cliente INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_total INT;
  SELECT COUNT(*) INTO v_total FROM cliente_servicio WHERE id_cliente = p_id_cliente;
  RETURN IFNULL(v_total,0);
END //

-- Devuelve 1 si el cablemodem está disponible, 0 si no
DROP FUNCTION IF EXISTS fn_cablemodem_disponible //
CREATE FUNCTION fn_cablemodem_disponible(p_id_cablemodem INT)
RETURNS TINYINT
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_estado VARCHAR(20);
  SELECT estado INTO v_estado FROM cablemodems WHERE id_cablemodem = p_id_cablemodem;
  RETURN v_estado = 'disponible';
END //

DELIMITER ;

-- 6) STORED PROCEDURES
DELIMITER //

-- Vincula cliente con servicio solo si no lo tiene
DROP PROCEDURE IF EXISTS sp_alta_cliente_servicio //
CREATE PROCEDURE sp_alta_cliente_servicio(IN p_id_cliente INT, IN p_id_servicio INT)
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM cliente_servicio
    WHERE id_cliente = p_id_cliente AND id_servicio = p_id_servicio
  ) THEN
    INSERT INTO cliente_servicio(id_cliente, id_servicio)
    VALUES(p_id_cliente, p_id_servicio);
  END IF;
END //

-- Registra un movimiento y actualiza estado del equipo
DROP PROCEDURE IF EXISTS sp_registrar_movimiento_stock //
CREATE PROCEDURE sp_registrar_movimiento_stock(
  IN p_id_cablemodem INT,
  IN p_id_empleado INT,
  IN p_tipo_movimiento VARCHAR(10),
  IN p_fecha DATE,
  IN p_detalle VARCHAR(100)
)
BEGIN
  INSERT INTO movimientos_stock(id_cablemodem,id_empleado,tipo_movimiento,fecha,detalle)
  VALUES(p_id_cablemodem,p_id_empleado,p_tipo_movimiento,p_fecha,p_detalle);

  IF p_tipo_movimiento = 'entrada' THEN
    UPDATE cablemodems SET estado='disponible' WHERE id_cablemodem=p_id_cablemodem;
  ELSEIF p_tipo_movimiento = 'salida' THEN
    UPDATE cablemodems SET estado='asignado' WHERE id_cablemodem=p_id_cablemodem;
  ELSEIF p_tipo_movimiento = 'baja' THEN
    UPDATE cablemodems SET estado='baja' WHERE id_cablemodem=p_id_cablemodem;
  END IF;
END //

-- Asigna un cablemodem disponible y registra salida en stock
DROP PROCEDURE IF EXISTS sp_asignar_cablemodem //
CREATE PROCEDURE sp_asignar_cablemodem(
  IN p_id_empleado INT,
  IN p_id_cliente INT,
  IN p_id_cablemodem INT,
  IN p_fecha_entrega DATE
)
BEGIN
  DECLARE v_estado VARCHAR(20);

  SELECT estado INTO v_estado
  FROM cablemodems
  WHERE id_cablemodem = p_id_cablemodem;

  IF v_estado IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cablemodem inexistente';
  END IF;

  IF v_estado <> 'disponible' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='El cablemodem no está disponible';
  END IF;

  INSERT INTO asignaciones(id_empleado,id_cliente,id_cablemodem,fecha_entrega)
  VALUES(p_id_empleado,p_id_cliente,p_id_cablemodem,p_fecha_entrega);

  CALL sp_registrar_movimiento_stock(
    p_id_cablemodem, p_id_empleado, 'salida', p_fecha_entrega,
    CONCAT('Asignado a cliente ID ', p_id_cliente)
  );
END //

DELIMITER ;

-- 7) TRIGGERS
DELIMITER //

-- Evita insertar asignaciones si el equipo no está disponible
DROP TRIGGER IF EXISTS trg_asignaciones_bi //
CREATE TRIGGER trg_asignaciones_bi
BEFORE INSERT ON asignaciones
FOR EACH ROW
BEGIN
  DECLARE v_estado VARCHAR(20);
  SELECT estado INTO v_estado FROM cablemodems WHERE id_cablemodem = NEW.id_cablemodem;
  IF v_estado <> 'disponible' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger: cablemodem no disponible';
  END IF;
END //

-- Marca el cablemodem como asignado al crear la asignación
DROP TRIGGER IF EXISTS trg_asignaciones_ai //
CREATE TRIGGER trg_asignaciones_ai
AFTER INSERT ON asignaciones
FOR EACH ROW
BEGIN
  UPDATE cablemodems SET estado = 'asignado' WHERE id_cablemodem = NEW.id_cablemodem;
END //

-- Devuelve a disponible si se borra la asignación (salvo baja)
DROP TRIGGER IF EXISTS trg_asignaciones_ad //
CREATE TRIGGER trg_asignaciones_ad
AFTER DELETE ON asignaciones
FOR EACH ROW
BEGIN
  UPDATE cablemodems
  SET estado = 'disponible'
  WHERE id_cablemodem = OLD.id_cablemodem AND estado <> 'baja';
END //

-- Sincroniza estado según el movimiento insertado en stock
DROP TRIGGER IF EXISTS trg_movimientos_stock_ai //
CREATE TRIGGER trg_movimientos_stock_ai
AFTER INSERT ON movimientos_stock
FOR EACH ROW
BEGIN
  IF NEW.tipo_movimiento = 'entrada' THEN
    UPDATE cablemodems SET estado = 'disponible' WHERE id_cablemodem = NEW.id_cablemodem;
  ELSEIF NEW.tipo_movimiento = 'salida' THEN
    UPDATE cablemodems SET estado = 'asignado' WHERE id_cablemodem = NEW.id_cablemodem;
  ELSEIF NEW.tipo_movimiento = 'baja' THEN
    UPDATE cablemodems SET estado = 'baja' WHERE id_cablemodem = NEW.id_cablemodem;
  END IF;
END //

DELIMITER ;

-- Iniciamos la transacción
START TRANSACTION;

-- Insertamos una nueva asignación
INSERT INTO asignaciones(id_empleado, id_cliente, id_cablemodem, fecha_entrega)
VALUES (3, 5, 1, '2025-09-16');

-- Registramos el movimiento en stock
INSERT INTO movimientos_stock(id_cablemodem, id_empleado, tipo_movimiento, fecha, detalle)
VALUES (1, 3, 'salida', '2025-09-16', 'Asignado a cliente ID 5');

-- Confirmamos los cambios
COMMIT;

-- ERROR: intento de insertar un cliente con mismo DNI
INSERT INTO clientes (nombre, apellido, dni, direccion, telefono, email)
VALUES ('Prueba', 'Duplicado', 34111222, 'Falsa 123', '3519998888', 'duplicado@test.com');

SELECT fn_precio_plan(2) AS precio_plan_estandar; 

SELECT fn_cantidad_servicios(1) AS servicios_cliente_1;

SELECT fn_cablemodem_disponible(1) AS cablemodem_1_disponible;

CALL sp_asignar_cablemodem(1, 2, 4, '2025-09-16');
