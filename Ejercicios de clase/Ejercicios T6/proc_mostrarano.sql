DELIMITER $$
DROP PROCEDURE IF EXISTS muestra_ano $$
CREATE PROCEDURE bd_programacion.muestra_ano () 
LANGUAGE SQL DETERMINISTIC
BEGIN
SELECT YEAR (current_date()) AS ANO;
END $$


CALL bd_programacion.muestra_ano ();