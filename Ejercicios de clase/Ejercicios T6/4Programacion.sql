

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
                                                                                                                                                                                                                                                                                                                                                                                                                                                         