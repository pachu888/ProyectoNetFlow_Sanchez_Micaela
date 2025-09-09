-- FUNCIONES
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