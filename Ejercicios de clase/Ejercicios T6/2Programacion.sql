CREATE DATABASE bd_programacion;
USE bd_programacion; 

DELIMITER $$
DROP PROCEDURE IF EXISTS hola_mundo $$
CREATE PROCEDURE bd_programacion.hola_mundo () 
LANGUAGE SQL DETERMINISTIC
BEGIN
SELECT "Hola, mundo";
END $$
DELIMITER;

-- Actividad 6.5. En una base de datos crear un procedimiento para mostrar el año actual

DELIMITER $$
DROP PROCEDURE IF EXISTS muestra_ano $$
CREATE PROCEDURE bd_programacion.muestra_ano () 
LANGUAGE SQL DETERMINISTIC
BEGIN
SELECT YEAR (current_date()) AS ANO;
END $$
DELIMITER ;

-- Función de la actividad 6.5 

DELIMITER $$ 
DROP FUNCTION IF EXISTS muestra_ano$$
CREATE FUNCTION muestra_ano_f ()
returns varchar (100) 
LANGUAGE SQL DETERMINISTIC
BEGIN 
return (current_date());
END $$
DELIMITER ;

-- Actividad 6.6. Crear un procedimiento que cree una variable de usuario con SET y mostrar posteriormente

DELIMITER $$
DROP PROCEDURE IF EXISTS bd_programacion.crear_variable $$
CREATE PROCEDURE bd_programacion.crear_variable () 
LANGUAGE SQL DETERMINISTIC
BEGIN
SET @variable = 3;
SELECT "La variable es:"+@variable;
END $$
DELIMITER ;

-- Actividad 6.7.2

DELIMITER $$
DROP PROCEDURE IF EXISTS bd_programacion.crear_variable_x $$
CREATE PROCEDURE bd_programacion.crear_variable_x () 
LANGUAGE SQL DETERMINISTIC
BEGIN
SET @x = 7;
SELECT "La variable es:"+@x;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS bd_programacion.crear_variable_x;

-- 6.7 Crear un procedimiento que muestre dos cadenas pasadas como parámetros concatenadas y en mayúsculas

DELIMITER $$
DROP PROCEDURE IF EXISTS bd_programacion.concatenar_dos_cadenas $$
CREATE PROCEDURE bd_programacion.concatenar_dos_cadenas (IN texto1 VARCHAR (20), IN texto2 VARCHAR(20)) 
LANGUAGE SQL DETERMINISTIC
BEGIN
SELECT CONCAT(texto1,texto2);
END $$
DELIMITER ;

-- 6.8 Actividad 6.8. Crear un procedimiento que para los dos catetos de un triángulo rectángulo calcule la hipotenusa y la muestre
DELIMITER $$
DROP PROCEDURE IF EXISTS bd_programacion.calcular_triangulo $$
CREATE PROCEDURE bd_programacion.calcular_triangulo (IN valor1 decimal , IN valor2 decimal) 
LANGUAGE SQL DETERMINISTIC
BEGIN
DECLARE resultado decimal (10,2);
SET resultado = SQRT(valor1*valor1+valor2*valor2);
SELECT resultado;
END $$
DELIMITER ;

-- 6.9 Crear una función que devuelva 1 o 0 si  un numero entero es o no divisible por otro numero enterio,
-- teneniendo en cuenta que ambos pasan como parametros de funcion. 

DELIMITER $$ 
DROP FUNCTION IF EXISTS bd_programacion.calcular_uno_cero$$
CREATE FUNCTION bd_programacion.calcular_uno_cero (valor1 int,  valor2 int)
RETURNS int
LANGUAGE SQL DETERMINISTIC
BEGIN 
IF valor1%valor2 = 0 THEN 
    RETURN 0;
ELSE 
    RETURN 1; 
END IF;

END $$
DELIMITER ;


-- 6.10 Crear una función que devuelva el mayor de tres numeros enteros pasados como parametros

DELIMITER $$
DROP FUNCTION IF EXISTS bd_programacion.maximovalor$$
CREATE FUNCTION bd_programacion.maximovalor (valor1 int,  valor2 int, valor3 int)
RETURNS int
LANGUAGE SQL DETERMINISTIC
BEGIN 

DECLARE maximovalor int;  
SET maximovalor = valor1;

IF valor2>maximovalor THEN 
    SET maximovalor = valor2;
END IF;

IF valor3>maximovalor THEN
	SET maximovalor = valor3;
