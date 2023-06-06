

--  6.1 Cargar en la variable umbral_precio el valor de 4. Mostrar su valor por pantalla
DECLARE @umbral_precio FLOAT;
SET @umbral_precio = 4;
SELECT @umbral_precio as umbral_precio;

--  6.2 Usando la base de datos de jardineria obtener todos los productos (codigo, nombre y precio de venta) que tienen un precio de venta inferior al valor 
-- del umbral de precio. 

SELECT codigo, nombre, precio_venta
FROM jardineria.productos
WHERE precio_venta < @umbral_precio;

-- 6.3Usando la base de datos de jardinería informar la variable pago_mayor con el importe más elevado de los pagos registrados

DECLARE @pago_mayor FLOAT;
SELECT @pago_mayor = MAX(importe_pagado)
FROM jardineria.pagos;
SELECT @pago_mayor as pago_mayor;

-- 6.4 Usando la base de datos de jardinería informar la variable cliente_pago_mayor y fecha_pago_mayor con el código de cliente y fecha de pago correspondientes al pago
-- mayor registrado respectivamente.
SELECT TOP 1 @cliente_pago_mayor = codigo_cliente, @fecha_pago_mayor = fecha_pago
FROM jardineria.pagos
WHERE importe_pagado = @pago_mayor;
SELECT @cliente_pago_mayor as cliente_pago_mayor, @fecha_pago_mayor as fecha_pago_mayor; 


