-- -------------------------------------------
--  CÓMO REALIZAR UN PROCEDIMIENTO          -- 
-- -------------------------------------------
--> Los procedimientos se ejecutan, por lo general no devuelven datos.  

-- Primer ejemplo: 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS listar_productos$$ 
CREATE PROCEDURE listar_productos(IN gama VARCHAR(50)) -- PARÁMETRO DE ENTRADA ENTRE PARÉNTESIS
BEGIN -- INICIO DEL PROGRAMA
	SELECT * FROM producto WHERE producto.gama = gama;
END -- FIN DEL PROGRAMA
$$

-- Llamada del procedimiento: 

CALL listar_productos("Herramientas"); -- Llamar a la ejecución del procedimiento. 

-- Segundo ejemplo:  contar_productos que reciba como entrada el nombre de la gama y devuelva el número de productos que existen dentro de esa gama. Resuelva el ejercicio de dos formas distintas, utilizando SET y SELECT ... INTO.

-- // Procedimiento que devuelve un SELECT. 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS contar_productos$$
CREATE PROCEDURE contar_productos(IN gama VARCHAR(50)) 
BEGIN 
	SELECT COUNT(*) from producto where producto.gama=gama; 
END
$$

CALL contar_productos("Herramientas"); 

-- // Tercer ejemplo: Procedimiento que almacena el valor del SELECT en una variable y devuelve el valor de la variable. 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS contar_productos_variable$$ 
CREATE PROCEDURE contar_productos_variable(IN gama VARCHAR(50), OUT total INT) -- Se indica la entrada de datos, y LA SALIDA que es donde se cargará la información procesada  
BEGIN
	SET total = (SELECT COUNT(*) from producto where producto.gama=gama); -- Redirige la información del SELECT a la variable OUTPUT "total" 
	/* (Alternativa:)
	SELECT COUNT(*) into total from producto where producto.gama=gama
	*/
END 
$$

CALL contar_productos_variable("Herramientas", @total);
SELECT @total;

-- Cuarto ejemplo: Escribe un procedimiento que se llame calcular_max_min_media, que reciba como parámetro de entrada el nombre de la gama de un producto y devuelva como salida tres parámetros. El precio máximo, el precio mínimo y la media de los productos que existen en esa gama. Resuelva el ejercicio de dos formas distintas, utilizando SET y SELECT ... INTO.

DELIMITER $$ 
DROP PROCEDURE IF EXISTS calcular_max_min_media;
CREATE PROCEDURE calcular_max_min_media (IN gama VARCHAR(50), OUT precio_maximo INT, OUT precio_minimo INT, OUT media INT) 
BEGIN
	SET precio_maximo = (SELECT MAX(precio_venta) from producto); 
	SET precio_minimo = (SELECT MIN(precio_venta) from producto); 
	SET media = (SELECT AVG(precio_venta) from producto); 
END 
$$

CALL calcular_max_min_media ("Herramientas", @maximo, @minimo, @media); 
SELECT @maximo, @minimo, @media; 

-- -------------------------------------------
--  CÓMO REALIZAR UNA UNA FUNCIÓN           -- 
-- -------------------------------------------
-- > Las funciones se comportan como una variable que ejecuta un procedimiento y devuelve un dato. 

-- Escriba una función llamada contar_productos que reciba como entrada el nombre de la gama y devuelva el número de productos que existen dentro de esa gama.

DELIMITER $$ 
DROP FUNCTION IF EXISTS contar_productos$$
CREATE FUNCTION contar_productos(gama VARCHAR(50)) 	
	RETURNS INT -- Indica el tipo de variable que devolverá. 
	DETERMINISTIC -- Si es DETERMINISTIC, el resultado siempre será el mismo si los parámetros son los mismos
BEGIN 
	DECLARE total INT; -- Declaración de variable local	
	SET total = (SELECT COUNT(*) from producto where producto.gama=gama); -- Definición	
	RETURN total; -- Return
END
$$

SELECT contar_productos("Herramientas");

-- Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.

DELIMITER $$
DROP PROCEDURE IF EXISTS mostrar_holamundo;
CREATE PROCEDURE mostrar_holamundo ()
BEGIN
	SELECT "Hola mundo"; 
END 
$$

CALL mostrar_holamundo;

-- -------------------------------------------
--  CÓMO REALIZAR UNA UN IF                 -- 
-- -------------------------------------------

-- Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.

DELIMITER $$ 
DROP PROCEDURE IF EXISTS par_impar;
CREATE PROCEDURE par_impar (IN numero_real INT) 
BEGIN
	IF numero_real%2=0 THEN 
		SELECT "Es par"; 
	ELSE 
		SELECT "Es impar";
	END IF; -- No olvidar el ";". 
END 
$$

CALL par_impar (3); 

-- Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor un número real, y un parámetro de salida, con una cadena de caracteres indicando si el número es positivo, negativo o cero.

DELIMITER $$
DROP PROCEDURE IF EXISTS par_impar_out;
CREATE PROCEDURE par_impar_out (IN numero_real INT, OUT par_impar VARCHAR(50))
BEGIN 
	IF numero_real%2=0 THEN 
		SET par_impar =  "Es par";
	ELSE 
		SET par_impar = "Es impar";
	END IF; 
END 
$$

CALL par_impar_out (3, @par_impar);
SELECT @par_impar;

-- Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes. Resuelva el procedimiento haciendo uso de la estructura de control IF.

DELIMITER $$
DROP FUNCTION IF EXISTS dia_semana; 
CREATE FUNCTION dia_semana (dia INT) 
	RETURNS VARCHAR(50)
	DETERMINISTIC 
BEGIN
	DECLARE salida VARCHAR(50);
	
	IF dia = 1 THEN 
		SET salida ="Lunes"; 
	ELSEIF dia = 2 THEN 
		SET salida ="Martes";
	ELSEIF dia = 3 THEN 
		SET salida ="Miércoles";
	ELSEIF dia = 4 THEN 
		SET salida ="Jueves";
	ELSEIF dia = 5 THEN 
		SET salida ="Viernes";
	ELSEIF dia = 6 THEN 
		SET salida ="Sábado";
	ELSEIF dia = 7 THEN 
		SET salida ="Domingo";
	ELSE 
		SET salida ="Parámetro no identificado";
	END IF;
	
	RETURN salida;
END 
$$

SELECT dia_semana(3);$$


-- -------------------------------------------
--  CÓMO REALIZAR UNA UN CASE               -- 
-- -------------------------------------------


-- Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
/*[0,5) = Insuficiente
[5,6) = Aprobado
[6, 7) = Bien
[7, 9) = Notable
[9, 10] = Sobresaliente

En cualquier otro caso la nota no será válida.
*/

DELIMITER $$ 
DROP PROCEDURE IF EXISTS calcula_notas;
CREATE PROCEDURE calcula_notas (IN numero_real INT) 
BEGIN
	CASE 
		WHEN numero_real <5 AND numero_real>=0 THEN 
			SELECT "Insuficiente"; 
		WHEN numero_real >= 5 AND numero_real <7 THEN
			SELECT "Aprobado"; 
		WHEN numero_real >=7 AND numero_real <9 THEN
			SELECT "Notable";
		WHEN numero_real >= 9 AND numero_real<=10 THEN
			SELECT "Sobresaliente";
		ELSE 
			SELECT "ERROR: parámetro incorrectro"; 
	END CASE; 
END 
$$
CALL calcula_notas(-1);
CALL calcula_notas(0);
CALL calcula_notas(1);
CALL calcula_notas(4);
CALL calcula_notas(5);
CALL calcula_notas(6);
CALL calcula_notas(7);
CALL calcula_notas(8);
CALL calcula_notas(9);
CALL calcula_notas(10);
CALL calcula_notas(11);
$$

-- Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.

DELIMITER $$
DROP PROCEDURE IF EXISTS calcula_notas_out; 
CREATE PROCEDURE calcula_notas_out (IN numero_real INT, OUT nota VARCHAR(50))
BEGIN
	CASE 
		WHEN numero_real <5 AND numero_real>=0 THEN 
			SET nota = "Insuficiente"; 
		WHEN numero_real >= 5 AND numero_real <7 THEN
			SET nota = "Aprobado"; 
		WHEN numero_real >=7 AND numero_real <9 THEN
			SET nota = "Notable";
		WHEN numero_real >= 9 AND numero_real<=10 THEN
			SET nota = "Sobresaliente";
		ELSE 
			SET nota = "ERROR: parámetro incorrectro"; 
	END CASE; 

END 
$$

	CALL calcula_notas_out(3, @nota); 
	SELECT @nota; 
	
