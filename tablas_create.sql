CREATE DATABASE IF NOT EXISTS netflow;
USE netflow;

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