/*USO DE FUNCIONES AGREGADAS*/
Use Negocios
go

/*COUNT*/


/*AVG*/

/*MAX, MIN*/

/*SUM*/


/*Consultas Agrupadas*/
------------
Select	* from Ventas.clientes
go
----------

-----------

----------Consulta 1


/* OTRO EJEMPLO */
--------
Select	* from Ventas.pedidosdeta
go
--------

--------Consulta 2

--------

--------

-------- Consulta 3


/*Total por producto en dinero */

Select	* from Ventas.pedidosdeta
go
-------

-------Consulta 4


/*Monto facturado por cada boleta */
-------- 
Select	* from Ventas.pedidosdeta
go
-------

-------Consulta 5


/*OPTIMIZANDO GRUPOS*/
------Optimizar Consulta 1 para ver solo si en cada pais 
------residen mas de 1 cliente


-------- Optimizar Consulta 2 para mostrar solo si la cantidad
-------- de items es mayor a 2


-------- Optimizar Consulta 3 para mostrar solo si la cantidad
-------- total supera a 30 y si la descripcion del producto inicia 
-------- con consonante

