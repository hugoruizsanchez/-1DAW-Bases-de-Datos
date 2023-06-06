CREATE DATABASE holamundo; -- Creación de la base de datos en la que operaremos. 
USE holamundo; -- La base de datos que estamos usando es holamundo, la misma que hemos creado. 
show databases;  -- Este comando nos permitirá ver las tablas creadas.

CREATE TABLE animales (
	id int,
	tipo varchar (255),
    estado varchar (255),
    PRIMARY KEY (id)
);

-- INSERT INTO animales (tipo, estado) VALUES ('Cerdo','Feliz'); -- Insertamos los valores con la sintaxis correspondiente -> insert tabla (atributo) VALUES (valor)

ALTER TABLE animales MODIFY COLUMN id int auto_increment; -- Modificación de la tabla para que el componente ID sea autoincremental respecto a la cantidad de registros. 

SHOW CREATE TABLE animales;

CREATE TABLE `animales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO animales (tipo, estado) VALUES ('Cerdo','Feliz'); -- Creamos un registro con las características establecidas. 
INSERT INTO animales (tipo, estado) VALUES ('Dragón','Feliz'); -- Creamos un registro con las características establecidas. 
INSERT INTO animales (tipo, estado) VALUES ('Felipe','Triste'); -- Creamos un registro con las características establecidas. 

SELECT * FROM animales; -- Ver la tabla. 

SELECT * FROM animales WHERE id =1; -- Solo toma el registro 1. 

SELECT * FROM animales WHERE estado ='feliz'; -- Solo toma registros con el dato de estado = feliz.

SELECT * FROM animales WHERE estado ='feliz' AND tipo="Cerdo"; -- toma registros con el dato de estado = feliz y tipo=cerdo.

UPDATE animales SET estado = 'Titán' where id =5; -- Actualizamos el estado (felipe -> triste) a (felipe -> titán) configurandolo en la id 5. 

DELETE from animales where id='2' ; -- ESTE COMANDO ARROJA UN ERROR: 02:49:54	DELETE from animales where estado='feliz'	Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.000 sec
-- > El error significa que: existe un método de seguridad que impide el borrado de registros que no venga acompañado por una ID. 
UPDATE animales SET estado = 'Fracasado' where tipo='Titán';
-- > Esto también arroja error

