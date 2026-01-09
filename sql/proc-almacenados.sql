-- STORED PROCEDURES
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
