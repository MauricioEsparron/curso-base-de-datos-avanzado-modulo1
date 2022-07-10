/*Restricciones*/
Create Database BDLesson3
go

/*Abrir la BD*/
Use BDLesson3
go

/*Creando Schemas*/
Create Schema Ventas
go

Create Schema RRHH
go

Create Schema Mkt
go

/*Creando Tabla Pais*/
Create Table Ventas.Pais
(
	idPais int not null,
	nompais varchar(50) not null
)
go

/*Crear la llave primaria*/
alter table Ventas.Pais
add constraint PKPais primary key (idPais)
go

/*Ingresar datos*/
Insert Ventas.Pais
Values
(99, 'Uganda'),
(10, 'Inglaterra')
go

/*Consultar*/
select * from Ventas.Pais
go

/*Eliminar la restricción LLave primaria*/
alter table Ventas.Pais
drop constraint PKPais
go

/*Crear la llave primaria no clusterizada*/
alter table Ventas.Pais
add constraint PKPais primary key nonclustered(idpais)
go


/*Ingresar datos*/
Insert Ventas.Pais
Values
(20, 'Uruguay'),
(12, 'Venezuela')
go

/*Consultar*/
select * from Ventas.Pais
go

/*Constraint Foreign Key*/
Use BDLesson3
go

/*Crear la tabla Cliente*/
Create Table Ventas.Cliente
(
	idCli	char(5)	not null,
	nomCli	varchar(50) not null,
	dir_cli varchar(50) not null,
	idPais	int not null
)
go

/*Crear la llave la primaria a tabla cliente*/
alter table Ventas.Cliente
add constraint PKCliente primary key(idCli)
go

/*Crear la llave foránea en la tabla cliente
para referenciar con la tabla pais*/
alter table Ventas.Cliente
add constraint FKpaisCliente foreign key (idPais) references Ventas.Pais
go

Insert Ventas.Cliente Values
('C05','Juanito','sin numero', 20),
('C03','Anita','los Angeles 1005', 12),
('C01','Juanito','La esquina 505', 20)
go

/*validamo el funcionamiento del constraint*/
Insert Ventas.Cliente Values
('C02','Manolito','El chaparral', 99)
go

select * from Ventas.Cliente
select * from Ventas.Pais
go

/*si el codigo de pais esta siendo usado no lo borra*/
delete from Ventas.Pais where idPais = 20
go

/*si el codigo de pais no esta siendo usado lo borra*/
delete from Ventas.Pais where idPais = 10
go

/*Eliminar llave foranea*/
alter table Ventas.Cliente
drop constraint FKPaisCliente
go

/*Crear la llave for�nea en la tabla cliente
para referenciar con la tabla pais y permita eliminacion en cascada*/
alter table Ventas.Cliente
add constraint FKPaisCliente foreign key (idPais) references Ventas.Pais
on delete cascade
go

delete from Ventas.Pais where idPais = 20
go
/* Constraint UNIQUE*/
Use BDLesson3
go

/*Crear tabla Tienda*/
Create Table MKT.Tienda
(
codTie char(5) not null,
nomTie Varchar(50) not null,
dirTie Varchar(50) not null
)
go

/*Creando restricci�n Unique Simple en la tabla pais*/
select * from Ventas.Pais
go

alter table Ventas.Pais
add constraint UQnompais unique(nomPais)
go

/*probamos el funcionamiento de la restricción*/
Insert Ventas.Pais
Values
(30, 'Brasil')
go

/*Creando restricci�n Unqiue Compuesto en la tabla Tienda*/
alter table Mkt.Tienda
add constraint UQnompais unique (nomTie, dirTie)
go

insert Mkt.Tienda values
('T01','El casero','Av. Lima 1000'),
('T02','Los mas mas','Av. Aviacion 515')
go

select * from Mkt.Tienda
go

/*validamos la restricción Unqiue Compuesta*/
insert Mkt.Tienda values
('T03','El casero','Av. Lima 1000')
go

/*Constraint Null, Not Null*/

Use BDLesson3
go

/*Creando tabla con restricci�n Null-not null*/
Create Table dbo.Emple
(
	codEmp	char(8) not null,
	nomEmp	varchar(50) not null,
	nroLicEmp Char(12) null,
	ctaTwet	varchar(15) null,
	emailEmp	 varchar(15) null
)
go

select * from Emple
go

insert Emple (codEmp, nomEmp) values
('EMP01','Silevestre Stallone')
go

/*validamos  la restricción Null-not null*/
insert Emple (codEmp) values
('EMP01')
go

insert Emple values
('EMP01','Thalia',null,null,null)
go

/*Constraint Default*/
Use BDLesson3
go

