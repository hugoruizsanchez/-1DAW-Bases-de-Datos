-- Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT codigo_oficina, ciudad from oficina;

-- Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT ciudad, telefono from oficina where pais = "España";


-- Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

SELECT nombre, apellido1, apellido2, email from empleado where codigo_jefe = 7;


-- Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

SELECT puesto, nombre, apellido1, apellido2, email from empleado where codigo_empleado IN (SELECT codigo_jefe from empleado);

-- Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que son representantes de ventas, pero no se encuentran atendiendo a ningún cliente

SELECT puesto, nombre, apellido1, apellido2 from empleado where codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas from cliente) AND puesto like "%representante%ventas%";

-- Devuelve un listado con el nombre de los todos los clientes españoles.

SELECT nombre_cliente from cliente WHERE pais ="Spain";

-- Devuelve un listado con los distintos estados por los que puede pasar un pedido.

SELECT DISTINCT estado from pedido;

-- Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
-- Utilizando la función YEAR de MySQL.
-- Utilizando la función DATE_FORMAT de MySQL.
-- Sin utilizar ninguna de las funciones anteriores.

SELECT codigo_cliente, nombre_cliente from cliente WHERE codigo_cliente IN (SELECT codigo_cliente from pago WHERE YEAR(fecha_pago) = 2008);

-- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega, DATEDIFF (fecha_esperada, fecha_entrega) as Retraso_en_dias from pedido having Retraso_en_dias < 0;

-- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- Utilizando la función ADDDATE de MySQL.
-- Utilizando la función DATEDIFF de MySQL.
-- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega, DATEDIFF(fecha_esperada, fecha_entrega) as Ventaja_en_dias from pedido having Ventaja_en_dias > 2;

-- Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

SELECT codigo_pedido from pedido where estado = "Rechazado" AND YEAR(fecha_pedido) = 2009;

-- Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

SELECT codigo_pedido, fecha_entrega from pedido where MONTH(fecha_entrega) =1;

-- Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

SELECT id_transaccion from pago WHERE forma_pago ="Paypal" AND YEAR(fecha_pago) = 2009;

-- evuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.

SELECT DISTINCT forma_pago from pago;

-- Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.

SELECT nombre, codigo_producto, precio_venta from producto where gama = "Ornamentales" AND cantidad_en_stock >100 ORDER BY precio_venta DESC;


-- Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT codigo_cliente, nombre_cliente from cliente WHERE ciudad = "Madrid" AND codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30;

-- 1.4.5 Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

-- Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1
FROM cliente
JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas;

-- Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1
FROM cliente
JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_cliente IN (SELECT codigo_cliente from pago);

-- Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1
FROM cliente
JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
WHERE cliente.codigo_cliente NOT IN (SELECT codigo_cliente from pago)

-- Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, oficina.ciudad
FROM cliente
JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina;

-- Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, oficina.ciudad
FROM cliente
JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE cliente.codigo_cliente NOT IN (SELECT codigo_cliente from pago);

-- Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
-- // Hecho con subconsultas.
SELECT CONCAT(oficina.linea_direccion1,oficina.linea_direccion2) as "Oficinas fuenlabrada con clientes" 
FROM oficina 
WHERE codigo_oficina IN 
(SELECT codigo_oficina from empleado WHERE codigo_empleado IN 
(SELECT codigo_empleado_rep_ventas from cliente where linea_direccion2="Fuenlabrada"));
-- // Hecho con tablas derivadas
SELECT DISTINCT CONCAT(oficina.linea_direccion1,oficina.linea_direccion2) as "Oficinas fuenlabrada con clientes" 
FROM oficina 
JOIN empleado ON empleado.codigo_oficina=oficina.codigo_oficina
JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.linea_direccion2="Fuenlabrada";

-- Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1 ,oficina.ciudad 
FROM oficina 
JOIN empleado ON empleado.codigo_oficina=oficina.codigo_oficina
JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

-- Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

SELECT empleado.nombre as "Empleado", jefe.nombre as "Jefe"
FROM empleado
LEFT JOIN empleado jefe ON jefe.codigo_jefe = empleado.codigo_empleado;


-- Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

SELECT empleado.nombre as "Empleado", jefe.nombre as "Jefe", jefedeljefe.nombre as "Jefe del jefe"
FROM empleado
LEFT JOIN empleado jefe ON jefe.codigo_jefe = empleado.codigo_empleado
LEFT JOIN empleado jefedeljefe ON jefe.codigo_empleado = jefedeljefe.codigo_jefe;


-- Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
--//usando subconsulta
SELECT nombre_cliente FROM cliente 
WHERE codigo_cliente IN 
(SELECT codigo_cliente from pedido where DATEDIFF(fecha_pedido,fecha_entrega)<0);
--// usando tabla derivada
SELECT DISTINCT cliente.nombre_cliente 
FROM cliente 
JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente 
WHERE DATEDIFF (pedido.fecha_pedido,pedido.fecha_entrega)<0;


-- Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT DISTINCT cliente.nombre_cliente, producto.gama 
FROM cliente 
JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
JOIN detalle_pedido ON pedido.codigo_pedido = detalle_pedido.codigo_pedido
JOIN producto ON producto.codigo_producto = detalle_pedido.codigo_producto;

-- 1.4.6 Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
--/como tabla derivada
SELECT cliente.codigo_cliente, cliente.nombre_cliente 
FROM cliente 
LEFT JOIN pago ON pago.codigo_cliente = cliente.codigo_cliente
WHERE pago.codigo_cliente is null;
-- /como subconsulta
SELECT cliente.codigo_cliente, cliente.nombre_cliente 
FROM cliente 
WHERE cliente.codigo_cliente NOT IN (SELECT codigo_cliente from pago);

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

-- /como tabla derivada
SELECT cliente.codigo_cliente, cliente.nombre_cliente 
FROM cliente 
LEFT JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
WHERE pedido.codigo_cliente is null;
-- /como subconsulta
SELECT cliente.codigo_cliente, cliente.nombre_cliente 
FROM cliente 
WHERE cliente.codigo_cliente NOT IN (SELECT codigo_cliente from pedido);

-- Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
-- //Como tabla derivada
SELECT cliente.codigo_cliente, cliente.nombre_cliente 
FROM cliente 
LEFT JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
LEFT JOIN pago ON pago.codigo_cliente = cliente.codigo_cliente
WHERE pedido.codigo_cliente is null AND pago.codigo_cliente is NULL;
-- Como subconsulta 
SELECT cliente.codigo_cliente, cliente.nombre_cliente 
FROM cliente 
WHERE cliente.codigo_cliente NOT IN (SELECT codigo_cliente from pedido) 
AND cliente.codigo_cliente NOT IN (SELECT codigo_cliente from pago);

-- Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
-- //Como tabla derivada
SELECT empleado.codigo_empleado, empleado.nombre, empleado.apellido1, empleado.codigo_oficina
FROM empleado
LEFT JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina
WHERE oficina.codigo_oficina is null;
-- //Como subconsulta
SELECT empleado.codigo_empleado, empleado.nombre, empleado.apellido1, empleado.codigo_oficina
FROM empleado
WHERE codigo_oficina NOT IN (SELECT codigo_oficina from oficina);

-- Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

SELECT empleado.codigo_empleado, empleado.nombre, empleado.apellido1, cliente.codigo_empleado_rep_ventas
FROM empleado
LEFT JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.codigo_empleado_rep_ventas is NULL;

-- Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

SELECT empleado.codigo_empleado, empleado.nombre, empleado.apellido1, oficina.codigo_oficina, oficina.pais, oficina.ciudad, cliente.codigo_empleado_rep_ventas
FROM empleado
LEFT JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE cliente.codigo_empleado_rep_ventas is NULL;

-- Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.