END IF;		
RETURN maximovalor;

END $$
DELIMITER ;




/* VER TODO LO RELACIONADO CON LOS BUCLES SQL

WHILE condición DO
  -- bloque de instrucciones a ejecutar
END WHILE;

El bloque de instrucciones se ejecutará repetidamente mientras la condición sea verdadera. La condición debe ser una expresión booleana. Si la condición es falsa al principio, el bloque de instrucciones no se ejecutará en absoluto.

    Bucle REPEAT:

El bucle REPEAT se utiliza para repetir un bloque de instrucciones hasta que se cumpla una determinada condición. La sintaxis del bucle REPEAT en MySQL es la siguiente:

REPEAT
  -- bloque de instrucciones a ejecutar
UNTIL condición END REPEAT;

El bloque de instrucciones se ejecutará repetidamente hasta que la condición sea verdadera. La condición también debe ser una expresión booleana. El bloque de instrucciones se ejecutará al menos una vez, incluso si la condición es falsa desde el principio.

En ambos casos, es importante tener cuidado de no caer en un bucle infinito, donde la condición nunca cambie y el bucle siga ejecutándose sin fin. También se pueden usar bucles anidados para ejecutar instrucciones repetidamente dentro de otro bucle, pero esto puede complicar el código y hacerlo menos legible. En general, los bucles deben usarse con precaución en MySQL y, en la medida de lo posible, se debe tratar de utilizar consultas más eficientes y optimizadas para realizar operaciones en la base de datos.
hugoruizschz@gmail.com
algo parecido al for?

MySQL no tiene una estructura de bucle FOR, como la que se encuentra en otros lenguajes de programación como C o Java. En su lugar, se utilizan los bucles WHILE y REPEAT que mencioné anteriormente.

Sin embargo, en MySQL puedes simular un
hugoruizschz@gmail.com
LOOP?

Sí, en MySQL puedes simular un bucle FOR utilizando un bucle LOOP. La idea es utilizar una variable de control para repetir un bloque de instrucciones un número determinado de veces. La sintaxis básica de un bucle LOOP en MySQL es la siguiente:

DECLARE i INT DEFAULT 1;
LOOP
  -- bloque de instrucciones a ejecutar
  SET i = i + 1;
  IF i > 10 THEN
    LEAVE;
  END IF;
END LOOP;

/////////////////

LOOP
  -- bloque de instrucciones a ejecutar
  IF condición THEN
    LEAVE;
  END IF;
END LOOP;
*/



-- Actividad 6.11. Crear un procedimiento que muestre la suma de los primeros n números enteros, siendo n un parámetro de entrada


DELIMITER $$
DROP FUNCTION IF EXISTS bd_programacion.suma_valores$$
CREATE FUNCTION bd_programacion.suma_valores (n int,valor1 int,  valor2 int, valor3 int, valor4 int, valor5 int, valot6 int)
RETURNS int
LANGUAGE SQL DETERMINISTIC
BEGIN 
DECLARE i INT DEFAULT 1;
DECLARE suma INT;
SET suma = 0;

bucle:LOOP
  
 CASE i 
 WHEN 1 THEN SET suma = suma+valor1;
 WHEN 2 THEN SET suma = suma+valor2;
 WHEN 3 THEN SET suma = suma+valor3;
 WHEN 4 THEN SET suma = suma+valor4;
 WHEN 5 THEN SET suma = suma+valor5;
 WHEN 6 THEN SET suma = suma+valor6;
 END CASE;
 -- CONDICIÓN DEL BUCLE
 
  SET i = i + 1;
  IF i > n THEN
    LEAVE bucle;
  END IF;
  
  -- FIN DEL BUCLE 
END LOOP;

RETURN suma;


END $$
DELIMITER ;