Create Table dbo.Producto
(
idProd		char(5)		not  null,
nomProd		varchar(50)	not null,
umeProd		varchar(50),
preProd		smallMoney,
catProd		varchar(50),
tipProd		Varchar(20)
)
go

select * from Producto
go

/*Insertar 01 registro*/
insert Producto values
('PRD01','CUA CUA',null,null,null,null)
go

--------
insert Producto (idProd, nomProd) values
('PRD01','SUBLIME')
go

/*Consultar*/
Select * from dbo.Producto
go

/*Crear un valor por default a la tabla producto
campo preprod, cuyo valor predefinido ser� 0*/
alter table Producto
add constraint DFpreProd default '0' for preProd
go

insert Producto (idProd, nomProd) values
('PRD03','DOÑA PEPA')
go

/*Crear un valor por default a la tabla producto
campo tipProd, cuyo valor predefinido ser� Nacional*/
alter table Producto
add constraint DFtipProd default 'Nacional' for tipProd
go

/*Otra vez ingresar datos*/
Insert dbo.Producto (idprod, nomprod) Values
('PRD04','Arroz')
go

/*Mostrar los valores*/
Select * from dbo.Producto
go

/*Insertar valores*/
Insert dbo.Producto  Values
('PRD04','Azúcar',null,default,null,default)
go

Insert dbo.Producto  Values
('PRD06','Leche','litro',4,'abarrotes','importado')
go

/*Mostrar los valores*/
Select * from dbo.Producto
go

/*Constraint CHECK*/
Use BDLesson3
go

/*Crear una restriccion Check al campo Umed
de la tabla Producto*/
select * from Producto
go

alter table Producto
add constraint CKumeProd check
(umeProd in  ('litro','kg','unidad'))
go

/*validamos la restriccion Check*/
Insert dbo.Producto  Values
('PRD07','Pan','docena',default,null,default)
go

/*Constraint Identity*/
Use BDLesson3
go

/*Crear una tabla con un campo Identity*/
Create Table Ventas.Boleta
(
	nroBol		int Identity (1001,1),
	fecBol		date,
	valBol		smallmoney
)
go

/*Ingresar registros a esta tabla*/
Insert Ventas.Boleta Values
(getdate(),150),
(getdate()+1,250)
go

/*Consultar los registros*/
select * from Ventas.Boleta
go

/*Crear una tabla Formulario en el esquema dbo,
con los campos nroForm, y fecForm. El campo
nroForm ser� un correlativo a partir 2005, incrementando
cada 10*/
create table Formulario
(	
	nroForm int identity (2005,10),
	fecForm date
)
go

Insert Formulario Values
(getdate()),
(getdate()+1),
(getdate()+2)
go

select * from Formulario
go

/*Uso del Identity*/
Use BDLesson3
go

/*Consultar la tabla que tiene Identity*/
Select * from Ventas.Boleta;
go

/*Reiniciar el identity en 2000*/
dbcc checkIdent ('Ventas.Boleta', Reseed,2000)
go

/*Ingresar nuevos valores a la tabla Boleta*/
Insert Ventas.Boleta Values
('10/10/2030',2500),
('11/11/2030',4500)
go

/*Consultar la tabla que tiene Identity*/
Select * from Ventas.Boleta;
go

/*Crear una restricci�n Check a la tabla Boleta
campo fecBol, para que sea mayor o igual a la fecha actual.
La restricci�n no afecta a los datos ya ingresados*/
alter table Ventas.boleta with nocheck
add constraint CKfecBol check (fecBol >= getdate())
go

/*Script Indices*/
Use Negocios
go

/*Consultar los �ndice creados en la BD*/
select * from sys.indexes
go

/*Crear un �ndice normal simple por el campo
nombre del cliente*/
select * from Ventas.Clientes
go

create index Idx_Cliente
on Ventas.clientes (NomCliente)
go

/*Crear un �ndice normal simple por el campo
nombre del proveedor, pero ordenado de forma descendente*/
select * from Compras.proveedores
go

create index Idx_NomProveedor
on Compras.proveedores (NomProveedor)
go

/*Eliminar �ndices*/
drop index Compras.proveedores.Idx_NomProveedor
go

drop index Compras.proveedores.Idx_Cliente
go

/*Crear un �ndice compuesto y �nico por nom y ap de los
empleados*/
create unique index Idx_NomApeEmpe
on RRHH.EMPLEADOS (NomEmpleado, ApeEmpleado)
go

/*Crear un �ndice simple en la tabla Productos por NomProducto, incluyendo
los campo IdProveedor , IdCategoria)*/
create index Idx_Producto
on Compras.productos (NomProducto)
include (idProveedor,IdCategoria)
go


