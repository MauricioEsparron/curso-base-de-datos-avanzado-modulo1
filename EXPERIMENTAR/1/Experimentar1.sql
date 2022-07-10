
/*crea la base de datos por defecto, llamada BDClaro*/
create database BDClaro
go

/*visuañizar estructura de mi BD*/
exec sp_helpdb BDClaro
go

/*Modificar la base de datos anterior para adicionar un DataFile*/

alter database BDClaro
add file(
	name = Claro_DataN1,
	filename = 'D:\DataClaro\Claro_DataN1.NDF',
	size = 10mb,
	maxsize = 50mb,
	filegrowth = 5mb)
go

/*Modificar la base de datos para adicionar un LogFile*/
alter database BDClaro
add log file(
	name = Claro_Log2,
	filename = 'D:\DataClaro\Claro_Log2.LDF',
	size = 20mb,
	maxsize = 150mb,
	filegrowth = 10mb)
go

/*Modificar de la base de datos creada, el archivo Claro_DataN1 para ampliar el
tamaño máximo a 200MB*/

alter database BDClaro
modify file (
			name ='Claro_DataN1',
			maxsize = 200mb)
go

/*Modificar de la base de datos creada, el archivo Claro_Log2 para cambiar el factor
de crecimiento a 25%.*/

alter database BDClaro
modify file (
			name ='Claro_Log2',
			filegrowth = 25%)
go

/*Modificar la base de datos para crear el filegroup FGComercial*/

alter database BDClaro
add filegroup [FGComercial]
go

/*Modificar la base de datos para adicionar un datafile al filegroup creado
anteriormente.*/

alter database BDClaro
add file(name = Claro_DataN2,
		filename = 'D:\DataClaro\Claro_DataN2.NDF',
		size = 10mb,
		maxsize = 50mb,
		filegrowth = 5mb
)to filegroup [FGComercial]
go