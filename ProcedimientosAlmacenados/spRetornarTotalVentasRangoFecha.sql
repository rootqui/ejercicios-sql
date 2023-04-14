USE AdventureWorks2019
-- Implementar un procedimiento que retorne el total de ventas, con 
-- respecto un rango de fechas, si no se especifica la fecha final, se 
-- debe asumir la fecha de hoy

CREATE PROC uP_SalesOrderHeader_TotalVentas_Rango_Fecha
	@FechaInicial DATE, 
	@FechaFinal DATE = NULL,
	@TotalDue MONEY OUTPUT 
AS
BEGIN
	SELECT @TotalDue = SUM(h.TotalDue)
	FROM Sales.SalesOrderHeader AS h
	WHERE h.OrderDate BETWEEN @FechaInicial AND COALESCE(@FechaFinal, GETDATE())
END
GO