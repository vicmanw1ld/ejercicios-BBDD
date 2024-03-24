-- Sentencias SQL para la creación de una bbdd y sentencias de búsqueda
-- realización del ejercicio del 3er trimestre

-- crea la base de datos
CREATE DATABASE empresa;

-- Que bbdd quieres usar:
USE empresa;

-- Crea una tabla

CREATE TABLE clientes(
    id_cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    dni VARCHAR(9) NOT NULL UNIQUE,
    nombre_empresa VARCHAR(50) NOT NULL
        
);




