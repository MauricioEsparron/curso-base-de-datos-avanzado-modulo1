/*Variables Globales*/
Use Negocios
go

--La version del SQL Server
PRINT 'VERSION: ' + @@VERSION
SELECT @@VERSION

--Lenguaje del aplicativo
PRINT 'IDIOMA: ' + @@LANGUAGE

--Nombre del servidor
PRINT 'SERVIDOR: ' + @@SERVERNAME

--Nro. de conexiones permitidas
PRINT 'CONEXIONES: ' + STR(@@MAX_CONNECTIONS)
SELECT @@MAX_CONNECTIONS

--Nro de Error producido en la instruccion
SELECT @@ERROR

--Forzar un error
SELECT * FROM TBCOTIZACION
GO
SELECT @@ERROR

/* ********** Variables Locales ******** */

------------------

Use Negocios
go



--Ejemplo 1



--Ejemplo 2
/*Precio mas caro */


--Ejemplo 3
/*Precio mas caro y empleado mas antiguo*/


/* ******** Estructura IF *****************/
Use Negocios
go

--Recuperar la cantidad de pedidos del empleado de codigo 6, imprimir si 
--realizo: 0, 1 o mas pedidos.



select * from Ventas.pedidoscabe 
order by IdEmpleado

/* *********** Estructura CASE ************* */
Use Negocios
go

/*CASE: Evaluando valores*/


/*CASE: Evaluando resultado de una expresión de comparación*/


/*Utilizando CASE dentro de un SELECT*/
/*Ejemplo 1*/



/*Ejemplo 2*/


/* ************ Script Estructura WHILE ************** */
Use Negocios
go

/*Crear estructura WHILE*/


/*Crear estructura WHILE*/