SELECT empleado.codigo_empleado, empleado.nombre, empleado.apellido1, oficina.codigo_oficina, oficina.pais, oficina.ciudad, cliente.codigo_empleado_rep_ventas
FROM empleado
LEFT JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
JOIN oficina ON oficina.codigo_oficina = empleado.codigo_oficina
WHERE cliente.codigo_empleado_rep_ventas is NULL AND oficina.codigo_oficina is null;

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT producto.codigo_producto, producto.nombre
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE detalle_pedido.codigo_producto is null;

-- Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

SELECT producto.codigo_producto, producto.nombre, producto.descripcion, gama_producto.imagen
FROM producto
LEFT JOIN detalle_pedido ON producto.codigo_producto = detalle_pedido.codigo_producto
LEFT JOIN gama_producto ON producto.descripcion = gama_producto.descripcion_texto
WHERE detalle_pedido.codigo_producto is null;

-- Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

SELECT oficina.codigo_oficina, oficina.ciudad, oficina.pais, empleado.codigo_empleado
FROM oficina 
LEFT JOIN empleado ON oficina.codigo_oficina = empleado.codigo_oficina
LEFT JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
LEFT JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
LEFT JOIN detalle_pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
LEFT JOIN producto ON producto.codigo_producto = detalle_pedido.codigo_producto
WHERE  producto.gama != "Frutales" AND cliente.codigo_empleado_rep_ventas is null;


-- Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

SELECT cliente.codigo_cliente, cliente.nombre_cliente
FROM cliente 
LEFT JOIN pago ON pago.codigo_cliente = cliente.codigo_cliente 
LEFT JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente 
WHERE pedido.codigo_cliente is NOT NULL AND pago.codigo_cliente is null;

-- Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

SELECT empleado.*
FROM empleado
LEFT JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
WHERE cliente.codigo_empleado_rep_ventas is NULL;

HAVING nombre_jefe IN 
(SELECT nombre from empleado WHERE codigo_empleado IN
(SELECT codigo_jefe from empleado));

1.4.7 Consultas resumen
-- ¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) from empleado;

-- ¿Cuántos clientes tiene cada país?

mysql> SELECT COUNT(*), pais from cliente GROUP BY pais;

-- ¿Cuál fue el pago medio en 2009?

SELECT AVG(total) from pago WHERE YEAR(fecha_pago) = 2009;

-- ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

SELECT COUNT(*), estado from pedido GROUP BY estado ORDER BY COUNT(*) DESC;

-- Calcula el precio de venta del producto más caro y más barato en una misma consulta.

SELECT MAX(precio_venta), MIN(precio_venta) from producto;

-- Calcula el número de clientes que tiene la empresa.

SELECT COUNT(*) from cliente;

-- ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

SELECT COUNT(*) from cliente where ciudad ="Madrid";

-- ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

SELECT COUNT(*) from cliente where ciudad like "M%";

-- Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.

SELECT empleado.nombre, COUNT(cliente.codigo_cliente) 
FROM empleado
JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.
codigo_empleado GROUP BY empleado.nombre;

-- Calcula el número de clientes que no tiene asignado representante de ventas.

SELECT COUNT(codigo_cliente) from cliente WHERE codigo_empleado_rep_ventas NOT IN (SELECT codigo_empleado from empleado);

-- Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

SELECT cliente.nombre_contacto, cliente.apellido_contacto, MIN(pago.fecha_pago) as primer_pago, MAX(pago.fecha_pago) as ultimo_pago 
FROM cliente
JOIN pago ON pago.codigo_cliente = cliente.codigo_cliente 
GROUP BY cliente.nombre_contacto, cliente.apellido_contacto;

-- Calcula el número de productos diferentes que hay en cada uno de los pedidos.

SELECT DISTINCT pedido.codigo_pedido, COUNT(producto.codigo_producto) 
FROM pedido
JOIN detalle_pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
JOIN producto ON producto.codigo_producto = detalle_pedido.codigo_producto
GROUP BY pedido.codigo_pedido;

-- Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

SELECT codigo_pedido,SUM(cantidad) from detalle_pedido GROUP BY codigo_pedido;

-- Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.

SELECT producto.nombre, SUM(detalle_pedido.cantidad) as suma_cantidad
FROM detalle_pedido
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
GROUP BY producto.nombre ORDER BY suma_cantidad DESC LIMIT 20;

