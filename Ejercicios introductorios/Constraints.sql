/*
Las constraints son limitaciones impuestas por el administrador, al momento de incluir datos en una tabla
*/


CREATE USER ejemplo@localhost IDENTIFIED BY 'ejemplo';

CREATE DATABASE prueba; 

USE prueba; 

CREATE TABLE tablaprueba (
superprueba INT NOT NULL,
prueba INT NOT NULL,
PRIMARY KEY (prueba)
);

CREATE TABLE tablaprueba2 (

prueba2 INT NOT NULL,
PRIMARY KEY (prueba2)

);

ALTER TABLE tablaprueba ADD CONSTRAINT check_prueba CHECK (prueba>0);

-- CHECK -> PARA QUE "prueba" sea MAYOR que 0 SIEMPRE

ALTER TABLE tablaprueba2 ADD CONSTRAINT FK_prueba FOREIGN KEY (prueba2) REFERENCES tablaprueba (prueba);

-- FOREIGN KEY ... REFERENCES para añadir CLAVE FORÁNEA a una tabla.

ALTER TABLE tablaprueba ADD FOREIGN KEY (prueba) REFERENCES tablaprueba (superprueba);



