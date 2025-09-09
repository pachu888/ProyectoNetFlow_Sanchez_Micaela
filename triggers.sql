-- TRIGGERS
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