-- La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.

SELECT SUM(detalle_pedido.cantidad * producto.precio_venta) AS base_facturacion, 
       SUM(detalle_pedido.cantidad * producto.precio_venta) * 0.21 AS iva, 
       SUM(detalle_pedido.cantidad * producto.precio_venta) + SUM(detalle_pedido.cantidad * producto.precio_venta) * 0.21 AS base_facturacion_iva 
FROM detalle_pedido 
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto;


-- La misma información que en la pregunta anterior, pero agrupada por código de producto.

SELECT 
	detalle_pedido.codigo_pedido,
	SUM(detalle_pedido.cantidad * producto.precio_venta) AS base_facturacion, 
    SUM(detalle_pedido.cantidad * producto.precio_venta) * 0.21 AS iva, 
    SUM(detalle_pedido.cantidad * producto.precio_venta) + SUM(detalle_pedido.cantidad * producto.precio_venta) * 0.21 AS base_facturacion_iva 
FROM detalle_pedido 
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
GROUP BY detalle_pedido.codigo_pedido;


-- La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.

SELECT 
	detalle_pedido.codigo_pedido,
	SUM(detalle_pedido.cantidad * producto.precio_venta) AS base_facturacion, 
    SUM(detalle_pedido.cantidad * producto.precio_venta) * 0.21 AS iva, 
    SUM(detalle_pedido.cantidad * producto.precio_venta) + SUM(detalle_pedido.cantidad * producto.precio_venta) * 0.21 AS base_facturacion_iva 
FROM detalle_pedido 
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
WHERE producto.codigo_producto like "OR%"
GROUP BY detalle_pedido.codigo_pedido;

-- Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).

SELECT 
	producto.nombre,
	SUM(detalle_pedido.cantidad) as Unidades_vendidas,
	SUM(detalle_pedido.cantidad)*detalle_pedido.precio_venta as Total_facturado,
	SUM(detalle_pedido.cantidad)*detalle_pedido.precio_venta*1.21 as Total_facturado_iva
FROM detalle_pedido 
JOIN producto ON detalle_pedido.codigo_producto = producto.codigo_producto
GROUP BY producto.nombre
HAVING Total_facturado_iva > 3000;
	
-- Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.

SELECT 
	YEAR(fecha_pago) as anio,
	SUM(total) 
FROM pago
GROUP BY anio;


-- 1.4.8 Subconsultas

-- 1.4.8.1 Con operadores básicos de comparación
-- Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente from cliente
WHERE limite_credito = (SELECT MAX(limite_credito) from cliente);

-- Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre from producto
WHERE precio_venta = (SELECT MAX(precio_venta) from producto);

-- Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)

SELECT nombre from producto
WHERE codigo_producto = 
(SELECT codigo_producto from 
	(SELECT codigo_producto, SUM(cantidad) from detalle_pedido GROUP BY codigo_producto ORDER BY SUM(cantidad) DESC LIMIT 1) as tabladerivada);


-- Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).


SELECT nombre_cliente
FROM cliente
WHERE limite_credito > (
    SELECT SUM(total)
    FROM pago
    WHERE codigo_cliente = cliente.codigo_cliente
    );

-- Devuelve el producto que más unidades tiene en stock.

SELECT nombre from producto WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) from producto);

-- Devuelve el producto que menos unidades tiene en stock.
SELECT nombre from producto WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) from producto);


-- Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.

SELECT nombre, apellido1, apellido2, email from empleado 
WHERE codigo_empleado IN (SELECT codigo_jefe from empleado where nombre="Alberto" AND apellido1="Soria");

-- 1.4.8.2 Subconsultas con ALL y ANY
-- Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente from cliente where limite_credito >= ALL (select limite_credito from cliente) ; 

-- Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre from producto WHERE precio_venta >= ALL (SELECT precio_venta from producto);

-- Devuelve el producto que menos unidades tiene en stock.

SELECT nombre, cantidad_en_stock from producto WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock from producto);

