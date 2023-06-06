CREATE DATABASE clase;
USE clase;

-- APUNTES: LA EXPRESIÓN SELECT. 

-- Creación de una tabla de ejemplo para la realización de las pruebas. 

CREATE TABLE tabla (
numero int not null auto_increment,
letra char,
PRIMARY KEY (numero)
);

-- Introducimos algunos valores de prueba a esta tabla. 

INSERT INTO tabla (letra) VALUES ("a");
INSERT INTO tabla (letra) VALUES ("b");
INSERT INTO tabla (letra) VALUES ("c");

-- Muestreo de la tabla, ponemos un asterisco para abarcar laa totalidad de la tabla. 

SELECT * FROM tabla;

-- Muestreo de la tabla, ahora especificando la columna que queremos ver. 

SELECT numero FROM tabla;
SELECT letra FROM tabla;
SELECT numero, letra FROM tabla;

-- La expresión SELECT con la condición "DISTINCT" evita la redundancia de los datos
-- (en este caso, solo aparecen "a", "b", y "c" porque son los unicos datos introducidos.

SELECT DISTINCT letra FROM tabla;

-- La expresión SELECT puede configurarse para mostrar determinados tipos de datos, a saber:

SELECT * FROM tabla WHERE letra="a"; -- Mostramos solo los registros con este dato. 
SELECT * FROM tabla WHERE letra="b";
SELECT * FROM tabla WHERE letra="c";

-- También puede usarse, incluso, para realizar operaciones lógicas.

SELECT 2+3;
SELECT (2+1)<(3*2); -- 0 (falso) 1 (verdadero)
SELECT (9>5) AND (7>5);

/* OPERADORES LÓGICOS DE MYSQL
=	Igual que
>	Mayor que
<	Menor que
>=	Mayor o igual que
<=	Menor o igual que
!=	Diferente de
Between	Rango
In	Valores que Coinciden en una Lista
AND
OR 
NOT

*/

-- EJERCICIO PROPUESTO: en base a la tabla propuesta 

CREATE TABLE productos (
	idProducto int AUTO_INCREMENT PRIMARY KEY,
	NomProducto VARCHAR(50) not null,
	tipo VARCHAR(20) not null,
	precio DECIMAL(5,2)
);

INSERT INTO productos (nomProducto, tipo, precio) values ("Lenguaje SQL", "Libro", 21.95);
INSERT INTO productos (nomProducto, tipo, precio) values ("Bases de datos", "Libro", 20.95);
INSERT INTO productos (nomProducto, tipo, precio) values ("Administración de bases de datos", "Libro", 24.95);
INSERT INTO productos (nomProducto, tipo, precio) values ("PC Fácil", "Publicación", 4.95);
INSERT INTO productos (nomProducto, tipo, precio) values ("Actualidad científica", "Publicación", 5.95);

-- Proyección general de la tabla.

SELECT * FROM productos;

-- Proyección de dos columnas de la base de datos. 

SELECT NomProducto, tipo FROM productos;

-- Expresión "concat" que nos permite  ilustrar en una cadena de texto la tabla. 
-- "as" es el alias, el título que le fijamos, 

SELECT concat (NomProducto, " - - - - > ", tipo) as Producto FROM productos;

-- Nuevamente, ilustramos una nueva tabla, ahora expresando los precios sin repetición

SELECT concat (NomProducto, "  -> ", precio*0.7) as "Producto con 70% de descuento" FROM productos;

-- O bien directamente desde la función SELECT sin necesidad de un concat. 

SELECT precio*0.7 from productos; 

-- Mostramos únicamente los productos libro

SELECT * FROM productos WHERE Tipo = "Libro";

-- Operador IN -> Muestra los valores exactos indicados entre paréntesis, en base a una columna. 

SELECT * FROM productos WHERE precio IN (1.95, 2.95, 4.95, 5.95);

SELECT * FROM productos WHERE precio = 4.95 OR precio = 5.95; -- Esta sentencia es exactamente igual. 

-- Operador BETWEEN AND (Entre un valor y otro). Muestra un rango entre dos valores. 

SELECT * FROM productos WHERE precio BETWEEN 5 AND 21;

SELECT * FROM productos WHERE precio>=5 AND precio<=21; -- Esta sentencia es exactamente igual. 

-- Operador: filtro TEST nulo. 

SELECT * FROM productos WHERE precio IS NULL; -- Valores nulos de precio. 

SELECT * FROM productos WHERE precio IS NOT NULL; -- Valores NO nulos de precio. 


-- 	Operador LIKE : buscar una palabra para encontrar la semejanza en la columna indicada
-- pej: dame todos los productos de la tabla productos donde aparezca la palabra "bases".
-- cada "%" representa líneas de texto que la preceden y que la proceden. ...bases...
-- un "_" representa un solo caracter... _bases_  

SELECT * FROM productos WHERE NomProducto LIKE "%bases%";
SELECT * FROM productos WHERE NomProducto LIKE "__s%"; -- En BASes
													  --     __s% -- > por eso encuentra solo "BASES de datos"
													
-- Operador LIMIT : solo muestra las filas especificadas. 

SELECT * FROM productos WHERE tipo = "Libro"  LIMIT 2;

-- Operador ORDER BY: permitir ordenar registros devueltos.alter

SELECT * FROM productos WHERE tipo = "Libro" ORDER BY precio; -- Las ordena por precio ( por defecto ascendente) 
SELECT * FROM productos WHERE tipo = "Libro" ORDER BY precio ASC; -- Las ordena por precio ascendente
SELECT * FROM productos WHERE tipo = "Libro" ORDER BY precio DESC; -- Las orderna por precio descendiente
SELECT * FROM productos WHERE tipo = "Libro" ORDER BY -precio; -- EL DESC puede hacerse también así. 
SELECT * FROM productos WHERE tipo = "Libro" ORDER BY NomProducto ASC; -- Los ordena alfabéticamente. 
SELECT * FROM productos WHERE tipo = "Libro" ORDER BY CHAR_length(NomProducto) ASC; -- Los ordena segun longitud
SELECT * FROM productos WHERE tipo = "Libro" ORDER BY CHAR_length(NomProducto) DESC;


-- Operador de ordenación por varios campos. 
-- EL tipo estará ordenado en orden inverso al alfabético. 
-- EL precio estará ordenado en orden inverso al alfabético. 

SELECT * FROM productos ORDER BY tipo DESC, precio ASC; 

-- Operador CONSULTAS DE RESUMEN : generar consultas, resumen cierta información (en este caso, el conjunto de registros) 
/*
SUM -> suma valores indicados
AVG  -> media de los valores indicados
MIN -> proyecta el valor minimo de los indicados
MAX  -> proyecta el valor maximo. 
COUNT -> proyecta el total del conjunto de los registros. 
https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html
*/

SELECT count(*) FROM productos;
SELECT count(precio) FROM productos;
Select sum(precio) FROM productos;
Select avg(precio) FROM productos;
Select min(precio) FROM productos;
Select max(precio) FROM productos;

-- Operador GROUP BY: ver agrupaciones de registros. 
-- Visualizamos la columna "tipo" , contando todos los valores de la tabla, agrupados en tipo. 

SELECT tipo FROM productos GROUP BY tipo;
SELECT precio FROM productos GROUP BY precio;
SELECT tipo, count(*) FROM productos GROUP BY tipo; --  Nos muestra el conteo de todos los productos en base a tipo.
SELECT tipo, avg(precio) FROM productos GROUP BY tipo; -- Nos muestra la media de cada uno de los productos.


-- Operador HAVING: se complementan con el GROUP BY

SELECT   




	 /*
_ _ /_ _  S
   /      D
  /       G
*/ 

	