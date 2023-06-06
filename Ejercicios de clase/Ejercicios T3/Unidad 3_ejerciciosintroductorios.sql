
-- 3.1 
USE fabricadejuguetes;
CREATE TABLE planta (
color varchar (25) not null,
superficie int not null,
PRIMARY KEY (color)

);

SELECT * FROM planta;

-- 3.2 

CREATE TABLE proceso (

gradocomplejidad int not null, 
nombre varchar  (25) not null,
PRIMARY KEY (nombre)
);

SELECT * FROM proceso;

-- 3.3 

CREATE TABLE plantasprocesos (
colorplanta varchar (25) not null,
nombreproceso varchar (25) not null,
foreign key (nombreproceso) references proceso(nombre),
foreign key (colorplanta) references planta(color)

);

SELECT * FROM plantasprocesos;

-- 3.4

SELECT * FROM planta, proceso, plantasprocesos; -- Visualizar todas las tablas creadas. 

-- 3.5 

ALTER TABLE planta ADD telefono int; -- Añadir teléfono a la planta. 

-- 3.6 

ALTER TABLE planta ADD nombre varchar (50); -- Añadimos la columna. 
ALTER TABLE planta MODIFY COLUMN telefono int AFTER nombre; -- Movemos la columna a la telefono despues de la de nombre. 

-- 3.7 
-- Para hacer que un dato NO se repita, devemos convertirlo en un UNIQUE KEY.

ALTER TABLE planta ADD UNIQUE KEY (telefono);
	
-- 3.8

ALTER TABLE planta ADD nomcortoplanta varchar (10); 
ALTER TABLE planta MODIFY COLUMN nomcortoplanta varchar (10) FIRST; -- Movemos la columna a la telefono despues de la de nombre. 

SELECT * FROM planta;

-- 3.9 

ALTER TABLE planta CHANGE `nomcortoplanta` `nomlargoplanta` varchar(50) NOT NULL; -- Modificar el nombre y el tipo de dato. 
ALTER TABLE planta MODIFY nomlargoplanta varchar (50) NOT NULL; -- Esto porque no lo modificamos previamente, 
ALTER TABLE planta MODIFY COLUMN nomlargoplanta varchar (50) AFTER superficie;

-- 3.10 

ALTER TABLE planta 	MODIFY nomlargoplanta varchar (40) NULL;

-- 3.11

ALTER TABLE planta DROP COLUMN nomlargoplanta; 
SELECT * FROM planta;

-- 3.12

RENAME TABLE planta to plantasnueva;
SELECT * FROM plantasnueva;

-- 3.13 
 
ALTER TABLE plantasprocesos DROP FOREIGN KEY plantasprocesos_ibfk_2; 
SELECT * FROM plantasprocesos; 

-- 3.14

DROP TABLE plantasnueva;