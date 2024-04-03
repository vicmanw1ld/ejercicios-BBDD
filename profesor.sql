-- crea la base de datos
CREATE DATABASE campo_deportivo;

USE campo_deportivo;

-- Crea una tabla, ina PK id_cliente, el dni es UNIQUE así que hay que añadir la última frase o
-- sE pone en la misma retriccion de dni
/* CREATE TABLE nombre_tabla(
   nombre_columna1 // Tipo de dato // restriccion,
   nombre_columna2 // Tipo de dato // restriccion 
   PRIMARY KEY nombre_columna1
   UNIQUE nombre_columna2
);
Las restricciones se pueden poner al final o al lado del atributo   
    
*/
-- FOREIGN KEY
CREATE TABLE equipos(
    id_equipo INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    ciudad VARCHAR(100), 
    fecha_creacion DATETIME
);

CREATE TABLE atlelas(
    id_atleta INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    dni VARCHAR(9) NOT NULL,
    edad INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    id_equipos INT, 
    PRIMARY KEY id_atleta,
    UNIQUE dni
    CONSTRAINT id_equipos_FK FOREIGN KEY (id_equipos) REFERENCES equipos(id_equipo)
);

-- CONSTRAINT = RESTRICCION
-- W3SCHOOL Y STACKOVERFLOW

-- borrar una tabla
DROP TABLE atletas;

-- modificar / añadir una tabla creada nos ayudamos de:
-- ALTER TABLE nombre_tabla ADD, RENAME, MODIFY, DROP columna_tipo
-- ALTER TABLE modificamos los elementos de una tabla
ALTER TABLE atletas ADD email VARCHAR(50);
ALTER TABLE atlelas RENAME COLUMN apellidos TO apellido;
ALTER TABLE atletas MODIFY COLUMN nombre VARCHAR(30);
ALTER TABLE atletas DROP COLUMN fecha_inscripcion;
ALTER TABLE atletas MODIFY COLUMN dni INT;

-- EMAIL va a ser UNICO vamos a crear una restriccion, pueden ser de las dos formas
ALTER TABLE atletas ADD CONSTRAINT uni_email UNIQUE (email);
ALTER TABLE atletas ADD UNIQUE (email);

-- CHECK comprueba un dato 



-- RENAME TABLE, renombrar el nombre de la BBDD
RENAME TABLE atletas TO atleta;