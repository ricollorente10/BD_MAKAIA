-- 1
SELECT CodigoOficina, Ciudad FROM Oficinas;

-- 2
SELECT Ciudad, Telefono FROM Oficinas WHERE Pais = 'España';

-- 3
SELECT Nombre, Apellido1, Apellido2, Email FROM Empleados WHERE CodigoJefe = 7;

-- 4
SELECT DISTINCT CodigoCliente FROM Pagos WHERE YEAR(FechaPago) = 2008;

-- 5
SELECT COUNT(*) AS TotalEmpleados FROM Empleados;

-- 6
SELECT Pais, COUNT(*) AS TotalClientes FROM Clientes GROUP BY Pais;

-- 7
SELECT AVG(TotalPago) AS PagoPromedio FROM Pagos WHERE YEAR(FechaPago) = 2009;

-- 8
SELECT Estado, COUNT(*) AS TotalPedidos FROM Pedidos GROUP BY Estado ORDER BY TotalPedidos DESC;

-- 9
SELECT MAX(PrecioVenta) AS PrecioMasCaro, MIN(PrecioVenta) AS PrecioMasBarato FROM Productos;

-- 10
SELECT NombreCliente FROM Clientes ORDER BY LimiteCredito DESC LIMIT 1;

-- 11
SELECT Nombre FROM Productos ORDER BY PrecioVenta DESC LIMIT 1;

-- 12
SELECT p.Nombre FROM Productos p
INNER JOIN (
    SELECT CodigoProducto, SUM(Cantidad) AS TotalUnidadesVendidas FROM DetalleDePedido
    GROUP BY CodigoProducto ORDER BY TotalUnidadesVendidas DESC LIMIT 1
) d ON p.CodigoProducto = d.CodigoProducto;

-- 13
SELECT CodigoCliente, NombreCliente, LimiteCredito FROM Clientes
WHERE LimiteCredito > (SELECT SUM(TotalPago) FROM Pagos WHERE CodigoCliente = Clientes.CodigoCliente);

-- 14 
SELECT c.NombreCliente, COUNT(p.CodigoPedido) AS TotalPedidos FROM Clientes c
LEFT JOIN Pedidos p ON c.CodigoCliente = p.CodigoCliente GROUP BY c.NombreCliente;

-- 15
SELECT e.Nombre, e.Apellido1, e.Apellido2, p.Puesto, o.Telefono FROM Empleados e
JOIN Puestos p ON e.CodigoPuesto = p.CodigoPuesto
JOIN Oficinas o ON e.CodigoOficina = o.CodigoOficina
WHERE e.CodigoEmpleado NOT IN (SELECT DISTINCT CodigoEmpleado FROM Clientes WHERE CodigoEmpleado IS NOT NULL);

-- 16
SELECT DISTINCT o.CodigoOficina, o.Ciudad FROM Oficinas o LEFT JOIN Empleados e ON o.CodigoOficina = e.CodigoOficina
WHERE o.CodigoOficina NOT IN (
    SELECT DISTINCT o.CodigoOficina FROM Oficinas o
    JOIN Empleados e ON o.CodigoOficina = e.CodigoOficina
    JOIN Clientes c ON e.CodigoEmpleado = c.CodigoEmpleado
    JOIN DetalleDePedido dp ON c.CodigoCliente = dp.CodigoCliente
    JOIN Productos p ON dp.CodigoProducto = p.CodigoProducto
    JOIN GamasDeProductos g ON p.Gama = g.Gama
    WHERE g.Gama = 'Frutales'
);

-- 17
SELECT c.NombreCliente, COUNT(p.CodigoPedido) AS TotalPedidos FROM Clientes c
LEFT JOIN Pedidos p ON c.CodigoCliente = p.CodigoCliente GROUP BY c.NombreCliente;

-- 18
SELECT c.NombreCliente, IFNULL(SUM(pa.TotalPago), 0) AS TotalPagado FROM Clientes c
LEFT JOIN Pagos pa ON c.CodigoCliente = pa.CodigoCliente GROUP BY c.NombreCliente;
