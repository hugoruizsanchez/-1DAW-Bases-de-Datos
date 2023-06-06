CREATE DATABASE tarde;
USE tarde;

/*
Ejercicio 1. Crear una tabla que llamada alumnos formada por las siguientes columnas:
• id: entero y clave primaria
• nombre: cadena de caracteres (50), no nulo
• apellido1: cadena de caracteres (50), no nulo
• apellido2: cadena de caracteres (50),
• fecha_nacimiento: fecha
Introducir en la tabla cinco registros, correspondientes a cinco alumnos
*/ 

CREATE TABLE alumnos (

id int (50) NOT NULL auto_increment, 
nombre varchar (50) NOT NULL, 
apellido1 varchar (50) NOT NULL, 
apellido2 varchar (50), 
fecha_nacimiento DATE,
primary key (id)

);

INSERT INTO alumnos (nombre, apellido1, apellido2, fecha_nacimiento) 
VALUES 
("Hugo", "Ruiz", "Sánchez", "2003-05-05"),
("Oscar", "Ruiz", "Sánchez", "2003-05-05"),
("Javier", "Solano", "Pérez", "2003-05-05"),
("Rodrigo", "Fernandez", "Tello", "2003-05-05");

/*
Ejercicio 2. Una vez creada la tabla se identifica que es necesario añadir una nueva columna a la
tabla llamada edad que será un valor calculado a partir de la columna fecha_nacimiento. Escribir
la sentencia SQL necesaria para añadir la nueva columna
*/

ALTER TABLE alumnos ADD edad int not null after fecha_nacimiento; 

/*
Ejercicio 3. Definir una función llamada calcular_edad que reciba una fecha y devuelva el número
de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro
*/

DELIMITER $$
DROP FUNCTION IF EXISTS tarde.calcularedad_a$$
CREATE FUNCTION tarde.calcularedad_a (fecha_nacimiento DATE)
RETURNS int
LANGUAGE SQL DETERMINISTIC
BEGIN 

DECLARE edad INT DEFAULT 0;
SET edad = DATEDIFF(CURRENT_DATE(), fecha_nacimiento) DIV 365;
return edad;

END $$
DELIMITER ;

/*
Ejercicio 4. Crear un procedimiento que calcule la edad de todos los alumnos que existen en la
tabla y actualice el campo edad de la tabla.
*/


DELIMITER $$
DROP PROCEDURE IF EXISTS tarde.asignaredadalumnos_b $$
CREATE PROCEDURE tarde.asignaedadalumnos_b () 
LANGUAGE SQL DETERMINISTIC
BEGIN

UPDATE alumnos SET edad =  tarde.calcularedad_a(alumnos.fecha_nacimiento) where alumnos.edad =0; 

END $$
DELIMITER ;

SET SQL_SAFE_UPDATES=0; 
UPDATE alumnos set edad =0 where alumnos.edad=20;
SELECT * from alumnos;
CALL tarde.asignaedadalumnos_b;

/*
Ejercicio 5. Posteriormente se identifica que es necesario añadir una nueva columna a la tabla
llamada email que será un valor calculado a partir de otras columnas. Escribir la sentencia SQL
necesaria para añadir la nueva columna
*/

ALTER TABLE alumnos ADD email varchar(50) not null after apellido2;

/*
Ejercicio 6. Crear un procedimiento llamado crear_email que dados los parámetros de entrada:
nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como
parámetro de salida con el siguiente contenido (todos ellos en minúsculas y eliminando espacios
en blanco):
• El nombre completo.
• Los tres primeros caracteres distintos de espacio del parámetro apellido1.
• Los tres primeros caracteres distintos de espacio del parámetro apellido2.
• El carácter @.
• El dominio pasado como parámetro.
*/


DELIMITER $$
DROP FUNCTION IF EXISTS tarde.crear_emilio_h$$
CREATE FUNCTION tarde.crear_emilio_h (nombre varchar (50), apellido1 varchar (50), apellido2 varchar (50), dominio varchar (50))  
RETURNS varchar (50)
LANGUAGE SQL DETERMINISTIC
BEGIN 

-- PRIMEROS TRES CARACTERES de APELLIDO1 y APELLIDO2 
SET nombre = replace(apellido1, " ","");
SET apellido1 = replace(apellido1, " ","");
SET apellido2= replace(apellido2, " ","");
SET nombre = lower(nombre);
SET apellido1 = lower(substring(apellido1,1,3));
SET apellido2 = lower(substring(apellido2,1,3));