-- 1.4.8.3 Subconsultas con IN y NOT IN

-- Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.

SELECT nombre, apellido1, puesto from empleado 
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas from cliente);


-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

SELECT codigo_cliente, nombre_cliente from cliente WHERE codigo_cliente 
NOT IN (SELECT codigo_cliente from pago);

-- Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.


SELECT codigo_cliente, nombre_cliente from cliente WHERE codigo_cliente 
IN (SELECT codigo_cliente from pago);

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT codigo_producto, nombre from producto WHERE codigo_producto NOT IN (SELECT codigo_producto from detalle_pedido);

-- Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.

SELECT empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.puesto, oficina.telefono 
FROM empleado
JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina 
WHERE empleado.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas from cliente);

-- Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.


SELECT codigo_oficina from oficina WHERE 
codigo_oficina NOT IN 
(SELECT codigo_oficina from empleado WHERE codigo_empleado IN 
(SELECT codigo_empleado_rep_ventas from cliente WHERE codigo_cliente IN 
(SELECT codigo_cliente from pedido WHERE codigo_pedido IN
(SELECT codigo_pedido from detalle_pedido WHERE codigo_producto IN 
(SELECT codigo_producto from producto WHERE gama="Frutales"))))));

-- Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

SELECT codigo_cliente, nombre_cliente from cliente WHERE codigo_cliente IN (SELECT codigo_cliente from pedido) AND codigo_cliente NOT IN (SELECT codigo_cliente from pago);

1.4.8.4 Subconsultas con EXISTS y NOT EXISTS

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

SELECT codigo_cliente, nombre_cliente from cliente WHERE NOT EXISTS (SELECT codigo_cliente from pago where cliente.codigo_cliente = pago.codigo_cliente);


-- Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

SELECT codigo_cliente, nombre_cliente from cliente WHERE  EXISTS (SELECT codigo_cliente from pago where cliente.codigo_cliente = pago.codigo_cliente);

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT codigo_cliente, nombre_cliente from cliente WHERE NOT EXISTS (SELECT codigo_cliente from pedido where cliente.codigo_cliente = pedido.codigo_cliente);

-- Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

SELECT codigo_cliente, nombre_cliente from cliente WHERE  EXISTS (SELECT codigo_cliente from pedido where cliente.codigo_cliente = pedido.codigo_cliente);


-- 1.4.9 Consultas variadas
-- Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

SELECT cliente.codigo_cliente, cliente.nombre_cliente, COUNT(pedido.codigo_pedido)
FROM cliente 
LEFT JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente
GROUP BY cliente.codigo_cliente, cliente.nombre_cliente;

-- Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.

SELECT cliente.codigo_cliente, cliente.nombre_cliente, SUM(pago.total)
FROM cliente 
LEFT JOIN pago ON cliente.codigo_cliente = pago.codigo_cliente
GROUP BY cliente.codigo_cliente, cliente.nombre_cliente;

-- Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

SELECT DISTINCT cliente.nombre_cliente from cliente 
JOIN pedido ON cliente.codigo_cliente = pedido.codigo_cliente 
WHERE YEAR(pedido.fecha_pedido)=2008 ORDER BY cliente.nombre_cliente ASC;

-- Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, oficina.telefono
FROM cliente 
JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina 
WHERE cliente.codigo_cliente NOT IN (SELECT codigo_cliente from pago);

-- 	Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.

SELECT cliente.nombre_cliente, empleado.nombre, empleado.apellido1, oficina.ciudad
FROM cliente 
JOIN empleado ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina 
GROUP BY cliente.nombre_cliente;


-- Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.

SELECT empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.puesto, oficina.telefono 
FROM empleado
JOIN oficina ON empleado.codigo_oficina = oficina.codigo_oficina 
WHERE empleado.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas from cliente);

-- Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.

SELECT oficina.ciudad, COUNT(empleado.codigo_empleado)
FROM oficina
JOIN empleado ON empleado.codigo_oficina = oficina.codigo_oficina 
GROUP BY oficina.ciudad;
