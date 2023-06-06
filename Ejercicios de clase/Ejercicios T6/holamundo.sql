DELIMITER $$
DROP PROCEDURE IF EXISTS hola_mundo $$
CREATE PROCEDURE bd_programacion.hola_mundo () 
LANGUAGE SQL DETERMINISTIC
BEGIN
SELECT "Hola, mundo";
END $$

CALL bd_programacion.hola_mundo ();