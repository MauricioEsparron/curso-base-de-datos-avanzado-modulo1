
/*VISUALIZAR LAS BD DELS SISTEMA*/

use master 
go

select * from sys.databases
go

/* crear la bd BDNegocios por defecto*/

create database BDNegocios
go

/*visulaizar las propiedades de la BD*/

exec sp_helpdb BDNegocios
go

/*crear BD personalizada*/

create database BDNegocios2
on(
	name = Negocios1_Data,
	filename = 'D:\BASE_DATOS\Negocios1_Data.mdf',
	size = 10 mb,
	maxsize = 50 mb,
	filegrowth = 3 mb)
log on(
		name = Negocios1_Log,
		filename = 'D:\BASE_DATOS\Negocios1_log.ldf',
		size = 10 mb,
		maxsize = 50 mb,
		filegrowth = 10 mb)
go		

/*visulaizar las propiedades de la BD*/

exec sp_helpdb BDNegocios2
go

/*modificar el tamaño y el crecimiento del archivo de datos*/

alter database BDNegocios2
modify file(
	name = Negocios1_Data,
	size = 20mb,
	filegrowth = 5mb)
go

/*modificar el tamaño maximo del logfile*/

alter database BDNegocios2
modify file(
	name = Negocios1_log,
	maxsize = 200mb)
go

/*modificar la BD para agregar un datafile*/

alter database BDNegocios2
add file(
	name = Negocios1_DataS1,
	filename = 'D:\BASE_DATOS\Negocios1_DataS1.ndf')
go

/*visulaizar las propiedades de la BD*/

exec sp_helpdb BDNegocios2
go

/*modificar la BD para agregar un logfile*/

alter database BDNegocios2
add log file(
	name = Negocios1_log2,
	filename = 'D:\BASE_DATOS\Negocios1_log2.ldf')
go

/*separar la BD manteniendo us archivos logicos*/

exec master.dbo.sp_detach_db @dbname = BDNegocios2
go

/*adjuntar la base de datos a la nueva ubicacion*/

create database BDNegocios2
on
	(filename = 'D:\NUEVA_BASE\Negocios1_Data.mdf'),
	(filename = 'D:\NUEVA_BASE\Negocios1_DataS1.ndf'),
	(filename = 'D:\NUEVA_BASE\Negocios1_log.ldf'),
	(filename = 'D:\NUEVA_BASE\Negocios1_log2.ldf')
for attach
go

/*visulaizar las propiedades de la BD*/

exec sp_helpdb BDNegocios2
go

/*modificar la BD para agregar filegroups*/

alter database BDNegocios2
add filegroup [FGAdmin]
go

alter database BDNegocios2
add filegroup [FGComercial]
go

/*adicionar un datafile al filegroup [FGAdmin]*/

alter database BDNegocios2
add file(
name = Empleado_Data,
filename = 'D:\NUEVA_BASE\Empleado_Data.ndf'
) to filegroup [FGAdmin]
go

/*usar la BDNegocios2*/
use BDNegocios2
go

/*crear una tabla en el filegroup [FGAdmin]*/


create table Personal
(	
	cod char(5),
	nom varchar(10)
)on [FGAdmin]
go






