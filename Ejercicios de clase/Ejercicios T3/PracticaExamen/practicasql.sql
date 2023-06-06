
-- CREACIÓN DE LA BASE DE DATOS. 

CREATE DATABASE examenHospital; 
USE examenHospital;

-- CREACIÓN DE LA TABLA PACIENTE. 

CREATE TABLE paciente ( 

ID INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR (25) NOT NULL , 
FechaNacimiento DATE NOT NULL,
Sexo ENUM ('Hombre', 'Mujer'), 
FechaAtencion DATE NOT NULL, 
PRIMARY KEY (ID, FechaAtencion)

);

-- CREACIÓN DE LA TABLA DOCTOR

CREATE TABLE doctor (

ID INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR (25) NOT NULL , 
HoraAtencion TIME NOT NULL, 
ID_Especialidad INT NOT NULL,

FOREIGN KEY (ID_Especialidad) REFERENCES especialidad (ID),
PRIMARY KEY (ID, HoraAtencion)


);

-- CREACIÓN DE LA TABLA ESPECIALIDAD

CREATE TABLE especialidad (

ID INT NOT NULL, 
AnosEstudio INT NOT NULL, 
NombreEspecialidad VARCHAR (25) NOT NULL,
PRIMARY KEY (ID)

);

-- CREACIÓN DE LA TABLA PacienteXDoctor

CREATE TABLE pacientedoctor  (

ID_Paciente INT NOT NULL, 
ID_Doctor INT NOT NULL, 
FechaAtencion DATE NOT NULL, 
HoraAtencion TIME NOT NULL,

FOREIGN KEY (ID_Paciente) REFERENCES paciente (ID),
FOREIGN KEY (ID_Doctor) REFERENCES doctor (ID), 
FOREIGN KEY (FechaAtencion) REFERENCES paciente (FechaAtencion), 
FOREIGN KEY (HoraAtencion) REFERENCES doctor (HoraAtencion)

);



