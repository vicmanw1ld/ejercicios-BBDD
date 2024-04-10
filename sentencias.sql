-- Sentencias SQL para la creación de una bbdd y sentencias de búsqueda
-- realización del ejercicio del 3er trimestre

-- crea la base de datos
CREATE DATABASE empresa_ventas;

-- Que bbdd quieres usar:
USE empresa;

-- Crea una tabla, ina PK id_cliente, el dni es UNIQUE así que hay que añadir la última frase

CREATE TABLE clientes(
    id_clientes INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    dni VARCHAR(9) NOT NULL UNIQUE,
    nombre_empresa VARCHAR(50) NOT NULL,
    id_tienda INT NOT NULL,
    PRIMARY KEY (id_cliente),
    UNIQUE INDEX dni_UNIQUE (dni ASC) VISIBLE);

-- Creo la relación CLIENTES-TIENDAS que es de N:1 id_tienda FK
ALTER TABLE clientes ADD INDEX id_tienda_FK_idx (id_tienda ASC) VISIBLE;
ALTER TABLE clientes ADD CONSTRAINT id_tienda_FK 
    FOREIGN KEY (id_tienda)
    REFERENCES empresa_ventas.clientes(id_tienda)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- creo la tabla DATOS_CLIENTES para evitar la redundancia de datos
