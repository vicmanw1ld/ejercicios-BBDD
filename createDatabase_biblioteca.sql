CREATE DATABASE biblioteca;

USE biblioteca;

CREATE TABLE usuarios(
id_usuarios INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
telefono INT, 
direccion VARCHAR(100) NOT NULL,
PRIMARY KEY(id_usuarios)
);

CREATE TABLE autores(
id_autores INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (id_autores));

CREATE TABLE libros(
id_libros INT NOT NULL AUTO_INCREMENT,
codigo INT NOT NULL,
titulo VARCHAR(50) NOT NULL,
editorial VARCHAR(50) NOT NULL,
isbn INT NOT NULL,
PRIMARY KEY (id_libros)
);

CREATE TABLE autores_libros(
id_autores_libros INT NOT NULL AUTO_INCREMENT,
id_autores INT NOT NULL,
id_libros INT NOT NULL,
PRIMARY KEY(id_autores_libros, id_autores, id_libros),
CONSTRAINT id_autores_PK
FOREIGN KEY (id_autores)
REFERENCES autores(id_autores)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT id_libros_PK
FOREIGN KEY (id_libros)
REFERENCES libros(id_libros)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);

CREATE TABLE ejemplares(
id_ejemplares INT NOT NULL AUTO_INCREMENT,
id_libros INT NOT NULL, 
id_usuarios INT NOT NULL,
codigo INT NOT NULL,
ubicacion VARCHAR(30) NOT NULL,
PRIMARY KEY(id_ejemplares),
CONSTRAINT id_libros_FK
FOREIGN KEY (id_libros)
REFERENCES libros(id_libros)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT id_usuarios_FK
FOREIGN KEY (id_usuarios)
REFERENCES usuarios(id_usuarios)
ON DELETE NO ACTION 
ON UPDATE NO ACTION
);

INSERT INTO autores(id_autores, nombre) VALUES (1, 'Ricardo Herrero' );
INSERT INTO libros(id_libros, codigo, titulo, editorial, isbn) VALUES (1, 1234, 'La paya', 'Tus libros', 321);
INSERT INTO autores_libros(id_autores_libros, id_autores, id_libros) VALUES (1, 1, 1);
INSERT INTO usuarios(id_usuarios, nombre, telefono, direccion) VALUES(1, 'victor', 654321234, 'calle falsa 123');
INSERT INTO ejemplares(id_ejemplares, id_libros, id_usuarios, codigo, ubicacion) VALUES (1,1,1, 234, 'estanteria 7A');


ALTER TABLE autores ADD COLUMN apellidos VARCHAR(45) NULL;
UPDATE autores SET nombre = 'Ricardo', apellidos = 'herrero mendoza' WHERE (`id_autores` = '1');