-- -------------------------------------------
--  FUNCIONAMIENTO DE LOS CURSORES          -- 
-- -------------------------------------------	
-- > Los cursores servirán para guardar muchos datos en una sola variable. 

-- Prueba 1 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS primercursor$$ 
CREATE PROCEDURE primercursor()
BEGIN 	

	-- BLOQUE DE DECLARACIONES 
	
	DECLARE _codigo_empleado INT; -- El nombre de la variable en que se almacenarán los datos mostrados debe ser DIFERENTE al nombre de la columna (nótese el "_")
	DECLARE terminado BOOLEAN DEFAULT 0; -- Variable que controlará la finalización del bucle
	DECLARE cursor1 CURSOR FOR SELECT codigo_empleado FROM empleado; -- Definición del cursor sobre una consulta específica. 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET terminado =1; -- Asocia el cóidigo de error para REGISTRO NO ENCONTRADO con la variable terminado=1.
	
	-- PRELIMINAR AL BUCLE
	
	OPEN cursor1; -- Apertura del cursor
	
	SET _codigo_empleado =0; -- Necesario asociar un espacio a la variable, de lo contrario arrojará registros nulos
	
	-- BUCLE
	
	bucle:LOOP
		
		FETCH cursor1 INTO _codigo_empleado; 
		
		IF terminado THEN 
			LEAVE bucle;			
		END IF;	
	
		SELECT _codigo_empleado; 
		
	END LOOP bucle; 
	
	-- CIERRE 
	
	CLOSE cursor1; 
	
END 
$$

CALL primercursor();

-- Prueba 2 

-- SELECT codigo_empleado, nombre FROM empleado WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas from cliente);

DELIMITER $$ 
DROP PROCEDURE IF EXISTS segundocursor$$
CREATE PROCEDURE segundocursor() 
BEGIN
	-- BLOQUE DE DECLARACIONES 
	
	DECLARE _codigo_empleado INT; 
	DECLARE _nombre VARCHAR (50); 
	DECLARE terminado BOOLEAN default 0; 
	DECLARE cursor1 CURSOR FOR 
		SELECT codigo_empleado, nombre FROM empleado WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas from cliente);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET terminado =1; 
	
	-- PRELIMINAR AL BUCLE 
	
	SET _codigo_empleado = 0;
	SET _nombre = "";
	OPEN cursor1;
	
	-- BUCLE 
	
	bucle:LOOP
	
		FETCH cursor1 into _codigo_empleado, _nombre;
		
		IF terminado THEN 
			LEAVE bucle; 
		END IF; 
		
		SELECT _codigo_empleado, _nombre;
	
	END LOOP bucle;
	
	-- FINAL 
	
	CLOSE cursor1; 
	
END
$$

/*
Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla llamada alumnos y 4 sentencias de inserción para inicializar la tabla. La tabla alumnos está formada por las siguientes columnas:
id (entero sin signo y clave primaria)
nombre (cadena de caracteres)
apellido1 (cadena de caracteres)
apellido2 (cadena de caracteres
fecha_nacimiento (fecha)
Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un valor calculado a partir de la columna fecha_nacimiento. Escriba la sentencia SQL necesaria para modificar la tabla y añadir la nueva columna.
*/ 

CREATE DATABASE test; 
USE test;

CREATE TABLE alumnos (	
	id INT AUTO_INCREMENT, 
	nombre VARCHAR(50), 
	apellido1 VARCHAR(50), 
	apellido2 VARCHAR(50), 
	fecha_nacimiento DATE,
	PRIMARY KEY (id)
);

INSERT INTO alumnos (nombre, apellido1, apellido2, fecha_nacimiento) VALUES 
("Hugo", "Ruiz", "Sánchez", "2003-05-05"), 
("Óscar", "Ruiz", "Sánchez", "2008-09-27"), 
("Antonio", "Herrera", "Fernández","1999-05-07"), 
("Laura", "Loeches", "Valle", "2005-12-12"); 

ALTER TABLE alumnos ADD COLUMN edad INT;

-- ----------------------------------------- --
--  FUNCIONAMIENTO DE LOS TRIGGERS           -- 
-- ----------------------------------------- --	

