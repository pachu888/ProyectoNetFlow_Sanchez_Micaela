# Proyecto NetFlow - Base de Datos para Gestión de Servicios de Internet

## Descripción de la temática  
Este proyecto propone el diseño de una base de datos relacional para una empresa ficticia llamada NetFlow, la cual ofrece servicios de internet domiciliario. La base de datos permite gestionar clientes, empleados, servicios, planes de internet, equipos (cablemodems) y los movimientos de stock asociados.
Se busca cubrir las principales necesidades operativas de la empresa, garantizando la trazabilidad de los equipos, optimizando la organización interna y facilitando futuras integraciones con herramientas de análisis, atención al cliente y gestión contable.

## Objetivo  
El objetivo de este proyecto es desarrollar una base de datos relacional que permita gestionar de forma integral las operaciones de NetFlow, una empresa dedicada a la provisión de servicios de internet.
La base de datos está diseñada para:
Registrar información completa de los clientes, incluyendo datos personales, contacto y dirección.
Almacenar y organizar los datos de los empleados, quienes son los encargados de realizar las instalaciones y asignar los equipos.
Controlar el stock de cablemodems, detallando su modelo, marca, número de serie y estado (disponible, asignado o dado de baja).
Registrar las asignaciones de equipos, especificando qué empleado entrega qué equipo a qué cliente y en qué fecha.
Gestionar los planes de internet, con sus respectivas velocidades, unidades y precios.
Administrar los servicios contratados por los clientes, vinculando a cada uno con el plan correspondiente.
Llevar un historial de movimientos de stock, registrando entradas, salidas y bajas con su respectivo detalle.
De esta manera, el sistema permite una trazabilidad completa de los equipos, mejora la organización de los procesos internos y deja sentadas las bases para una futura integración con herramientas de análisis, atención al cliente o módulos contables.

## Situación problemática  
La empresa enfrenta varios problemas por no tener una base de datos organizada. La información de clientes, empleados, planes y equipos está dispersa o desactualizada, lo que genera errores frecuentes: no se sabe con certeza qué empleado entregó qué equipo, a qué cliente se le asignó, o en qué estado está cada cablemodem.
También se vuelve difícil hacer un seguimiento claro del stock o saber cuántos equipos están disponibles, asignados o dados de baja. Esto impide llevar una buena trazabilidad.
Toda esta falta de organización hace más lento el trabajo, puede afectar la atención al cliente y limita el crecimiento. Con la implementación de esta base de datos se busca solucionar esos problemas y dejar todo registrado de manera clara y estructurada.

## Modelo de negocio  
NetFlow es una empresa dedicada a ofrecer servicios de internet domiciliario mediante planes de conexión a distintas velocidades. Su modelo de negocio se basa en la contratación de planes por parte de clientes particulares, quienes reciben un cablemodem en comodato para acceder al servicio.
Los planes disponibles son:
Plan Básico: 50 Mbps por $1500 mensuales.
Plan Estándar: 100 Mbps por $2500 mensuales.
Plan Premium: 200 Mbps por $4000 mensuales.
La empresa organiza sus operaciones internas en distintas áreas: atención al cliente, soporte técnico, instalación y administración. Los empleados técnicos son los encargados de asignar equipos (cablemodems) a los clientes, y todo el proceso queda registrado en la base de datos: desde qué modelo y número de serie se entregó, hasta quién lo entregó y en qué fecha.
Además, la empresa mantiene un control de su inventario de equipos mediante un sistema de movimientos de stock, donde se registran entradas, salidas y bajas por fallas o robos. Esta estructura permite una gestión eficiente y facilita la trazabilidad de los dispositivos y los servicios contratados.

