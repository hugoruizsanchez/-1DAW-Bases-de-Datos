-- Escriba una vista que se llame listado_pagos_clientes que muestre un listado donde aparezcan todos los clientes y los pagos que ha realizado cada uno de ellos. La vista deberá tener las siguientes columnas: nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago, total del pago, id de la transacción

CREATE OR REPLACE VIEW listado_pagos_clientes AS 
SELECT CONCAT(cliente.nombre_contacto," ",cliente.apellido_contacto) as nombre_apellido, cliente.telefono, cliente.pais, cliente.ciudad, pago.fecha_pago, pago.total, pago.id_transaccion
FROM cliente
JOIN pago ON pago.codigo_cliente = cliente.codigo_cliente
GROUP BY  pago.id_transaccion;

-- Escriba una vista que se llame listado_pedidos_clientes que muestre un listado donde aparezcan todos los clientes y los pedidos que ha realizado cada uno de ellos. La vista deáber tener las siguientes columnas: nombre y apellidos del cliente concatendados, teléfono, ciudad, pais, código del pedido, fecha del pedido, fecha esperada, fecha de entrega y la cantidad total del pedido, que será la suma del producto de todas las cantidades por el precio de cada unidad, que aparecen en cada línea de pedido.

CREATE OR REPLACE VIEW listado_pedidos_clientes  AS 
SELECT CONCAT(cliente.nombre_contacto," ",cliente.apellido_contacto) as nombre_apellido, cliente.telefono, cliente.pais, cliente.ciudad, pedido.codigo_pedido, pedido.fecha_pedido, pedido.fecha_esperada, pedido.fecha_entrega, SUM(detalle_pedido.cantidad)*detalle_pedido.precio_unidad as cantidadTotal
FROM cliente 
JOIN pedido ON pedido.codigo_cliente = cliente.codigo_cliente
JOIN detalle_pedido ON detalle_pedido.codigo_pedido = pedido.codigo_pedido
GROUP BY pedido.codigo_pedido;


-- Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes de la ciudad de Madrid que han realizado pagos.

SELECT * from listado_pagos_clientes where ciudad="Madrid"; 

-- Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes que todavía no han recibido su pedido.

SELECT * from listado_pedidos_clientes where fecha_entrega is null;

-- Utilice las vistas que ha creado en los pasos anteriores para calcular el número de pedidos que se ha realizado cada uno de los clientes.

SELECT COUNT(codigo_pedido), nombre_apellido from listado_pedidos_clientes GROUP BY nombre_apellido;

-- Utilice las vistas que ha creado en los pasos anteriores para calcular el valor del pedido máximo y mínimo que ha realizado cada cliente.

SELECT MAX(cantidadTotal), MIN(cantidadTotal) from listado_pedidos_clientes;

-- Modifique el nombre de las vista listado_pagos_clientes y asígnele el nombre listado_de_pagos. Una vez que haya modificado el nombre de la vista ejecute una consulta utilizando el nuevo nombre de la vista para comprobar que sigue funcionando correctamente.

RENAME table listado_pagos_clientes to listado_de_pagos;
 
SELECT * from listado_de_pagos;


-- Elimine las vistas que ha creado en los pasos anteriores.

DROP VIEW listado_de_pagos;
DROP VIEW listado_pedidos_clientes;