/* ********Script INSERT******** */
Use Negocios
go

/*Insertar datos a la tabla Categoria*/
select * from Compras.categorias
go

insert  Compras.categorias (IDCategoria,NombreCategoria)
values (77,'Panaderia')
go

/*Consultar */
Select * from Compras.categorias
go

insert  Compras.categorias (IDCategoria,NombreCategoria)
values (88,'Golosinas'),
	   (99,'Cereales'),
	   (66,'Menajeria')
go

insert  Compras.categorias
values (55,'Electro', 'tv, refrigeradoes, planchas')
go

/*Insertar a la tabla categoria registros desde la BD Northwind
tabla categories*/

use Northwind
go

select * from Categories
go

 insert Compras.Categorias (IdCategoria,NombreCategoria)
	select CategoryID+20,CategoryName from Northwind.dbo.Categories
go

/* ********Script BULK INSERT*********** */
/*Importar los datos de los clientes almacenados en el archivo de texto: 
 Clientes.txt hacia la tabla Clientes del esquema Ventas de la BD Negocios*/

 bulk insert Ventas.clientes
 from 'D:\clientes.txt'
 with (fieldterminator = ',',
	   rowterminator = '\n')
 go

/*Consultar*/
Select * from Ventas.clientes
go

/* **********Script DELETE********* */
Use Negocios
go

/*Eliminar los clientes cuyo codigo inicie con 'C0'*/
delete from Ventas.clientes
where IdCliente like 'C0%'
go

select * from Ventas.clientes
go

/* *****Script TRUNCATE TABLE****** */
Use Negocios
go

/*Crear tabla con identity*/
Create Table dbo.Consumer
(
id		int identity,
fullname	varchar(50)
)
go

/*Insertar registros a esta tabla desde la tabla clientes.*/
select * from Ventas.clientes
go

Select * from Consumer
go

insert Consumer
select NomCliente from Ventas.Clientes
go

/*Consultar*/
Select * from dbo.Consumer
go

/*Eliminar todos los registros de la tabla Consumer usando Delete*/
delete from Consumer
go

/*Consultar*/
Select * from dbo.Consumer
go

/*Volver a Insertar registros a esta tabla consumer desde la tabla clientes.*/
insert Consumer
select NomCliente from Ventas.Clientes
go

/*Consultar*/
Select * from dbo.Consumer
go

/*Eliminar todos los registros de la tabla Consumer usando Truncate Table*/
truncate table Consumer
go

/*Consultar*/
Select * from dbo.Consumer
go

/*Volver a Insertar registros a esta tabla consumer desde la tabla clientes.*/
insert Consumer
select NomCliente from Ventas.Clientes
go


/*Consultar*/
Select * from dbo.Consumer
go


/* *******UPDATE******** */
Use Negocios
go

--Visualizar registros de la tabla Cliente
Select * from Ventas.clientes
go

/*Actualizar los datos del cliente Cactu*/
update  Ventas.clientes
set NomCliente = 'Bembos Burger',
	DirCliente = 'Las Begonias 123',
	idPais = '001',
	fonoCliente = '01-123456789'
where	IdCliente = 'Cactu'
go


--Visualizar registros de la tabla Cliente
Select * from Ventas.clientes
go

/*otro ejemplo*/
/*Actualizar el precio de los productos incrementando 10%, solo si han 
 sido suministrados por proveedores de Colombia*/

update Compras.productos
set PrecioUnidad = PrecioUnidad * 1.10
where IdProveedor in (	select IdProveedor
						from Compras.proveedores
						where IdPais in (	Select Idpais
											from Ventas.paises
											where NombrePais = 'Colombia'))
go

select * from Compras.productos
go

/* ******MERGE******* */
Use Negocios
go

/*Implemente un escenario para actualizar o insertar un registro a la tabla
  paises: si existe el codigo del pais, actualice su nombre; 
  sino inserte el registro a la tabla */

/*Consultar Datos*/
Select * from Ventas.paises
go

/*Utilizando Bloque SQL*/
Begin
	declare @v_IdPais char(3), @v_nomPais varchar(100)
	set @v_IdPais = '009'
	set @v_nomPais = 'Brasil' 
		merge Ventas.paises as tarjet
		using (select @v_IdPais,@v_nomPais) as source  (IdPais,NombrePais)
		on (source.IdPais = tarjet.IdPais)
		when matched then
			update set tarjet.NombrePais = source.nombrePais
		when not matched then
			insert values(source.Idpais,source.Nombrepais);
end
go

/*Consultar Datos*/
Select * from Ventas.paises
go

/*Utilizando Bloque SQL*/
Begin
	declare @v_IdPais char(3), @v_nomPais varchar(100)
	set @v_IdPais = '010'
	set @v_nomPais = 'Brasil' 
		merge Ventas.paises as tarjet
		using (select @v_IdPais,@v_nomPais) as source  (IdPais,NombrePais)
		on (source.IdPais = tarjet.IdPais)
		when matched then
			update set tarjet.NombrePais = source.nombrePais
		when not matched then
			insert values(source.Idpais,source.Nombrepais);
end
go

/*Consultar Datos*/
Select * from Ventas.paises
go

/*Utilizando Bloque SQL*/
Begin
	declare @v_IdPais char(3), @v_nomPais varchar(100)
	set @v_IdPais = '010'
	set @v_nomPais = 'Qatar' 
		merge Ventas.paises as tarjet
		using (select @v_IdPais,@v_nomPais) as source  (IdPais,NombrePais)
		on (source.IdPais = tarjet.IdPais)
		when matched then
			update set tarjet.NombrePais = source.nombrePais
		when not matched then
			insert values(source.Idpais,source.Nombrepais);
end
go

/*Consultar Datos*/
Select * from Ventas.paises
go