## Diagrama Entidad-Relación (E-R)  
![DER_ProyectoNetFlow.png](https://github.com/pachu888/ProyectoNetFlow_Sanchez/blob/main/DER_ProyectoNetFlow.png?raw=true)

El diagrama representa las entidades principales: empleados, clientes, cablemodems, planes, servicios, asignaciones y movimientos de stock. También muestra las relaciones entre ellas, como la asignación de equipos a clientes y la asociación de servicios con planes.

# Listado de tablas

## Tabla "empleados":
Clave primaria: id_empleado (identificador único del empleado).
Claves foráneas: No tiene.
La clave primaria "id_empleado" se seleccionó como identificador único para cada empleado en la empresa.

## Tabla "clientes":
Clave primaria: id_cliente (identificador único del cliente).
Claves foráneas: No tiene.
La clave primaria "id_cliente" identifica de manera única a cada cliente, evitando confusiones incluso si dos clientes tienen el mismo nombre o DNI.

## Tabla "cablemodems":
Clave primaria: id_cablemodem (identificador único del cablemódem).
Claves foráneas: No tiene.
La clave primaria "id_cablemodem" se utiliza para identificar cada equipo de manera única, facilitando su control de inventario y asignaciones.

## Tabla: "planes":
Clave primaria: id_plan (identificador único del plan).
Claves foráneas: No tiene.
La clave primaria "id_plan" permite distinguir cada plan de internet por velocidad, unidad y precio.

## Tabla: "servicios":
Clave primaria: id_servicio (identificador único del servicio).
Clave foránea: "id_plan" hace referencia a planes.

## Tabla: "cliente_servicio":
Clave primaria: Compuesta (id_cliente, id_servicio).
Claves foráneas:
"id_cliente" referencia a clientes(id_cliente).
"id_servicio" referencia a servicios(id_servicio).
La clave compuesta evita duplicar la asignación del mismo servicio a un mismo cliente. Las claves foráneas permiten saber qué cliente tiene qué servicio contratado.

## Tabla: "asignaciones":
Clave primaria: id_asignacion (identificador único de la asignación).
Claves foráneas:
"id_empleado" referencia a empleados(id_empleado).
"id_cliente" referencia a clientes(id_cliente).
"id_cablemodem" referencia a cablemodems(id_cablemodem).
Permite llevar un registro de qué empleado entregó un cablemódem a qué cliente, en qué fecha y con qué equipo.

## Tabla: "movimientos_stock":
Clave primaria: id_movimiento (identificador único del movimiento de stock).
Claves foráneas:
"id_cablemodem" referencia a cablemodems(id_cablemodem).
"id_empleado" referencia a empleados(id_empleado).
Permite registrar entradas, salidas y bajas de cablemódems, identificando quién realizó la acción y sobre qué equipo.

# Vistas
En el proyecto se crearon varias vistas para facilitar el acceso y análisis de datos importantes dentro de la base de datos netflow. Estas vistas funcionan como consultas predefinidas que combinan información de diferentes tablas, permitiendo obtener datos relevantes de forma rápida y sencilla.

## Vista "vista_clientes_servicios"
Permite obtener un listado de clientes junto con los servicios y planes que han contratado. Esta vista integra datos personales de los clientes con la descripción de los servicios y las características de los planes asociados, como velocidad, unidad y precio.

## Vista "vista_stock_cablemodems"
Esta vista muestra el stock actual de los cablemodems, indicando su modelo, marca, número de serie y estado (disponible, asignado o dado de baja). Además, incluye información histórica sobre los movimientos realizados, tales como entradas, salidas o bajas, con fechas y detalles.

## Vista "vista_asignaciones_detalle"
Ofrece un resumen de las asignaciones de cablemodems a clientes, mostrando qué empleado realizó la entrega, el cliente beneficiario, el equipo asignado y la fecha de entrega. Facilita el seguimiento y control de los equipos en uso.

## Vista "vista_movimientos_stock"
Muestra los movimientos de stock realizados por cada empleado, detallando el tipo de movimiento (entrada, salida o baja), el equipo involucrado, la fecha y el detalle del movimiento. Esta vista ayuda a monitorear la actividad del personal respecto al inventario.

## Vista "vista_cablemodems_disponibles"
Esta vista muestra un resumen del stock de cablemodems junto con su estado actual. Permite consultar fácilmente qué equipos están disponibles, asignados o dados de baja.