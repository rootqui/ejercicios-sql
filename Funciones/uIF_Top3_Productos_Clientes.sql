CREATE FUNCTION uIF_Top3_Productos_Clientes
(
	@CustomerID INT 
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT TOP 3 h.CustomerID, d.ProductID, sum(d.OrderQty) AS TotalProductos
	FROM Sales.SalesOrderHeader AS h INNER JOIN Sales.SalesOrderDetail AS d
		ON d.SalesOrderID = h.SalesOrderID
	WHERE h.CustomerID = @CustomerID 
	GROUP BY h.CustomerID, d.ProductID 
)
