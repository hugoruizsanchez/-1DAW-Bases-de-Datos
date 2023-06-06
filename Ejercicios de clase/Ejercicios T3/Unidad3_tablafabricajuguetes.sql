CREATE DATABASE fabricadejuguetes2; -- CREACIÓN DE LA BASE DE DATOS. 
USE fabricadejuguetes2; -- SELECCIÓN DE USO DE BASE DE DATOS.

-- CREAR BASE DE DATOS de PLANTAS.

CREATE TABLE plantas ( 

color varchar (25) not null,
superficie int not null, 
PRIMARY KEY (color)

);

-- CREAR BASE DE DATOS de PROCESOS.

CREATE TABLE procesos (

nombre varchar (25) not null,
gradocomplejidad ENUM ('Muy baja','Baja','Media','Alta','Muy alta'), -- Selección de una sola opción de entre las creadas.
PRIMARY KEY (nombre)

);

-- CREAR BASE DE DATOS de PLANTASPROCESOS.

CREATE TABLE plantasprocesos (

colorplanta varchar (25) not null,
nombreproceso varchar (25) not null,

foreign key (colorplanta) references plantas (color),
foreign key (nombreproceso) references procesos (nombre)

);

-- CREAR BASE DE DATOS de MÁQUINAS.

CREATE TABLE maquinas (
numero int not null, 
marca varchar (25) not null, 
modelo varchar (25) not null, 
numeromaquinaquelareemplaza int, -- nulo (no obligatorio) 
colorplantacontiene varchar (25) not null, 
foreign key (numeromaquinaquelareemplaza) references maquinas (numero),
foreign key (colorplantacontiene) references plantas (color),
PRIMARY KEY (numero)
);

CREATE TABLE tecnicos ( 

dni char (9) not null,
nombre varchar (25) not null,
apellidos varchar (25) not null, 
fechanacimiento date not null		,
PRIMARY KEY (dni)
);

CREATE TABLE telefonoscontacto (

dnicontacto char (9) not null, 
telefonoscontacto varchar (25) not null, 
FOREIGN KEY (dnicontacto) references tecnicos (dni),
PRIMARY KEY (telefonoscontacto, dnicontacto) -- Los teléfonos de contacto son multivaluados, por eso deben ir adjuntos al DNI (que es unico) para brindar elegancia al conjunto. 

);

CREATE TABLE maquinasoperantecnicos (
	
numeromaquina int not null,
dnitecnico char (9) not null,
fechainicio date not null,
fechafin date not null,
turno SET ('Mañana','Tarde','Noche'), -- Selección de varias opciones de entre las creadas. 
PRIMARY KEY (fechainicio),
FOREIGN KEY (dnitecnico) references tecnicos (dni), 
FOREIGN KEY (numeromaquina) references maquinas (numero)
);

