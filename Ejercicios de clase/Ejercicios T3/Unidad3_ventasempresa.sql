-- -------------------------------------------------------------------------------
-- EJERCICIO 2 -> BASE DE DATOS MODELO VENTAS DE UNA EMPRESA.
-- // Creación de la base de datos //
-- -------------------------------------------------------------------------------
DROP DATABASE bd_ventaempresa;
CREATE DATABASE IF NOT EXISTS bd_ventaempresa;

-- -------------------------------------------------------------------------------
-- SELECCIÓN DE LA BASE DE DATOS.
-- -------------------------------------------------------------------------------

USE bd_ventaempresa;

-- -------------------------------------------------------------------------------
-- CREACIÓN DE LA TABLA CATEGORÍAS. 
-- -------------------------------------------------------------------------------

CREATE TABLE Categorias (

IdCat VARCHAR (25) NOT NULL, 
Nombre VARCHAR (25) NOT NULL, 
Descripcion VARCHAR (50) NOT NULL,
PRIMARY KEY (IdCat)

);

-- -------------------------------------------------------------------------------
-- CREACIÓN DE LA TABLA PRODUCTOS. 
-- -------------------------------------------------------------------------------



CREATE TABLE Productos (

IdProd VARCHAR (25) NOT NULL, 
Nombre VARCHAR (25) NOT NULL, 
Precio FLOAT NOT NULL, 
STOCK VARCHAR (25) NOT NULL, 
IdCat VARCHAR (25) NOT NULL, 
PRIMARY KEY (IdProd, Precio, STOCK),
FOREIGN KEY (IdCat) REFERENCES Categorias (IdCat)

);

-- -------------------------------------------------------------------------------
-- CREACIÓN DE LA TABLA PROVEEDORES. 
-- -------------------------------------------------------------------------------

CREATE TABLE Proveedores (

NIF varchar (25) NOT NULL, 
Nombre varchar (25) NOT NULL, 
Telefono varchar (25) NOT NULL, 
Web varchar (50) NOT NULL, 
Provincia varchar (25) NOT NULL, 
Municipio varchar (25) NOT NULL, 
Calle varchar (25) NOT NULL, 
Numero int NOT NULL,
IdProdComercializa varchar (25) NOT NULL, 
FOREIGN KEY  (IdProdComercializa) REFERENCES Productos (IdProd),
PRIMARY KEY (NIF)
);

-- -------------------------------------------------------------------------------
-- CREACIÓN DE LA TABLA VENTAS. 
-- -------------------------------------------------------------------------------

CREATE TABLE Ventas (

NumFactura int NOT NULL, 
Fecha date NOT NULL, 
Descuento float, 
CantidadFinal int NOT NULL,
NIF_DNI varchar (25),
PRIMARY KEY (NumFactura),
FOREIGN KEY (NIF_DNI) REFERENCES Clientes (DNI_NIF)

);

-- -------------------------------------------------------------------------------
-- CREACIÓN DE LA TABLA VENTASPRODUCTOS. 
-- -------------------------------------------------------------------------------

CREATE TABLE VentasProductos (

NumFactura int NOT NULL, 
IdProd VARCHAR (25) NOT NULL,
PrecioProd FLOAT NOT NULL, 
CantidadProd VARCHAR (25) NOT NULL, 
CosteTotalProd float,

PRIMARY KEY (NumFactura, IdProd),
FOREIGN KEY (NumFactura) REFERENCES Ventas (NumFactura),
FOREIGN KEY (IdProd) REFERENCES Productos (IdProd), 
FOREIGN KEY (PrecioProd) REFERENCES Productos (Precio), 
FOREIGN KEY (CantidadProd) REFERENCES Productos (STOCK)

);

-- -------------------------------------------------------------------------------
-- CREACIÓN DE LA TABLA CLIENTES. 
-- -------------------------------------------------------------------------------

CREATE TABLE Clientes (

DNI_NIF varchar (25) NOT NULL, 
Nombre varchar (25) NOT NULL, 
Provincia varchar (25) NOT NULL, 
Municipio varchar (25) NOT NULL, 
Calle varchar (25) NOT NULL, 
Numero int NOT NULL,
PRIMARY KEY (DNI_NIF)
);

-- -------------------------------------------------------------------------------
-- CREACIÓN DE LA TABLA TELEFONOSONTACTO. 
-- -------------------------------------------------------------------------------
	
CREATE TABLE TelefonosContacto (

TelefonoContacto VARCHAR (25) NOT NULL, 
DNI_NIF VARCHAR (25) NOT NULL, 
FOREIGN KEY (DNI_NIF) REFERENCES Clientes (DNI_NIF), 
PRIMARY KEY (TelefonoContacto)

) 
