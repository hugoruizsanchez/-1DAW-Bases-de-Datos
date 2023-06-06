-- Documento SQL/PL de ORACLE: NOMYSQL 

-- --------------------------------------------------- - -
--  FUNCIONAMIENTO DE LOS TYPE - Campos multivaluados  - - 
-- -------------------------------
------------------- - -

/*
Se requiere la creación de una tabla con las siguientes características: 

Id_producto: identificador del producto de tipo numérico.
Nombre: nombre del producto de tipo alfanumérico de 50 caracteres de longitud.
Descripcion: descripción breve del producto de una longitud de 250 caracteres
Proveedores: tabla con los nombres de los proveedores
*/

CREATE TYPE tabla_proveedores AS TABLE OF VARCHAR(80); -- Creación de la tabla multivaluada "tabla_oriveedires". 

CREATE TABLE productos (
	id INT, 
	nombre VARCHAR(50), 
	descripcion VARCHAR(250), 
	proveedores (tabla_proveedores) -- Se vinculan los proveedores a la multivaluada anteriormente creada, tabla_proveedores
) NESTED TABLE proveedores STORE AS t_proveedores; -- Se ratifica el cambio despues de la creación de la tabla. 



SELECT nombre FROM productos, TABLE (productos.proveedores) tabla WHERE 
tabla.object_value = ‘ACME Solutions’
