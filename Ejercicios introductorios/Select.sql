
CREATE TABLE user (

id int not null auto_increment, -- crear ID autoincremental. 
name varchar (50) not null, 
edad int not null,
email varchar (100) not null, 
PRIMARY KEY (id) -- asignamos la ID como clave primaria, esto es, como clave identificadora. 

);
	

INSERT INTO user (name, edad, email) values ('Hugo','19','hugo@gmail.com');
INSERT INTO user (name, edad, email) values ('Marcos','24','marcosc@gmail.com');
INSERT INTO user (name, edad, email) values ('Mario','21','mario@gmail.com');
INSERT INTO user (name, edad, email) values ('Jose','43','jose@gmail.com');


SELECT * from user; -- visualización de la tabla. 
SELECT * from user limit 3; -- Limita la cantidad de registros que se muestran
SELECT * from user where edad > 20; -- Usuarios con la edad mayor a 20
SELECT * from user where edad >= 19;-- Usuarios con la edad mayor a o igual a  19
SELECT * from user where edad >= 19 and email='jose@gmail.com'; -- Proyectar usuarios con la edad mayor a o igual a  19  Y con el email especifico
SELECT * from user where edad >= 60 or email='mario@gmail.com'; -- Proyectar usuarios con la edad mayor a o igual a  19  O con el email especifico
SELECT * from user where email != 'mario@gmail.com';  -- Ver la lista excepto los registros especificados con el email 
SELECT * from user where edad between 19 and 24;  -- Ver registros entre dos numeros

SELECT * from user where email like '%gmail%';	-- Para buscar registros cuyo email contenga las palabras gmail  (debe ir entre porcentajes)
SELECT * from user where email like '%gmail'; -- Aquí le estamos indicando que a la izquierda puede acompañar texto, pero a la derecha no. 
SELECT * from user where email like 'jose%'; -- Aquí, por el contrario, le estamos indicando que a la derecha puede acompañar cualquier cosa, pero que en cualquier caso el principio debe ser jose

SELECT * from user order by edad asc; -- Usuarios ordenador por edad en forma ascendente. 
SELECT * from user order by edad desc; -- Usuarios ordenador por edad en forma descendente. 

SELECT max(edad) as mayor from user;  -- max(edad) buscará el registro con la edad maxima y la asignará a "mayor"
SELECT min(edad) as menor from user; -- min(edad) buscará el registro con la edad mínima y la asignará a "menor"

SELECT id, name from user; -- Podemos usar la pción SELECT con las columnas que deseemos. 
SELECT id, name as nombre from user; -- Modificamos el "name" de la tabla por "nombre" en la visualización. 