CREATE TABLE datos_clientes (
  id_datos_clientes INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  direccion VARCHAR(100) NULL,
  telefono INT NULL,
  PRIMARY KEY (`id_datos_clientes`),
  INDEX `id_cliente_FK_datos_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `id_cliente_FK_datos`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `empresa_ventas`.`clientes` (`id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- booramos los datos de clientes
ALTER TABLE clientes DROP COLUMN telefono, DROP COLUMN DIRECCION;

-- Se me ha olvidado una columna, la FK de id_tienda

ALTER TABLE clientes ADD COLUMN id_tienda INT NULL AFTER nombre_empresa;

-- Creamos la tabla encargados
CREATE TABLE encargados(
    id_encargado INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    dni VARCHAR(9) NOT NULL UNIQUE,
    id_tienda INT NOT NULL,
    PRIMARY KEY (id_encargado))

-- Añado una columna dni que se me pasó
ALTER TABLE encargados ADD COLUMN dni VARCHAR(9) NOT NULL AFTER direccion,
ADD UNIQUE INDEX dni.UNIQUE (dni ASC) VISIBLE;

-- Creo la relación ENCARGADOS-TIENDAS que es de N:1 id_tienda_FK2

ALTER TABLE encargados ADD INDEX id_tienda_FK2_idx (id_tienda ASC) VISIBLE;
ALTER TABLE encargados ADD CONSTRAINT id_tienda_FK2
    FOREIGN KEY (id_tienda)
    REFERENCES empresa_ventas.tiendas (id_tienda)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- creamos la tabla tiendas
CREATE TABLE tiendas(
    id_tienda INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    propietario VARCHAR(50) NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    ciudad VARCHAR(45) NOT NULL, 
    nif VARCHAR(10) UNIQUE NOT NULL,
    PRIMARY KEY (id_tienda),
    UNIQUE INDEX nif_UNIQUE (nif ASC) VISIBLE);

-- creamos la tabla proveedores
CREATE TABLE proveedores(
    id_proveedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    empresa VARCHAR(45) NOT NULL,
    propietario VARCHAR(45) NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    cif VARCHAR(10) NOT NULL,
    id_tienda INT NOT NULL,
    PRIMARY KEY(id_proveedor));


-- Creo la relación PROVEEDORES-TIENDAS que es de N:1 id_tienda_FK3
ALTER TABLE proveedores ADD INDEX id_tienda_FK3_idx (id_tienda ASC) VISIBLE;
ALTER TABLE proveedores ADD CONSTRAINT id_tienda_FK3
    FOREIGN KEY (id_tienda)
    REFERENCES empresa_ventas.tiendas(id_tienda)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


-- creamos la tabla auxiliar ventas, con 3 PK 
CREATE TABLE ventas(
        id_venta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        id_encargado INT PRIMARY KEY NOT NULL,
        id_clientes INT PRIMARY KEY NOT NULL,
        articulo VARCHAR(255) NOT NULL,
        cantidad INT NOT NULL,
        precio DECIMAL(10,2) NOT NULL,
        fecha DATE NOT NULL,
        PRIMARY KEY (id_venta, id_encargado, id_clientes),
        INDEX id_encargado_PK_idx (id_encargado ASC) VISIBLE,
        INDEX id_cliente_PK_idx (id_clientes ASC) VISIBLE,
        CONSTRAINT id_encargado_PK
            FOREIGN KEY(id_encargado)
            REFERENCES empresa_ventas.encargados(id_encargado)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT id_clientes_PK
            FOREIGN KEY(id_clientes)
            REFERENCES empresa_ventas.clientes(id_clientes)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION);

-- Tengo que cambiar una columna a null
ALTER TABLE clientes CHANGE COLUMN nombre_empresa nombre_empresa VARCHAR(45) NULL;

-- insert into tiendas
INSERT INTO tiendas(id_tienda, propietario, telefono,direccion, ciudad, nif ) VALUES(
    1, 'juan martinez', 634987654, 'despiste, 12', 'valladolid', 'b2198765g')
INSERT INTO tiendas (propietario, telefono, direccion, ciudad, nif) VALUES (
    'andres garcia', 612345678, 'cuesta, 34', 'avila', 'v3456789y');
INSERT INTO tiendas (propietario, telefono, direccion, ciudad, nif) VALUES (
    'manuela perez', 689654312, 'goya, 3', 'madrid', 't9012345g');
INSERT INTO tiendas (propietario, telefono, direccion, ciudad, nif) VALUES (
    'sara gutierrez ', 643567890, 'manuel becerra, 56', 'madrid', 'r8765432q');

-- INSERT INTO encargados

INSERT INTO encargados (id_encargado, nombre, apellidos, telefono, direccion, dni, id_tienda) VALUES (
    1, 'antonio ', 'cruzado munoz', 620849487, 'c/ yedra 14', '07486421z', 2);
INSERT INTO encargados (id_encargado, nombre, apellidos, telefono, direccion, dni, id_tienda) VALUES (
    'mercedes', 'lopez jimenez', 654329087, 'c/ san pablo 4', '09486456w', 2);
INSERT INTO encargados (id_encargado, nombre, apellidos, telefono, direccion, dni, id_tienda) VALUES (
    'Alfonsina', 'reneses carreño', 625436789, 'c/ hueco 44', '08488976q', 4);
INSERT INTO encargados (id_encargado, nombre, apellidos, telefono, direccion, dni, id_tienda) VALUES (
    'francisco', 'lopez martinez', 620876543, 'c/ vicente 8', '12234567r', 4);

-- INSERT INTO clientes
INSERT INTO clientes (id_clientes, nombre, apellidos, dni, nombre_empresa, id_tienda) VALUES (
    1, 'francisco', 'aparicio juarez', 07123456y, 'aparicio s.l', 2);
INSERT INTO clientes (id_clientes, nombre, apellidos, dni, id_tienda) VALUES (
    2, 'maria ', 'bravo osorio', '12987600v', 4);
INSERT INTO clientes (nombre, apellidos, dni, id_tienda) VALUES (
    'luis', 'rodriguez sanz', '34216789x', 4);

-- INSERT INTO datos_clientes

INSERT INTO datos_clientes (id_datos_clientes, id_cliente, direccion, telefono) VALUES (
    1, 1, 'antonio lopez, 12 madrid', 982393212);
INSERT INTO datos_clientes (id_datos_clientes, id_cliente, direccion) VALUES (
    2, 1, 'opañel, 1 madrid');
INSERT INTO datos_clientes (id_cliente, direccion`, telefono) VALUES (
    2, 'lluvia, 3, madrid', 931237789); 
INSERT INTO datos_clientes (id_cliente, direccion`, telefono) VALUES (
    3, 'ponzano 3, madrid', 936574487);

INSERT INTO proveedores (id_proveedor, empresa, propietario, telefono, direccion, cif, id_tienda) VALUES (1, 'chuches s.a', 'juan perez ', '982273984', 'rio rosas, 1 madrid', 'B9876123T', 2);
INSERT INTO `empresa_ventas`.`proveedores` (`empresa`, `propietario`, `telefono`, `direccion`, `cif`, `id_tienda`) VALUES ('bebidas s.l', 'luis jimenez', '982453984', 'madrid rio, 6 madrid ', 'R1234567C', '3');
INSERT INTO `empresa_ventas`.`proveedores` (`empresa`, `propietario`, `telefono`, `direccion`, `cif`, `id_tienda`) VALUES ('textil s.l ', 'maria perez', '982273943', 'serrano, 3 madrid', 'T2345678Q', '4');
INSERT INTO `empresa_ventas`.`proveedores` (`empresa`, `propietario`, `telefono`, `direccion`, `cif`, `id_tienda`) VALUES ('alimentacion s.a ', 'luisa morales', '982273912', 'almodovar,  madrid', 'C9876543A', '1');


-- debido a la redundancia de datos que tenía en clientes (se repetia el cliente con una calle distinta),
-- He tenido que reducir el número de clientes es por lo que el que hay que introducir como número 4, 
-- lo he puesto como el 3.

INSERT INTO ventas (id_venta, id_encargado, id_clientes, articulo, cantidad, precio, fecha) VALUES ('1', '2', '1', 'raton ', '1', '12.12', '2023-12-12');


INSERT INTO `empresa_ventas`.`ventas` (`id_venta`, `id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('1', '2', '1', 'raton ', '1', '12.12', '2023-12-12');
INSERT INTO `empresa_ventas`.`ventas` (`id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('2', '3', 'teclado', '1', '14.32', '2023-12-09');
INSERT INTO `empresa_ventas`.`ventas` (`id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('2', '2', 'cable usb', '5', '32.2', '2017-11-25');
INSERT INTO `empresa_ventas`.`ventas` (`id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('3', '3', 'monitor', '1', '121.12', '2022-05-08');
INSERT INTO `empresa_ventas`.`ventas` (`id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('3', '1', 'disco ssd', '3', '105.23', '2012-06-09');
INSERT INTO `empresa_ventas`.`ventas` (`id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('3', '1', 'ddr5-3200mhz', '2', '164.45', '2017-11-25');
INSERT INTO `empresa_ventas`.`ventas` (`id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('1', '2', 'hub tipo c', '1', '14.78', '2023-12-12');
INSERT INTO `empresa_ventas`.`ventas` (`id_encargado`, `id_clientes`, `articulo`, `cantidad`, `precio`, `fecha`) VALUES ('1', '3', 'cat5e [m]', '50', '11', '2024-03-12');


--CONSULTAS
-- Lista de fechas e importes de las facturas, junto con el nombre y el teléfono del cliente asociado.

SELECT fecha, precio, CONCAT (c.nombre,' ', c.apellidos) AS cliente, datos_clientes.telefono FROM ventas INNER JOIN clientes c ON c.id_clientes=ventas.id_clientes INNER JOIN datos_clientes ON datos_clientes.id_cliente=c.id_clientes ORDER BY ventas.fecha ASC ;
-- 2012-06-09	105.23	francisco aparicio juarez	982393212
-- 2012-06-09	105.23	francisco aparicio juarez	
-- 2017-11-25	164.45	francisco aparicio juarez	982393212
-- 2017-11-25	164.45	francisco aparicio juarez	
-- 2017-11-25	32.20	maria bravo osorio	931237789
-- 2022-05-08	121.12	luis rodriguez sanz	936574487
-- 2023-12-09	14.32	luis rodriguez sanz	936574487
-- 2023-12-12	12.12	francisco aparicio juarez	982393212
-- 2023-12-12	12.12	francisco aparicio juarez	
-- 2023-12-12	14.78	maria bravo osorio	931237789
-- 2024-03-12	11.00	luis rodriguez sanz	936574487

-- Las distintas cantidades de material comprado.
SELECT articulo, cantidad FROM ventas ORDER BY cantidad ASC;

-- raton 	1
-- teclado	1
-- monitor	1
-- hub tipo c	1
-- ddr5-3200mhz	2
-- disco ssd	3
-- cable usb	5
-- cat5e [m]	50

-- Muestra la lista de todas las ventas desde el día 01/01/2022.
SELECT fecha FROM ventas WHERE fecha >= '2022-01-01' ORDER BY fecha ASC; 

-- 2022-05-08
-- 2023-12-09
-- 2023-12-12
-- 2023-12-12
-- 2024-03-12

-- Muestra todos los encargados que tengan el apellido López, quitando todos los valores o campos de identificación.
SELECT CONCAT(nombre,' ', apellidos) AS nombre FROM encargados WHERE apellidos LIKE '%lopez%';

-- mercedes lopez jimenez
-- francisco lopez martinez

-- Suma del importe de todas las facturas del día 25/11/2017.
SELECT SUM(precio) AS importe_total FROM ventas where fecha='2017-11-25';
-- 196.65

-- Lista de los nombres de los clientes y el nombre del artículo que ha comprado.
SELECT CONCAT(nombre,' ', apellidos) AS CLIENTE, ventas.articulo FROM clientes INNER JOIN ventas ON clientes.id_clientes = ventas.id_clientes;

-- francisco aparicio juarez	raton 
-- francisco aparicio juarez	disco ssd
-- francisco aparicio juarez	ddr5-3200mhz
-- maria  bravo osorio	cable usb
-- maria  bravo osorio	hub tipo c
-- luis rodriguez sanz	teclado
-- luis rodriguez sanz	monitor
-- luis rodriguez sanz	cat5e [m]

-- Lista donde aparezca, por cada cliente, la cantidad de compras realizadas.
SELECT CONCAT(nombre, ' ', apellidos) AS CLIENTE, COUNT(ventas.cantidad) AS CANTIDAD_COMPRAS FROM clientes INNER JOIN ventas ON clientes.id_clientes=ventas.id_clientes GROUP BY CLIENTE;
-- francisco aparicio juarez	3
-- maria  bravo osorio	2
-- luis rodriguez sanz	3