DELIMITER $$
CREATE TRIGGER calcular_edad
BEFORE INSERT ON alumnos -- Antes de (Acción de insertar) en alumnos. 
FOR EACH ROW -- Para cada fila
BEGIN
    SET NEW.edad = YEAR(CURDATE()) - YEAR(NEW.fecha_nacimiento); -- Añadir a la nueva fila creada una edad en base a la fecha de nacimiento.
END;
$$ 

UPDATE alumnos SET edad = YEAR(CURDATE()) - YEAR(fecha_nacimiento) WHERE edad is null;

-- Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro:Función: calcular_edad Entrada: Fecha Salida: Número de años (entero)

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_edad$$
CREATE FUNCTION calcular_edad (fecha DATE) 
RETURNS INT 
DETERMINISTIC
BEGIN
	RETURN YEAR(CURDATE()) - YEAR(fecha);
END
$$

-- Ahora escriba un procedimiento que permita calcular la edad de todos los alumnmos que ya existen en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que calcule la edad de cada alumno y actualice la tabla. Este procedimiento hará uso de la función calcular_edad que hemos creado en el paso anterior.

DELIMITER $$ 
DROP PROCEDURE IF EXISTS actualizar_columna_edad $$
CREATE PROCEDURE actualizar_columna_edad ()
BEGIN
	UPDATE alumnos SET edad = calcular_edad(alumnos.fecha_nacimiento); 	
END
$$

-- Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email. Una vez que hemos modificado la tabla necesitamos asignarle una dirección de correo electrónico de forma automática.

ALTER TABLE alumnos ADD column email VARCHAR(50) ;

-- Escriba una función llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.

DELIMITER $$

DROP FUNCTION IF EXISTS crear_email$$
CREATE FUNCTION crear_email(nombre VARCHAR(50),apellido VARCHAR(50),apellido2 VARCHAR(50), dominio VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC 
BEGIN
	RETURN CONCAT(nombre, apellido,apellido2,"@",dominio);
END 
$$

-- PROCEDIMIENTO que actualice los emails existentes 

DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_email $$
CREATE PROCEDURE actualizar_email()
BEGIN

	UPDATE alumnos SET email = crear_email(alumnos.nombre, alumnos.apellido1, alumnos.apellido2, "hugors.site") WHERE email is null;
 
END 
$$

-- TRIGGER que actualiza los emails cada vez que se inserta 

DELIMITER $$ 

DROP TRIGGER IF EXISTS calcular_email $$
CREATE TRIGGER calcular_email 
BEFORE INSERT ON alumnos
FOR EACH ROW 
BEGIN 
	SET NEW.email = crear_email(NEW.nombre, NEW.apellido1, NEW.apellido2, "hugors.site");
END 
$$


-- Trigger 1: trigger_check_nota_before_insert
/*Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de inserción.
Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.
*/

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert $$
CREATE TRIGGER trigger_check_nota_before_intert
BEFORE INSERT ON alumnos 
FOR EACH ROW 
BEGIN 
	IF NEW.nota <0 THEN 
		SET NEW.nota = 0; 
	ELSEIF NEW.nota >10 THEN
		SET NEW.nota = 10; 
	END IF;
END $$

-- Procedimiento que asigne numeros aleatorios a las notas

DELIMITER $$ 
DROP PROCEDURE IF EXISTS numeros_aleatorios_notas $$
CREATE PROCEDURE numeros_aleatorios_notas()
BEGIN
  UPDATE alumnos SET nota = FLOOR(RAND() * 11);
END $$


-- Procedimiento con cursor que clasifique a los alumnos en cuatro tablas: insuficiente (-5), aprobado (-7), sobresaliente (-10)

CREATE TABLE insuficiente (	
	id INT AUTO_INCREMENT, 
	nombre VARCHAR(50), 
	apellido1 VARCHAR(50), 
	apellido2 VARCHAR(50), 
	fecha_nacimiento DATE,
	PRIMARY KEY (id)
);

CREATE TABLE aprobado (	
	id INT AUTO_INCREMENT, 
	nombre VARCHAR(50), 
	apellido1 VARCHAR(50), 
	apellido2 VARCHAR(50), 
	fecha_nacimiento DATE,
	PRIMARY KEY (id)
);

CREATE TABLE sobresaliente (	
	id INT AUTO_INCREMENT, 
	nombre VARCHAR(50), 
	apellido1 VARCHAR(50), 
	apellido2 VARCHAR(50), 
	fecha_nacimiento DATE,
	PRIMARY KEY (id)
);
