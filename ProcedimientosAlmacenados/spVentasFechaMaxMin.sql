USE AdventureWorks2019
-- Implementar un procedimiento almacenado que retorne la fechas maxima y 
-- minima de la columna OrderDate de la tabla SalesOrderHeader.

CREATE PROC uP_SalesOrderHeader_FechasMaxMin
	@fecha_max DATE OUTPUT,
	@fecha_min DATE OUTPUT
AS
BEGIN
	SELECT @fecha_max = MAX(h.OrderDate), @fecha_min = MIN(h.OrderDate)
	FROM Sales.SalesOrderHeader AS h
END
GO