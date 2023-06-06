
	-- DESARROLLO PRELIMINAR EL DEL EJERCICIO: CREACIÓN DE LA BASE DE DATOS E INTRODUCCIÓN DE DATOS PROPUESTA. 

	CREATE DATABASE pruebadenivel; 
	USE pruebadenivel;

	CREATE TABLE UsuariosTlf (
	   id INT PRIMARY KEY AUTO_INCREMENT,
	   usuario VARCHAR(20),
	   nombre VARCHAR(20),
	   sexo VARCHAR(1),
	   nivel TINYINT,
	   email VARCHAR(50),
	   telefono VARCHAR(20),
	   marca VARCHAR(20),
	   compania VARCHAR(20),
	   saldo FLOAT,
	   activo BOOLEAN
	);

	# Carga de datos 

	INSERT INTO UsuariosTlf
	VALUES 
	('1','BRE2271','BRENDA','M','2','brenda@live.com','655-330-5736','SAMSUNG','IUSACELL','100','1'),
	('2','OSC4677','OSCAR','H','3','oscar@gmail.com','655-143-4181','LG','TELCEL','0','1'),
	('3','JOS7086','JOSE','H','3','francisco@gmail.com','655-143-3922','NOKIA','MOVISTAR','150','1'),
	('4','LUI6115','LUIS','H','0','enrique@outlook.com','655-137-1279','SAMSUNG','TELCEL','50','1'),
	('5','LUI7072','LUIS','H','1','luis@hotmail.com','655-100-8260','NOKIA','IUSACELL','50','0'),
	('6','DAN2832','DANIEL','H','0','daniel@outlook.com','655-145-2586','SONY','UNEFON','100','1'),
	('7','JAQ5351','JAQUELINE','M','0','jaqueline@outlook.com','655-330-5514','BLACKBERRY','AXEL','0','1'),
	('8','ROM6520','ROMAN','H','2','roman@gmail.com','655-330-3263','LG','IUSACELL','50','1'),
	('9','BLA9739','BLAS','H','0','blas@hotmail.com','655-330-3871','LG','UNEFON','100','1'),
	('10','JES4752','JESSICA','M','1','jessica@hotmail.com','655-143-6861','SAMSUNG','TELCEL','500','1'),
	('11','DIA6570','DIANA','M','1','diana@live.com','655-143-3952','SONY','UNEFON','100','0'),
	('12','RIC8283','RICARDO','H','2','ricardo@hotmail.com','655-145-6049','MOTOROLA','IUSACELL','150','1'),
	('13','VAL6882','VALENTINA','M','0','valentina@live.com','655-137-4253','BLACKBERRY','AT&T','50','0'),
	('14','BRE8106','BRENDA','M','3','brenda2@gmail.com','655-100-1351','MOTOROLA','NEXTEL','150','1'),
	('15','LUC4982','LUCIA','M','3','lucia@gmail.com','655-145-4992','BLACKBERRY','IUSACELL','0','1'),
	('16','JUA2337','JUAN','H','0','juan@outlook.com','655-100-6517','SAMSUNG','AXEL','0','0'),
	('17','ELP2984','ELPIDIO','H','1','elpidio@outlook.com','655-145-9938','MOTOROLA','MOVISTAR','500','1'),
	('18','JES9640','JESSICA','M','3','jessica2@live.com','655-330-5143','SONY','IUSACELL','200','1'),
	('19','LET4015','LETICIA','M','2','leticia@yahoo.com','655-143-4019','BLACKBERRY','UNEFON','100','1'),
	('20','LUI1076','LUIS','H','3','luis2@live.com','655-100-5085','SONY','UNEFON','150','1'),
	('21','HUG5441','HUGO','H','2','hugo@live.com','655-137-3935','MOTOROLA','AT&T','500','1');

	-- (Conviene insertar un comando DESCRIBE para orientarnos más fácilmente, identifica las variables)
    SELECT * from UsuariosTlf;
    DESCRIBE UsuariosTlf; 

	-- #1 Listar los nombres de los usuarios

	SELECT usuario from UsuariosTlf;

	-- #2 Calcular el saldo máximo de los usuarios de sexo “Mujer”

	SELECT max(saldo) as "Salario mayor de mujer 'max(saldo)'." FROM UsuariosTlf where sexo = "M" ;

	-- #3 Listar nombre y teléfono de los usuarios con teléfono NOKIA, BLACKBERRY o SONY

	SELECT nombre, telefono, marca FROM UsuariosTlf where marca = "NOKIA" or marca = "BLACKBERRY" or marca = "SONY";
    
    -- (Forma alternativa) 
    
    SELECT nombre, telefono, marca FROM UsuariosTlf where marca in ('NOKIA','BLACKBERRY', 'SONY');
	
	-- #4 Contar los usuarios sin saldo o inactivos

	SELECT count(usuario) as "Usuarios inactivos 'count(saldo=0 || activo=false)'" FROM UsuariosTlf where saldo=0 or activo=false;
    
    -- (Forma alternativa)
    
	SELECT count(usuario) as "Usuarios inactivos 'count(saldo=0 || activo=false)'" FROM UsuariosTlf where saldo=0 or activo=0;
        
	SELECT count(usuario) as "Usuarios inactivos 'count(saldo=0 || activo=false)'" FROM UsuariosTlf where saldo=0 or not activo;

	-- #5  Listar el login de los usuarios con nivel 1, 2 o 3 

	SELECT usuario, nivel FROM UsuariosTlf where nivel = 1 or nivel =2 or nivel =3 ORDER BY nivel;

	-- #6 Listar los números de teléfono con saldo menor o igual a 300

	SELECT telefono, saldo FROM UsuariosTlf where saldo<=300;

	-- #7 Calcular la suma de los saldos de los usuarios de la compañia telefónica IUSACELL

	SELECT sum(saldo) as "Suma del saldo IUSACELL 'sum(saldo si compania=IUSACELL) '"  from UsuariosTlf where compania ="IUSACELL";

	-- #8 Contar el número de usuarios por compañía telefónica

	SELECT compania, count(usuario) as "Numero de usuarios 'count (usuario)'" FROM UsuariosTlf GROUP BY compania;

	-- #9 Contar el número de usuarios por nivel

	SELECT nivel, count(usuario) as "Numero de usuarios 'count (usuario)'" FROM UsuariosTlf GROUP BY nivel ORDER BY nivel;
	 
	-- #10 Listar el login de los usuarios con nivel 2

	SELECT usuario from UsuariosTlf where nivel=2;

	-- #11 Mostrar el email de los usuarios que usan gmail

	SELECT email from UsuariosTlf where email LIKE "%gmail%"; 

	-- #12 Listar nombre y teléfono de los usuarios con teléfono LG, SAMSUNG o MOTOROLA

	SELECT nombre, telefono from UsuariosTlf where marca = "LG" or marca = "SAMSUNG" or marca = "MOTOROLA";

	-- #13 (1)  Listar el login y teléfono de los usuarios con compañia telefónica que no sea TELCEL
    
    SELECT usuario, telefono from UsuariosTlf where marca != "TELCEL";
    
    -- (Otra forma de realizarlo) 
    
	SELECT usuario, telefono from UsuariosTlf where marca <> "TELCEL";
    
    -- #14 (2) Listar las diferentes marcas de celular en orden alfabético descendentemente
    
    SELECT marca from UsuariosTlf ORDER BY marca DESC;
    
    -- (Para LISTARLO sin repeticiones: la anterior sentencia es incorrecta)
    
    SELECT DISTINCT marca FROM UsuariosTlf ORDER BY marca DESC;
    
    -- #15 (3) Listar las diferentes compañías en orden alfabético aleatorio
    
    SELECT DISTINCT compania from UsuariosTlf ORDER BY rand();
    
	-- #16 (4) Listar nombre y teléfono de los usuarios con teléfono que no sea de la marca LG o SAMSUNG
    
    SELECT nombre, telefono, marca from UsuariosTlf where marca NOT IN ("LG", "SAMSUNG");
    
    SELECT nombre, telefono, marca from UsuariosTlf where marca <> "LG" AND marca <> "SAMSUNG";
    
	SELECT nombre, telefono, marca from UsuariosTlf where (marca <> "LG" AND marca <> "SAMSUNG");
    
	SELECT nombre, telefono, marca from UsuariosTlf where NOT (marca = "LG" OR marca = "SAMSUNG");
    
    -- #17 (5) Calcular el saldo promedio de los usuarios que tienen teléfono marca NOKIA
    
    SELECT avg(saldo) from UsuariosTlf where marca = "NOKIA";
    
    -- #18 (6) Mostrar el email de los usuarios que no usan yahoo
    
    SELECT email from UsuariosTlf where email NOT LIKE "%@yahoo%";
    
    -- #19 (7) Mostrar para cada marca de teléfono (en orden descendente) el número de usuarios 
    
    SELECT marca, count(usuario) from UsuariosTlf GROUP BY marca ORDER BY marca DESC;
    
