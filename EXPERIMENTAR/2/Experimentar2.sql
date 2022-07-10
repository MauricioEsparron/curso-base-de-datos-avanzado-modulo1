

/*Cree la base de datos BDArcor con valores de propiedades predeterminadas 
validando su existencia, eliminándola si existiera.*/
if db_id ('BDArcor')is not null
begin drop database BDArcor
end
go

create database BDArcor
go

/*abrir la BD y crear los esquemas SCHAcad,SCHAdmin,SCHFinance */
use BDArcor
go

create schema SCHAcad 
go

create schema SCHAdmin
go

create schema SCHFinance 
go

/*En la base de datos, crear los siguientes tipos de datos definidos por el usuario
utilizando el comando CREATE TYPE:

	UDTIdNum  -> Identificador numérico -> Smallint
	UDTIdCad  -> Identificador cadena   -> Char(8)
	UDTCad    -> Cadena                 -> Varchar(50)
	UDTTiempo -> Fecha y hora           -> Datetime
	UDTMonto  -> Monto monetario        -> SmallMoney*/

create type UDTIdNum 
from Smallint
go

create type UDTIdCad 
from Char(8)
go

create type UDTCad 
from Varchar(50)
go

create type UDTTiempo 
from Datetime
go

create type UDTMonto 
from SmallMoney
go

/*Crear las siguientes tablas, en los esquemas indicados y utilizando los tipos de
datos creados previamente:

	Tabla   -> TBDocente
	Esquema -> SCHAcad
	
	Campos: 

	>Nombre<      >Descripción<        >Tipo de Dato<   >Nulo<
	codDoce   -> Código de Docente	    -> UDTIdCad   ->  NO
	nomDoce   -> Nombre de Docente      -> UDTCad     ->  NO
	apDoce    -> Apellidos del Docente  -> UDTCad     ->  NO
	fnaDoce   -> Fecha de nacimiento    -> UDTTiempo  ->  NO
	sueDoce   -> Sueldo del Docente     -> UDTMonto   ->  NO*/

create table SCHAcad.TBDocente
(		codDoce  UDTIdCad not null,
		nomDoce  UDTCad not null,
		apDoce   UDTCad not null,
		fnaDoce  UDTTiempo not null,
		sueDoce  UDTMonto not null)
go

/*
	Tabla   -> TBOrden
	Esquema -> SCHAdmin
	
	Campos:
	
	>Nombre<      >Descripción<    >Tipo de Dato<   >Nulo<
	nroOrden  -> Número de Orden   -> UDTIdNum    ->  NO
	fecOrden  -> Fecha de Orden    -> UDTTiempo   ->  NO
	fecPago   -> Fecha de Pago     -> UDTTiempo   ->  NO
	mntOrden  -> Monto de la Orden -> UDTMonto    ->  NO*/

create table SCHAdmin.TBOrden
(	nroOrden UDTIdNum not null,
	fecOrden UDTTiempo not null,
	fecPago UDTTiempo not null,
	mntOrden UDTMonto not null)
go


/*Abrir la BD Master y modificar la base de datos BDArcor para adicionar 03
filegroups: FG1000, FG2000 y FG3000*/alter database BDArcoradd filegroup [FG1000]goalter database BDArcoradd filegroup [FG2000]goalter database BDArcoradd filegroup [FG3000]go/*Modifique la base de datos BDArcor para adicionar un DataFile en cada filegroup
creado recientemente. Los Datafiles estarán ubicados en la carpeta C:\ArcorData
con valores predeterminados*/

alter database BDArcor
add file(
		name = Arcor1_Data,
		filename = 'D:\ArcorData\Arcor1_Data.ndf'
)to filegroup [FG1000]
go

alter database BDArcor
add file(
		name = Arcor2_Data,
		filename = 'D:\ArcorData\Arcor2_Data.ndf'
)to filegroup [FG2000]
go

alter database BDArcor
add file(
		name = Arcor3_Data,
		filename = 'D:\ArcorData\Arcor3_Data.ndf'
)to filegroup [FG3000]
go

/*Abrir la base de datos BDArcor y crear una función de partición utilizando Range Left:
	
	Función  -> FNP_Numeros

	Partición1  ->  Valores hasta 1000
	Partición2  ->  Valores desde 1001 hasta 2000
	Partición3  ->  El resto de valores mayores a 2000*/

use BDArcor
go

create  partition function FNP_Numeros (int)
as range left for values('1000','2000')
go

/*Crear un esquema de partición usando la función de partición creada:

	Esquema Partición -> SP_Numeros

	Partición 1  -> FG1000
	Partición 2  -> FG2000
	Partición 3  -> FG3000*/

create partition scheme SP_Numeros
as partition fnp_Numeros
to ([FG1000],[FG2000],[FG3000]) 
go

/*Crear una tabla particionada por el campo NRO_FACT:

	Tabla particionada  ->  TBFactura
		
	Nombre		Descripción		    Tipo de Dato	  Nulo
	numFact		Número de Factura		Int				NO
	fecFact		Fecha de Factura		Date			NO
	codPrv		Código de proveedor		Char(5)			NO
	monto		Monto de la factura		SmallMoney		NO*/

create table TBFactura
(	numFact				Int				not null,
	fecFact				Date			not null,
	codPrv				Char(5)			not null,
	monto				SmallMoney		not null
)on SP_Numeros (numFact)
go