-- 6.12 Crear una función que determine si un nú,ero entero (que se pasa a la función por patametro= es primo devolviendo 0 (si no es primo) o 
-- 1 si es primo

DELIMITER $$
DROP FUNCTION IF EXISTS bd_programacion.saber_primoz$$
CREATE FUNCTION bd_programacion.saber_primoz (valor int)
RETURNS int
LANGUAGE SQL DETERMINISTIC
BEGIN 
DECLARE finalizado BOOLEAN DEFAULT FALSE;
DECLARE primo BOOLEAN DEFAULT TRUE;
DECLARE i INT DEFAULT 2;

if valor= 1 THEN 
return 0;
ELSE

bucle_while: WHILE finalizado= false DO

IF i > valor THEN 
SET primo = false;
SET finalizado = true;
END IF;

IF valor%i = 0 AND i!= valor  THEN
SET primo = true;
SET finalizado = true;
 
END IF; 

SET i = i+1;
END WHILE;
END IF;

IF primo = true THEN
return 0;
ELSE
return 1;
END IF;

END $$
DELIMITER ;

DROP FUNCTION bd_programacion.saber_primo;

-- EJERCICIOS PROCEDIMIENTOS Y FUNCIONES ALMACENADOS: 1 
-- Crear un procedimiento que muestre la suma de los términos 1/n para n entre 1 y m, es decir, (1/2 + 1/3 + 1/m-1) para m mayor que 0, donde m es el 7
-- parámetro de entrada

DELIMITER $$
DROP PROCEDURE IF EXISTS bd_programacion.uno_fraccion $$
CREATE PROCEDURE bd_programacion.uno_fraccion (IN m int) 
LANGUAGE SQL DETERMINISTIC
BEGIN
DECLARE suma float DEFAULT 0;

bucle:LOOP  

SET suma = suma + 1/m;

 -- CONDICIÓN DEL BUCLE
  SET m = m -1;
  IF m <= 0 THEN
    LEAVE bucle;
  END IF;
  
  -- FIN DEL BUCLE 
END LOOP;

SELECT suma;

END $$
DELIMITER ;

-- EJERCICIOS PROCEDIMIENTOS Y FUNCIONES ALMACENADOS: 2
-- Crear una función que calcule la suma de los primeros N numeros primos. <

DELIMITER $$
DROP FUNCTION IF EXISTS bd_programacion.numeroprimosumax$$
CREATE FUNCTION bd_programacion.numeroprimosumax (n int)
RETURNS int
LANGUAGE SQL DETERMINISTIC
BEGIN 
DECLARE i INT DEFAULT 1;
DECLARE suma int DEFAULT 0;

bucle:LOOP

IF bd_programacion.saber_primoz (i) = 1 THEN
SET suma = suma+i;	
ELSE 
SET n = n+1;
END IF;

 -- CONDICIÓN DEL BUCLE
 SET i = i + 1;
  IF i > n THEN
    LEAVE bucle;
  END IF;
  
  -- FIN DEL BUCLE 
END LOOP;
return suma;
END $$
DELIMITER ;

-- EJERCICIOS PROCEDIMIENTOS Y FUNCIONES ALMACENADOS: 3
-- Crear una función que decuelva el factorial de un número entero positivo que se le debe pasar como parámetro

DELIMITER $$
DROP FUNCTION IF EXISTS bd_programacion.devolverfactoriald$$
CREATE FUNCTION bd_programacion.devolverfactoriald (n int)
RETURNS bigint
LANGUAGE SQL DETERMINISTIC

BEGIN 

DECLARE i INT DEFAULT n;
DECLARE factorial bigint DEFAULT 1;

bucle:LOOP

SET factorial = factorial*i;
SET i = i-1;

 -- CONDICIÓN DEL BUCLE
 
  IF i <=1 THEN
    LEAVE bucle;
  END IF;
  
  -- FIN DEL BUCLE 
END LOOP;

IF n = 0 THEN
RETURN 1;
ELSEIF n <0 THEN
RETURN null; 
ELSE
RETURN factorial;
END IF;

END $$

DELIMITER ;


-- PRINCIPAL 

SHOW FUNCTION STATUS WHERE Db = 'bd_programacion';

CALL bd_programacion.muestra_ano ();
CALL bd_programacion.hola_mundo ();
SELECT bd_programacion.muestra_ano_f ();
CALL bd_programacion.crear_variable () ;
CALL bd_programacion.concatenar_dos_cadenas ("moto", "sierra");
CALL bd_programacion.calcular_triangulo (42.223,132);
SELECT bd_programacion.calcular_uno_cero (10,5);
SELECT bd_programacion.maximovalor (-1,-8, 2) AS "Número más grande de la serie";
SELECT bd_programacion.suma_valores (5,2,3,4,5,6,7);
SELECT bd_programacion.saber_primoz (12);
CALL  bd_programacion.uno_fraccion (5);
SELECT bd_programacion.numeroprimosumax (5);
SELECT bd_programacion.devolverfactoriald(20);
