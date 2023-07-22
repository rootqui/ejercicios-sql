CREATE FUNCTION uTF_VentasTotal_Fechas
(
	@FechaIni DATE,
	@FechaFin DATE
)
RETURNS @Total TABLE
(
	SalesOrderID INT,
	CustomerID INT,
	OrderDate DATE,
	TotalDue MONEY
)
AS
BEGIN
	INSERT INTO @Total(SalesOrderID, CustomerID, OrderDate, TotalDue)
	SELECT H.SalesOrderID, H.CustomerID, H.OrderDate, H.TotalDue
	FROM Sales.SalesOrderHeader AS H
	WHERE H.OrderDate BETWEEN @FechaIni AND @FechaFin
	
	RETURN
END