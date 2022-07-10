

/*Cree la base de datos BDClinica con valores de propiedades predeterminadas,
validando su existencia, eliminándola si existiera.*/

if db_id ('BDClinica') is not null
begin drop database BDClinica
end 
go

create database BDClinica
go

/*Abrir la base de datos y crear los siguientes esquemas:

	Nombre del Esquema Descripción

	USUARIO   ->  Esquema Usuario
	SERVICIO  ->  Esquema Servicio
*/

use BDClinica
go

create schema USUARIO
go

create schema SERVICIO
go


/*Crear las siguientes tablas, en los esquemas indicados:

	Tabla    ->  TBMedico
	Esquema  ->  SERVICIO
	
	Campos:
	
	Nombre Descripción Tipo de Dato Nulo
	idMed Id del Médico CHAR (5) NO
	nomMed Nombre de Médico VARCHAR (50) NO
	apMed Apellidos del Médico VARCHAR (50) NO
	espMed Especialidad del Médico VARCHAR (50) NO
	colMed Colegiatura del Médico CHAR (12) NO
	
	
	
	Tabla    ->  TBPaciente
	Esquema  ->  USUARIO
	Campos

	Nombre Descripción Tipo de Dato Nulo
	idPac Id del paciente CHAR (5) NO
	nomPac Nombre del paciente VARCHAR (50) NO
	apPac Apellidos del paciente VARCHAR (50) NO
	fnaPac Fecha de nacimiento DATE NO
	fonoPac Teléfono del paciente VARCHAR (10) NO
	
	
	Tabla   ->  TBReceta
	Esquema ->  SERVICIO
	
	Campos: 

	Nombre Descripción Tipo de Dato Nulo
	numRec Número de receta INT IDENTITY(1001) NO
	fecRec Fecha de receta DATE NO
	idPac Id del paciente CHAR (5) NO
	idMed Id del médico CHAR (5) NO*/

create table SERVICIO.TBMedico
(	idMed  CHAR (5) not null,
	nomMed VARCHAR (50) not null,
	apMed VARCHAR (50) not null,
	espMed VARCHAR (50) not null,
	colMed CHAR (12) not null)
go

create table USUARIO.TBPaciente
(	idPac  CHAR (5) not null,
	nomPac VARCHAR (50) not null,
	apPac VARCHAR (50) not null,
	fnaPac DATE not null,
	fonoPac VARCHAR (10) not null)
go

create table SERVICIO.TBReceta
(	numRec INT IDENTITY (1001,1) not null,
	fecRec DATE not null,
	idPac CHAR (5) not null,
	idMed CHAR (5) not null)
go

create table SERVICIO.TBDetalleReceta
(	numRec INT not null,
	codMedicina CHAR (5) not null,
	canti TINYINT not null,
	dosis VARCHAR (50) not null,
	indica VARCHAR (50) not null
)
go

/*la siguiente linea de comando sirve para cambiarle nombre a una tabla
mediante e uso de un procedimiento almacenado*/

--exec sp_rename 'SERVICIO.TBDetalleBoleta','SERVICIO.TBDetalleReceta'

/*Crear las siguientes restricciones:*/
/*
	Tabla TBMedico

	Campo				Restricción					Dominio
	idMed		Primary Key (No clusterizada)
	nomMed				 Unique
	apMed				 Unique	
	espMed				  Check				Pediatría, Ginecología,Cardiología	
	colMed                Check            Debe concluir en 2, 4, 6, 8.

	--

	TablaCampo TBPacienRteestricción Dominio
idPac Primary Key (No clusterizada)
fnaPac Check Nacidos a partir de 1950
fonoPac Check Que inicie con 9, 5, 4, 3 y 2

--

Tabla TBReceta
Campo Restricción Dominio
numRec Primary Key (No clusterizada)
fecRec Default Fecha del sistema
idPac
Foreign Key (con opción de 
actualización en cascada)
idMed Foreign Key (con opción de 
eliminación en cascada)

--

Tabla TBDetalleReceta
Campo Restricción Dominio
numRec Primary Key
(no clusterizada) codMedicina
Canti Check Valores mayor a 0
numRec
Foreign Key (con opción de
eliminación en cascada)

*/


alter table SERVICIO.TBMedico
add constraint PKidMed primary key nonclustered(idMed)
go

alter table SERVICIO.TBMedico
add constraint UQnomMed unique (nomMed)
go

alter table SERVICIO.TBMedico
add constraint UQapMed unique(apMed)
go

alter table SERVICIO.TBMedico
add constraint CKespMed check
(espMed in ('Pediatría', 'Ginecología','Cardiología'))
go

alter table SERVICIO.TBMedico
add constraint CKcolMed check
(colMed in ('2', '4','6','8'))
go

alter table USUARIO.TBPaciente
add constraint PKidPac primary key nonclustered(idPac)
go

alter table USUARIO.TBPaciente
add constraint CKfnaPac check
(fnaPac in ('1950'))
go

alter table USUARIO.TBPaciente
add constraint CKfonoPac check
(fonoPac in ('9', '5','4','3','2'))
go

alter table	SERVICIO.TBReceta
add constraint PKnumRec primary key nonclustered(numRec)
go

alter table SERVICIO.TBReceta
add constraint DFfecRec default getdate() for fecRec;
go

alter table	SERVICIO.TBReceta
add constraint FKidPac foreign key  (idPac) references USUARIO.TBPaciente
on update cascade
go

alter table	SERVICIO.TBReceta
add constraint FKidMed foreign key  (idMed) references SERVICIO.TBMedico
on delete cascade
go

alter table	SERVICIO.TBDetalleReceta
add constraint PKNCnumRec primary key nonclustered(numRec)
go


/*Mensaje 1779, Nivel 16, Estado 0, Línea 211
La tabla 'TBDetalleReceta' ya tiene definida una clave primaria.
Mensaje 1750, Nivel 16, Estado 0, Línea 211
No se pudo crear la restricción o el índice. Ver errores anteriores.*/

alter table	SERVICIO.TBDetalleReceta
add constraint PKNCcodMedicina primary key nonclustered(codMedicina)
go

alter table	SERVICIO.TBDetalleReceta
add constraint CKCanti check (Canti  > 3)
go

alter table SERVICIO.TBDetalleReceta
add constraint FKnumRec foreign key  (numRec) references SERVICIO.TBReceta
on delete cascade
go


/* Crear los siguientes índices:

a. Cree un Índice único compuesto (fecha y idpaciente de RECETA) ordenado 
de forma ascendente.*/

create index Idx_Receta
on SERVICIO.TBReceta (fecRec,idPac)
go

/*b Cree un Índice normal compuesto (nombre y apellidos del paciente) 
ordenado de forma descendente para ambos campos.*/

create index Idx_Paciente
on USUARIO.TBPaciente (nomPac,apPac)
go

/*c. Cree un Índice normal (apellido del médico), incluir el campo especialidad.*/

create index Idx_Medico
on SERVICIO.TBMedico (apMed)
include (espMed)
go






