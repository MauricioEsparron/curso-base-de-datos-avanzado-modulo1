/*Consultas Avanzadas*/
Use Negocios
go

/*Combinar tablas (Where)*/
/*Mostrar informacion de todos los productos con el nombre del proveedor*/


/*Combinar tablas (Join)*/--Recomendado


/*Combinar 03 Tablas */
/*Mostrar informacion de todos los productos con el nombre del proveedor 
  y la categoria a la que pertenece*/


/****** INNER JOIN **********/
--Interna (Muestra solo los que coinciden en la comparación)


/*Combinar 03 Tablas  */


/***** OUTER JOIN ********/
--Externa (Muestra los que coinciden y los que no coinciden en la comparación
--Hay 03 tres tipos
--LEFT OUTER JOIN 
--(Muestra los que coinciden y los que no coinciden en la comparación con 
--la tabla del lado Izquierdo)

/*Muestra todos los clientes que han hecho pedidos y 
  los clientes que no han hecho pedidos*/


--Insertemos un par de nuevos clientes
Insert Ventas.clientes
Values
('CL001','Alicorp','Av Argentina 111','001','222222'),
('CL002','Donofrio','Av Venezuela 345','002','333333')
go

--Volver a ejecutar la consulta
Select	CL.*,
	PC.* 
From Ventas.clientes CL  LEFT JOIN Ventas.pedidoscabe PC
	On CL.IdCliente = PC.IdCliente
go

--RIGHT OUTER JOIN 
--(Muestra los que coinciden y los que no coinciden en la 
--comparación con la tabla del lado Derecho)

/*Pedidos que no tienen un cliente*/


--Insertemos un par de nuevos Pedidos
Insert Ventas.pedidoscabe
Values
('9999',Null,Null,getdate(),Getdate()+1,Getdate()+3,0,30,'Tortugas Restau','Las Gacelas 111','Lima',null,'1734','Peru'),
('8888',Null,Null,getdate(),Getdate()+1,Getdate()+3,0,30,'Popeyes Restau','Los Galgos 111','Comas',null,'1731','Peru')
go

--Volver a ejecutar
Select	CL.*,
	PC.* 
From Ventas.clientes CL RIGHT JOIN Ventas.pedidoscabe PC
	On CL.IdCliente = PC.IdCliente
go

--FULL OUTER JOIN 
--(Muestra los que coinciden y los que no coinciden en 
--la comparación con ambas tablas)


/*Combinación Cruzada*/
/*Muestra todos los productos y todos los proveedores*/



/*UNION*/
/*Listado de proveedores y clientes */

