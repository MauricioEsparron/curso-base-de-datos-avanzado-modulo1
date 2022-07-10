/*USO DE FUNCIONES AGREGADAS*/
Use Negocios
go

/*COUNT*/
select count (*) as 'CANTIDAD DE PEDIDOS'
from Ventas.pedidoscabe
where DATEPART(YY,FechaPedido) = 2011
go

select count (DISTINCT IdCliente) as 'NUMERO DE CLIENTES'
from Ventas.pedidoscabe
where DATEPART(YY,FechaPedido) = 1996
go

/*AVG*/
select AVG(PrecioUnidad) as 'PRECIO PROMEDIO'
from Compras.productos
go


/*MAX, MIN*/
select MAX(PrecioUnidad) as 'MAYOR PRECIO',
	   MIN(PrecioUnidad) as 'MENOR PRECIO'
from Compras.productos
go

/*SUM*/
select SUM(PD.PrecioUnidad* PD.Cantidad) as SUMA
from Ventas.pedidoscabe PC join Ventas.pedidoscabe PD
	on PC.IdPedido = PD.IdPedido
where YEAR(PC.FechaPedido) = 2011
go

/*Consultas Agrupadas*/
------------
Select	* from Ventas.clientes
go
----------
select idpais, COUNT(*) as 'CANTIDAD DE CLIENTES'
from Ventas.clientes
group by idpais
go
-----------

----------Consulta 1
select C.idpais, P.Nombrepais, COUNT(*) as 'CANTIDAD DE CLIENTES'
from Ventas.clientes C join Ventas.paises P
	on C.idpais = P.Idpais
group by C.idpais, P.NombrePais
go

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


--

select year(PC.FechaPedido)as 'a�o',CL.NomCliente,RH.NomEmpleado,count(PC.IdPedido) as 'cantidad de pedidos'

from RRHH.empleados RH,Ventas.clientes CL join Ventas.pedidoscabe PC 

	on CL.IdCliente=Pc.IdCliente

group by year(PC.FechaPedido),CL.NomCliente,RH.NomEmpleado

order by 1,2

go
