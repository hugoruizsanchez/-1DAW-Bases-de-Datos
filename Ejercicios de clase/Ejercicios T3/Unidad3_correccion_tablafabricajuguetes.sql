---------------------------------------------------------------------------------
-- Ejercicio 1, base de datos Fabrica de Juguetes
---------------------------------------------------------------------------------
DROP DATABASE IF EXISTS bd_tarde;

---------------------------------------------------------------------------------
-- Creación de la base de datos                                            
---------------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS bd_tarde;

---------------------------------------------------------------------------------
-- Selección de base de datos                                            
---------------------------------------------------------------------------------
USE bd_tarde;

---------------------------------------------------------------------------------
-- Sentencias de creación de tablas                                            
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- Tabla Plantas
---------------------------------------------------------------------------------
CREATE TABLE Plantas (
	Color VARCHAR(20) NOT NULL PRIMARY KEY,
	Superficie DECIMAL (10,2) NOT NULL
); 

---------------------------------------------------------------------------------
-- Tabla Procesos
---------------------------------------------------------------------------------
CREATE TABLE Procesos (
	Nombre VARCHAR(30) NOT NULL PRIMARY KEY,
	GradoComplejidad ENUM ("Muy Baja", "Baja", "Media", "Alta", "Muy Alta") NOT NULL
); 

---------------------------------------------------------------------------------
-- Tabla PlantasProcesos
---------------------------------------------------------------------------------
CREATE TABLE PlantasProcesos (
	ColorPlanta VARCHAR(20) NOT NULL,
	NombreProceso VARCHAR(30) NOT NULL,
	PRIMARY KEY (ColorPlanta, NombreProceso),
	FOREIGN KEY (ColorPlanta) REFERENCES Plantas(Color),
	FOREIGN KEY (NombreProceso) REFERENCES Procesos(Nombre)
); 

---------------------------------------------------------------------------------
-- Tabla Maquinas
---------------------------------------------------------------------------------
CREATE TABLE Maquinas (
	Numero INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Marca VARCHAR(20) NOT NULL,
	NumMaquinaQueLaReemplaza INT,
	ColorPlantaContiene VARCHAR(20) NOT NULL,
	FOREIGN KEY (NumMaquinaQueLaReemplaza) REFERENCES Maquinas(Numero),
	FOREIGN KEY (ColorPlantaContiene) REFERENCES Plantas(Color)
); 

---------------------------------------------------------------------------------
-- Tabla Tecnicos
---------------------------------------------------------------------------------
CREATE TABLE Tecnicos (
	DNI VARCHAR(9) NOT NULL PRIMARY KEY,
	Nombre VARCHAR(20) NOT NULL,
	Apellidos VARCHAR(50) NOT NULL,
	FechaNacimiento DATE
); 

---------------------------------------------------------------------------------
-- Tabla TelefonosContacto
---------------------------------------------------------------------------------
CREATE TABLE TelefonosContacto (
	DNIContacto VARCHAR(9) NOT NULL,
	TelefonoContacto VARCHAR(12) NOT NULL,
	PRIMARY KEY (DNIContacto , TelefonoContacto),
	FOREIGN KEY (DNIContacto) REFERENCES Tecnicos(DNI)
); 

---------------------------------------------------------------------------------
-- Tabla MaquinasOperanTecnicos
---------------------------------------------------------------------------------
CREATE TABLE MaquinasOperanTecnicos (
	NumeroMaquina INT NOT NULL,
	DNITecnico VARCHAR(9) NOT NULL,
	FechaInicio DATE NOT NULL,
	FechaFin DATE NOT NULL,
	Turno VARCHAR(7) NOT NULL,
	PRIMARY KEY (NumeroMaquina,DNITecnico,FechaInicio),
	FOREIGN KEY (NumeroMaquina) REFERENCES Maquinas(Numero),
	FOREIGN KEY (DNITecnico) REFERENCES Tecnicos(DNI)
);

---------------------------------------------------------------------------------
-- Añadir control restricción valores Turno
---------------------------------------------------------------------------------
ALTER TABLE MaquinasOperanTecnicos 
	ADD CONSTRAINT check_Turno CHECK (Turno IN ('Mañana', 'Tarde', 'Noche'));
