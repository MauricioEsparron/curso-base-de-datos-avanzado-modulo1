
/*Utilice la Base de Datos BDINMOBILIARIA*/
use BDInmobiliaria
go

/*Resolver los siguientes requerimientos:

01. Ingrese los siguientes registros:

	SCHEMA -> COMERCIAL
	
	TABLA		ESTADO
	COD_EST		DESC_EST
	EST001		OCUPADO
	EST002		DESOCUPADO
	EST003		VIGENTE
	EST004		VENCIDO
	EST005		HABILITADO
	EST006		DESHABILITADO*/

insert Comercial.ESTADO 
values	('EST001','OCUPADO'),
		('EST002','DESOCUPADO'),
		('EST003','VIGENTE'),
		('EST004','VENCIDO'),
		('EST005','HABILITADO'),
		('EST006','DESHABILITADO')
go
	
select * from Comercial.ESTADO 
go


/*
	SCHEMA
TABLA
	COD_EDIF      NOM_EDIF                     DIRECC_EDIF		   CODPOSTAL_EDIF  AREA_TOTAL_EDIF	AREA_CONSTRUIDA_EDIF   REFERENCIA_EDIF   COD_EST

	('EDF001'	,'La Posadera'				,'Jr. Lima 123'				,'L-01'			,450				,NULL					,NULL		  ,'EST005'),
	('EDF002'	,'El Corralito'			,'Av. Saenz Peña 357'			,'L-14'			,178				,NULL					,NULL		  ,'EST006'),
	('EDF003'	,'Los Alamos'				,'Av. Del Río 666'			,'L-21'			,246				,NULL					,NULL		  ,'EST005'),
	('EDF004'	,'El Aguajal'				,'Jr. Urdanivia 875'		,'L-21'			,285				,NULL					,NULL		  ,'EST006'),
	('EDF005'	,'Los Cupisnique'			,'Av. La Mar 966'			,'L-14'			,178				,NULL					,NULL		  ,'EST005'),
	('EDF006'	,'El Indice'				,'Av. Las Dromelias 777'	,'L-01'			,246				,NULL					,NULL		  ,'EST006'),
	('EDF007'	,'Los Guerreros Moche'		,'Av. De los acá'			,'L-17'			,246				,NULL					,NULL		  ,'EST006')
*/

insert Arquitectura.EDIFICIOS
values	('EDF001'	,'La Posadera'				,'Jr. Lima 123'				,'L-01'			,450				,NULL					,NULL		  ,'EST005'),
		('EDF002'	,'El Corralito'			,'Av. Saenz Peña 357'			,'L-14'			,178				,NULL					,NULL		  ,'EST006'),
		('EDF003'	,'Los Alamos'				,'Av. Del Río 666'			,'L-21'			,246				,NULL					,NULL		  ,'EST005'),
		('EDF004'	,'El Aguajal'				,'Jr. Urdanivia 875'		,'L-21'			,285				,NULL					,NULL		  ,'EST006'),
		('EDF005'	,'Los Cupisnique'			,'Av. La Mar 966'			,'L-14'			,178				,NULL					,NULL		  ,'EST005'),
		('EDF006'	,'El Indice'				,'Av. Las Dromelias 777'	,'L-01'			,246				,NULL					,NULL		  ,'EST006'),
		('EDF007'	,'Los Guerreros Moche'		,'Av. De los acá'			,'L-17'			,246				,NULL					,NULL		  ,'EST006')
go
	
select * from Arquitectura.EDIFICIOS
go

/*02. La Inmobiliaria acaba de recibir una lista de Edificios en Flat File, deberá ingresar 
	a la tabla Edificios utilizando BULK INSERT. (En Experimentar se encuentra el 
	archivo NuevosEdificios.TXT)
	
		Propiedad						  Valor
		
		Primera fila de registro		 1
		Separador de campos				(,) coma
		Separador de registro			(\n) enter*/

 bulk insert Arquitectura.EDIFICIOS
 from 'D:\NuevosEdificios.txt'
 with (fieldterminator = ',',
	   rowterminator = '\n')
 go

 /*03. Inserte registros a la tabla Departamentos desde la Tabla TBDEPA ubicada en la 
Base de Datos BDCONSTRUCCION.*/


use BDConstruccion
go

select * from dbo.TBDEPA
go

use BDInmobiliaria
go

insert into BDInmobiliaria.Arquitectura.DEPARTAMENTOS (COD_EDIF,COD_DEP,AREA_TOTAL_DEP,AREA_CONSTRUIDA_DEP)
	select COD_EDIF,COD_DEP,AREA_TOTAL_DEP,AREA_CONSTRUIDA_DEP from BDConstruccion.dbo.TBDEPA
go


select * from Arquitectura.DEPARTAMENTOS
go
