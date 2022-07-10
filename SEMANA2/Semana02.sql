/*Manejo de Schemas*/
--Creando base de Datos BDTienda con opciones por default

create database BDTienda
go

--Abrir la Base de datos
use BDTienda
go

/*Crear 3 esquema en la base de datos (RRHH,Sales,Purchase)*/
create schema RRHH
go

create schema Sales
go

create schema Purchase
go

/*Ver los schemas*/
select * from sys.schemas
go

/*Creando un objeto tabla sin esquema definido*/
create table tablaX
(	
	cod char(5),
	nom varchar(10))
go

/*Crear un objeto tabla (Personal) en el esquema RRHH*/
create table RRHH.Personal
(	cod char(5),
	nom varchar(10))
go

/*Crear un objeto tabla (Cliente) en el esquema SALES*/
create table Sales.Cliente
(	cod char(5),
	nom varchar(10))
go

/******* Tipo de dato de usuario *******/
Use BDTienda
go

/*Creando tipo de dato de usuario usando sp_addType*/
exec sp_addType Cadena,'varchar(50)','not null'
go

exec sp_addType Fecha,'date','not null'
go

/*Utilizando el tipo de dato del usuario creado en una tabla*/
create table TBContacto
(	nombre  Cadena,
	fechanac Fecha)
go

/*Creando tipo de dato de usuario usando Create Type*/
create type NumDoc
from int not null
go

/*Usando tipo de dato de usuario en una tabla*/
create table Bolta
(	nombre  NumDoc,
	fechaBolta Fecha)
go

/*******  Tipo de dato TABLE  *******/
Use BDTienda
go

/*Crendo tipo de dato Table*/
create type TCliente as  table 
(	cod varchar(100) not null,
	nom varchar (100) not null,
	email varchar (100) not null)
go

/*Ahora utilizar el tipo tabla en una variable,
  llenar con registros y mostrarlos*/
  declare @vt_Cliente TCliente
  insert @vt_Cliente values
	('C01','Pepito','pepitoqhotmail.com'),
	('C02','Anita','anita@gamail.com'),
	('C03','Coquito','coquito@yahoo.com')

select *from @vt_Cliente
go

/*******  Tablas de datos  *******/
Use BDTienda
go

/*Creando la tabla Vendedor, en el esquema Sales, 
  en el filegroup Primary utilizando tipo de dato de usuario*/
create table Sales.TVendedor
(	nombreVendedor Cadena,
	fechaNacV Fecha
)on [Primary]
go

/*Modificar la estructura de la tabla para agregar un campo*/
alter table Sales.TVendedor
add ecivil char(1) not null
go

--Ver la estructura
exec sp_help 'Sales.TVendedor'
go

/*Modificar la estructura de la tabla para eliminar un campo*/
alter table Sales.TVendedor
drop column ecivil
go

/******  Tabla Particionada  *******/
/*Preparando la Base de Datos, y Filegroups*/
/*Crear una base de datos*/
create database BDParticion
go

/*Creando particiones (filegroups) en la BD*/
alter database BDParticion
add filegroup [FG2000]
go

alter database BDParticion
add filegroup [FG2010]
go

alter database BDParticion
add filegroup [FGdemas]
go

/*Adicionar un datafile (ubicado en la carpeta data) 
  a cada Filegroup*/
alter database BDParticion
add file
(
	name = TParticion1_Data,
	filename = 'D:\DATA\TParticion1_Data.ndf'
)to filegroup [FG2000]
go

alter database BDParticion
add file
(
	name = TParticion2_Data,
	filename = 'D:\DATA\TParticion2_Data.ndf'
)to filegroup [FG2010]
go

alter database BDParticion
add file
(
	name = TParticion3_Data,
	filename = 'D:\DATA\TParticion3_Data.ndf'
)to filegroup [FGdemas]
go

/*Abrir la Base de datos*/
use BDParticion
go

/**Primero se crea la funci�n de partici�n*/
create partition function fnp_PedidoXAño (date)
as range right for values ('2000-01-01','2010-01-01')
go

/**Luego se crea un esquema de partici�n*/
create partition scheme sp_PedidoXAño
as partition fnp_PedidoXAño
to ([FG2000],[FG2010],[FGdemas])
go

/*Ahora se crea la tabla particionada*/
create table TBPedido
(	nroPedido int not null,
	inCliente char (5) not null,
	fechaPedido Date not null,
	montoPedido smallmoney not null
)on sp_PedidoXAño (fechaPedido)
go

/*Configurar formato de fecha*/
set dateformat DMY
go

/*Llenar datos*/
insert TBPedido values
	('101','C01','01/04/2022',8500),
	('102','C02','01/04/2012',3500),
	('103','C03','01/04/2000',1500),
	('104','C04','01/04/1990',450)
go

/*Visualizar los registros de la tabla y en que partici�n se encuentra*/
select *,
	$partition.fnp_PedidoXAño(fechaPedido) AS [Nro de Particion]
from TBPedido
go

