CREATE DATABASE tonifica_tu_cuerpo;

USE tonifica_tu_cuerpo;

CREATE TABLE trabajadores (
    id_trabajadores INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    dni VARCHAR(9) NULL UNIQUE,
    nie VARCHAR(9) NULL UNIQUE,
    calle VARCHAR(50) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cod_postal INT NOT NULL,
    telefono INT NOT NULL,
    puesto_trabajo VARCHAR(45) NOT NULL,
    PRIMARY KEY(id_trabajadores),
    UNIQUE INDEX dni_UNIQUE(dni ASC) VISIBLE,
    UNIQUE INDEX nie_UNIQUE (nie ASC) VISIBLE
    
);

CREATE TABLE monitores(
    id_monitores INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    horario VARCHAR(45) NULL,
    especialidad VARCHAR(255) NOT NULL,
    id_trabajadores INT NOT NULL,
    PRIMARY KEY(id_monitores),
    CONSTRAINT id_monitores_FK,
    FOREIGN KEY (id_trabajadores) 
    REFERENCES tonifica_tu_cuerpo.trabajadores(id_trabajadores)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE socios(
    id_socios INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_suscripcion INT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    dni VARCHAR(9) NULL UNIQUE,
    nie VARCHAR(9) NULL UNIQUE,
    calle VARCHAR(50) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cod_postal INT NOT NULL,
    fecha_alta DATE NOT NULL,
    PRIMARY KEY (id_socios)
    UNIQUE INDEX dni_UNIQUE (dni ASC) VISIBLE,
    UNIQUE INDEX nie_UNIQUE (nie ASC) VISIBLE

);


CREATE TABLE telefonos(
    id_telefonos INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    telefonos VARCHAR(100) NOT NULL, 
    PRIMARY KEY (id_telefonos)

);

CREATE TABLE telefonos_socios(
    id_telefonos_socios INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_telefonos INT NOT NULL,
    id_socios INT NOT NULL,
    PRIMARY KEY (id_telefonos_socios, id_telefonos, id_socios)
    INDEX id_socios_PK_idx (id_socios ASC) VISIBLE,
    INDEX id_telefonos_PK_idx (id_telefonos ASC) VISIBLE,
    CONSTRAINT id_socios_PK
        FOREIGN KEY (id_socios)
        REFERENCES tonifica_tu_cuerpo.socios(id_socios)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
    CONSTRAINT id_telefonos_PK_idx  
        FOREIGN KEY (id_telefonos)
        REFERENCES tonifica_tu_cuerpo.telefonos(id_telefonos)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE suscripcion(
    id_suscripcion INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_suscripcion VARCHAR(45) NOT NULL,
    cuota DECIMAL(5,2) NOT NULL,
    fecha_baja DATE NULL,
    metodo_pago VARCHAR(45) NULL,
    PRIMARY KEY (id_suscripcion)
);





ALTER TABLE socios
ADD INDEX id_suscripcion_FK_idx (id_suscripcion ASC) VISIBLE;
ALTER TABLE socios
ADD CONSTRAINT id_suscripcion_FK 
    FOREIGN KEY (id_suscripcion)
    REFERENCES tonifica_tu_cuerpo.suscripcion(id_suscripcion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

CREATE TABLE actividades(
    id_actividades INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_aula INT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    fecha_actividad DATE NOT NULL,
    hora_inicio VARCHAR(20) NOT NULL,
    hora_fin VARCHAR(20) NULL,
    duracion VARCHAR(30) NULL,
    descripcion VARCHAR(100) NULL,
    grupo VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_actividades)
);

CREATE TABLE aulas(
    id_aulas INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    numero_aula INT NOT NULL ¿UNIQUE?,
    capacidad INT NOT NULL,
    PRIMARY KEY (id_aulas)
);

ALTER TABLE actividades
ADD INDEX id_aulas_FK_idx(id_aula ASC) VISIBLE;

ALTER TABLE actividades
ADD CONSTRAINT id_aulas_FK
    FOREIGN KEY (id_aulas)
    REFERENCES tonifica_tu_cuerpo.aulas(id_aulas)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION


CREATE TABLE actividades_socios(
    id_actividades_socios INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_Actividades INT PRIMARY KEY NOT NULL,
    id_socios INT PRIMARY KEY NOT NULL,
    apuntado_actividad VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_actividades_socios, id_actividades, id_socios),
    INDEX id_actividades_PK2_indx (id_actividades ASC) VISIBLE,
    INDEX id_socios_PK2_indx (id_socios ASC) VISIBLE,
    CONSTRAINT id_actividades 
        FOREIGN KEY (id_actividades)
        REFERENCES tonifica_tu_cuerpo.actividades(id_actividades)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
    CONSTRAINT id_socios 
        FOREIGN KEY (id_socios)
        REFERENCES tonifica_tu_cuerpo.socios(id_socios)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION

);

CREATE TABLE actividades_monitores (
  id_actividades_monitores INT NOT NULL AUTO_INCREMENT,
  id_actividad INT NOT NULL,
  id_monitor INT NOT NULL,
  PRIMARY KEY (id_actividades_monitores, id_actividad, id_monitor),
  INDEX id_actividad_PK3_idx (id_actividad ASC) VISIBLE,
  INDEX id_monitor_PK3_idx (id_monitor ASC) VISIBLE,
  CONSTRAINT id_actividad_PK3
    FOREIGN KEY (id_actividad)
    REFERENCES tonifica_tu_cuerpo.actividades (id_actividades)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT id_monitor_PK3
    FOREIGN KEY (id_monitor)
    REFERENCES tonifica_tu_cuerpo.monitores (id_monitores)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

INSERT INTO suscripcion(id_suscripcion, tipo_suscripcion, cuota, metodo_pago) VALUES(1, 'mensual', 35.95, 'transferencia');
INSERT INTO suscripcion(id_suscripcion, tipo_suscripcion, cuota, metodo_pago) VALUES('trimestral', 100.50, 'domiciliado');
INSERT INTO suscripcion(id_suscripcion, tipo_suscripcion, cuota, metodo_pago) VALUES('anual', 360, 'domiciliado');
INSERT INTO suscripcion(id_suscripcion, tipo_suscripcion, cuota, metodo_pago) VALUES('semestral', 210, 'tarjeta de credito');
INSERT INTO suscripcion(id_suscripcion, tipo_suscripcion, cuota, metodo_pago) VALUES('mensual', 35.95, 'tarjeta de credito');

INSERT INTO socios (id_socios, id_suscripcion, nombre, apellidos, dni, calle, numero, cod_postal, fecha_alta) VALUES (1, 1, 'armando', 'jaleo siempre', '75894567P', 'Perales', '12-pta 5', 54678, '2024-03-01');
INSERT INTO socios (id_suscripcion, nombre, apellidos, dni, calle, numero, cod_postal, fecha_alta) VALUES (2, 'lidia', 'garcia garcia', '45895684L', 'los santos', '3-a', 34567, '2024-02-01');
INSERT INTO socios (id_suscripcion, nombre, apellidos, nie, calle, numero, cod_postal, fecha_alta) VALUES (3, 'esperanza', 'este oeste', 'x4589654k', 'colon', '23-h', 46354, '2024-01-02');
INSERT INTO socios (id_suscripcion, nombre, apellidos, dni, calle, numero, cod_postal, `fecha_alta`) VALUES (4, 'eva', 'fina segura', '71526984x', 'la fuente', '2 bajo', 46354, '2024-02-12');
INSERT INTO socios (id_suscripcion, nombre, apellidos, nie, calle, numero, cod_postal, fecha_alta) VALUES (5, 'aitana', 'mola mucho', 'x7225465l', 'arcoiris', '21 puerta 7', 45168, '2024-03-29'); 

ALTER TABLE trabajadores CHANGE COLUMN numero numero VARCHAR(30) NOT NULL;


INSERT INTO trabajadores (id_trabajadores, nombre, apellidos, dni, email, calle, numero, cod_postal, telefono, puesto_trabajo) VALUES (1, 'maria ', 'lopez alvarez', '45789632s', 'maria@gmail.com', 'del mar', '12-4', 45123, 687954124, 'monitor');
INSERT INTO trabajadores (nombre, apellidos, nie, email, calle, numero, cod_postal, telefono, puesto_trabajo) 
VALUES ('lucas ', 'zambrano lopez', 'y5468975o', 'lucas@hotmail.com', 'del rio', '23-4-5', 45123, 687941526, 'monitor');
INSERT INTO trabajadores (nombre, apellidos, nie, email, calle, numero, cod_postal, telefono, puesto_trabajo) 
VALUES ('tania', 'martinez nuñez', 'x8574961r', 'taniamar@gmail.com', 'falsa', '32-1-1', 45287, 666555444, 'recepcionista');
INSERT INTO trabajadores (nombre, apellidos, dni, email, calle, numero, cod_postal, telefono, puesto_trabajo) 
VALUES ('manuel', 'gutierrez sanchez', '25478965k', 'manuelgusan@hotmail.com', 'oro', '6-b', 45987, 624785147, 'monitor');
INSERT INTO trabajadores (nombre, apellidos, dni, email, calle, numero, cod_postal, telefono, puesto_trabajo) 
VALUES ('david', 'oso pardo', '45896741u', 'davidos@monitores.es', 'plata', '45-esc a-pta 4', 45654, 722584964, 'monitor');INSERT INTO trabajadores (nombre, apellidos, nie, email, calle, numero, cod_postal, telefono, puesto_trabajo) 
VALUES ('nuria', 'esde alemania', 'x7892461d', 'nuriaesde@gmail.com', 'esmeralda', '3-1', 45217, 693274157, 'adiministrador');--INSERT INTO trabajadores (nombre, apellidos, dni, email, calle, numero, cod_postal, telefono, puesto_trabajo) 
--VALUES ('lucia ', 'navarro garcia', '45789632y', 'luciana@hotmail.com', 'piedra', '56-pta 3', 45217, 741852963, 'monitor');



INSERT INTO monitores(id_monitores, id_trabajadores, horario, especialida) VALUES(1, 1, 'mañana', 'spinning, gap, funcional, boxeo ');
INSERT INTO monitores(id_trabajadores, horario, especialida) VALUES(2, 'tarde',  'funcional, zumba, yoga, xcore, hit,pilates');
INSERT INTO monitores(id_trabajadores, horario, especialida) VALUES(4, 'tarde', 'crossfit, gap, spinning ,pesas, boxeo');
INSERT INTO monitores(id_trabajadores, horario, especialida) VALUES(5, 'mañana', 'zumba, yoga, xcore, crossfit, spinning, boxeo');

INSERT INTO telefonos(id_telefonos, telefonos) VALUES( '1', '654789145, 456879521');
INSERT INTO telefonos(telefonos) VALUES('963568974, 666578458');
INSERT INTO telefonos(telefonos) VALUES( '654895645');
INSERT INTO telefonos(telefonos) VALUES( '963548754, 621458965');
INSERT INTO telefonos(telefonos) VALUES( '72258963, 658741123');


INSERT INTO telefonos_socios (id_telefonos_socios, id_telefonos, id_socios)VALUES(1,1,1);
INSERT INTO telefonos_socios (id_telefonos, id_socios)VALUES(2,2);
INSERT INTO telefonos_socios (id_telefonos, id_socios)VALUES(3,3);
INSERT INTO telefonos_socios (id_telefonos, id_socios)VALUES(4,4);
INSERT INTO telefonos_socios (id_telefonos, id_socios)VALUES(5,5);

INSERT INTO aulas(id_aulas, numero_aula, capacidad) VALUES (1,1,100);
INSERT INTO aulas(numero_aula, capacidad) VALUES (2,80);
INSERT INTO aulas(numero_aula, capacidad) VALUES (3,150);
INSERT INTO aulas(numero_aula, capacidad) VALUES (4,100);
INSERT INTO aulas(numero_aula, capacidad) VALUES (5,75);
INSERT INTO aulas(numero_aula, capacidad) VALUES (6,80);
INSERT INTO aulas(numero_aula, capacidad) VALUES (7,50);
INSERT INTO aulas(numero_aula, capacidad) VALUES (8,150);


INSERT INTO actividades (id_actividades, id_aulas, nombre, fecha_actividad, hora_inicio, hora_fin, duracion, descripcion, grupo) VALUES (1, 1, 'spinning', '2024/03/29', '09:00:00', '09:45:00', '45 minutos', 'clase de spinning en el aula 1 ', 'iniciacion');
INSERT INTO actividades (id_aulas, nombre, fecha_actividad, hora_inicio, hora_fin, duracion, descripcion, grupo) VALUES (1, 'spinning', '2024/03/29', '11:00:00', '11:45:00', '45 minutos', 'clase de spinning en el aula 1', 'avanzados');
INSERT INTO actividades (id_aulas, nombre, fecha_actividad, hora_inicio, hora_fin, duracion, descripcion, grupo) VALUES (
2, 'boxeo', '2024/03/29', '10:00:00', '10:45:00', '45 minuto', 'clase de boxeo será necesario guantes', 'nivel medio');
INSERT INTO actividades (id_aulas, nombre, fecha_actividad, hora_inicio, hora_fin, duracion, descripcion, grupo) VALUES (3, 'yoga', '2024/03/29', '12:15:00', '13:00:00', '45 minutos', 'clase de yoga funcional', 'avanzado');
INSERT INTO actividades (id_aulas, nombre, fecha_actividad, hora_inicio, hora_fin, duracion, descripcion, grupo) VALUES (5, 'crossfit', '2024/03/29', '15:00:00', '16:00:00', '60 minutos', 'clase de crossfit necesario coger gomas elásticas', 'iniciacion');

INSERT INTO actividades (id_aulas, nombre, fecha_actividad, hora_inicio, hora_fin, duracion, descripcion, grupo) VALUES (8, 'zumba', '2024/03/29', '17:15:00', '18:00:00', '45 minutos', 'zumba a tope gama', 'avanzado');

INSERT INTO actividades (id_aulas, nombre, fecha_actividad, hora_inicio, hora_fin, duracion, descripcion, grupo) VALUES (1, 'spinning', '2024/03/29', '20:00:00', '20:45:00', '45 minutos', 'clase top de spinning', 'avanzado');    

INSERT INTO actividades_socios(id_actividades_socios, id_actividades, id_socios, apuntado_actividad) VALUES(1, 1, 5, 'si');
INSERT INTO actividades_socios(id_actividades, id_socios, apuntado_actividad) VALUES(3, 2, 'si');
INSERT INTO actividades_socios(id_actividades, id_socios, apuntado_actividad) VALUES(3, 2, 'si');
INSERT INTO actividades_socios(id_actividades, id_socios, apuntado_actividad) VALUES(3, 2, 'si');
INSERT INTO actividades_socios(id_actividades, id_socios, apuntado_actividad) VALUES(3, 2, 'si');
INSERT INTO actividades_socios(id_actividades, id_socios, apuntado_actividad) VALUES(7, 5, 'si');

INSERT INTO actividades_monitores(id_actividades_monitores, id_actividad, id_monitor) VALUES(1,1,1);
INSERT INTO actividades_monitores(id_actividad, id_monitor) VALUES(2,4);
INSERT INTO actividades_monitores(id_actividad, id_monitor) VALUES(3,1);
INSERT INTO actividades_monitores(id_actividad, id_monitor) VALUES(4,4);
INSERT INTO actividades_monitores(id_actividad, id_monitor) VALUES(3,1);
INSERT INTO actividades_monitores(id_actividad, id_monitor) VALUES(6,2);
INSERT INTO actividades_monitores(id_actividad, id_monitor) VALUES(7,3);



