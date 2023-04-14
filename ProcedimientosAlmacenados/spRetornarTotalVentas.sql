USE AdventureWorks2019
-- Implementar un procedimiento almacenado que retorne el importe total 
-- de venta de la tabla SalesOrderHeader (TotalDue)

CREATE PROC uP_SalesOrderHeader_TotalVentas
	@TotalDue MONEY OUTPUT
AS
BEGIN
	SELECT @TotalDue = SUM(h.TotalDue)
	FROM Sales.SalesOrderHeader AS h
END