-- return

return concat(nombre,apellido1,apellido2,"@",dominio); 
END $$
DELIMITER ;

SELECT tarde.crear_emilio_h("Luis", "de la Torre", "Martínez", "lalocura.com");

/*
Ejercicio 7. Crear un procedimiento llamado actualizar_email que actualice el campo email de
todos los alumnos que ya existen en la tabla alumnos utilizando el procedimiento crear_email
del ejercicio anterior.
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS tarde.asignaemailalumnos_a $$
CREATE PROCEDURE tarde.asignaemailalumnos_a (dominio varchar (50)) 
LANGUAGE SQL DETERMINISTIC
BEGIN
UPDATE alumnos SET email =  tarde.crear_emilio_d(alumnos.nombre, alumnos.apellido1, alumnos.apellido2, dominio) where alumnos.nombre is not null;
END $$
DELIMITER ;

CALL tarde.asignaemailalumnos_a ("fesd.es");

SELECT * from alumnos;
SELECT CONCAT(email,";") as "listaemails"  from alumnos;

/*
Ejercicio 8. Crear un  un procedimiento llamado crear_lista_emails que devuelva
la lista de emails de la tabla alumnos con un punto y coma detrás de cada una de las direcciones
de correo
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS tarde.crear_lista_emails_b $$
CREATE PROCEDURE tarde.crear_lista_emails_k ()
LANGUAGE SQL DETERMINISTIC
BEGIN
DECLARE lista_emails varchar (16383) default "";
DECLARE email varchar (16383) default ""; 
DECLARE i int default 0;
bucle:LOOP

SET lista_emails = CONCAT(lista_emails,email);

 -- CONDICIÓN DEL BUCLE
  SET i = i+1;
  IF i <=count(email.alumnos) THEN
    LEAVE bucle;
  END IF;
  
  -- FIN DEL BUCLE 
  SELECT lista_emails;
END LOOP;




END $$
DELIMITER ;

CALL tarde.crear_lista_emails_k ();


/*El problema en este caso es que estás definiendo la variable lista_emails como varchar (16383), pero estás intentando concatenarla con la variable email, que está definida como varchar(50). Es necesario asegurarse de que ambas variables tengan el mismo tipo de datos para poder concatenarlas correctamente.

Además, en la condición del bucle estás utilizando la variable email.alumnos, lo cual no tiene sentido ya que email es una variable de tipo varchar y no tiene una propiedad llamada alumnos. Es necesario definir la variable email de alguna manera para poder utilizarla en el bucle.

Una posible solución a estos problemas podría ser la siguiente:

DELIMITER $$
DROP PROCEDURE IF EXISTS tarde.crear_lista_emails_k $$
CREATE PROCEDURE tarde.crear_lista_emails_k ()
LANGUAGE SQL DETERMINISTIC
BEGIN
    DECLARE lista_emails varchar(16383) DEFAULT '';
    DECLARE i INT DEFAULT 1;
    DECLARE n_emails INT;
    DECLARE email VARCHAR(50);
    
    -- Obtener la cantidad de emails a procesar
    SELECT COUNT(*) INTO n_emails FROM alumnos;
    
    -- Bucle para concatenar los emails
    WHILE i <= n_emails DO
        SELECT correo INTO email FROM alumnos LIMIT i-1, 1;
        SET lista_emails = CONCAT(lista_emails, email, ',');
        SET i = i + 1;
    END WHILE;
    
    -- Eliminar la última coma de la lista de emails
    SET lista_emails = SUBSTRING(lista_emails, 1, LENGTH(lista_emails)-1);
    
    -- Mostrar la lista de emails concatenados
    SELECT lista_emails;
END $$
DELIMITER ;

En esta solución, se utiliza un bucle while en lugar de un bucle loop, y se define la variable email dentro del bucle para obtener el correo electrónico correspondiente a cada iteración. También se agrega una consulta SELECT COUNT(*) INTO n_emails FROM alumnos para obtener la cantidad de correos electrónicos a procesar, y se utiliza una variable n_emails en la condición del bucle. Además, se elimina la última coma de la lista de correos electrónicos concatenados antes de mostrar el resultado final.*/

SELECT * from alumnos;

