CREATE PROC uPAnalisis_Ventas_CTE
	@OrderDateYear SMALLINT,
	@OrderDateMonthIni TINYINT,
	@OrderDateMonthFin TINYINT,
	@ProductID INT
AS
BEGIN 
	WITH Reporte AS
	(
		SELECT
			ROW_NUMBER() OVER (ORDER BY D.ProductID, MONTH(H.OrderDate))  AS Orden,
			D.ProductID, 
			P.Name, 
			MONTH(H.OrderDate) AS OrderDateMonth, 
			SUM(D.OrderQty) AS OrderQty, 
			0 AS OrderQtyAcum
	
		FROM SALES.SalesOrderHeader AS H
			INNER JOIN SALES.SalesOrderDetail AS D 
				ON H.SalesOrderID = D.SalesOrderID
			INNER JOIN SALES.SpecialOfferProduct AS O 
				ON O.SpecialOfferID = D.SpecialOfferID AND O.ProductID = D.ProductID
			INNER JOIN Production.Product AS P 
				ON P.ProductID = O.ProductID
		WHERE YEAR(H.OrderDate) = @OrderDateYear
			AND MONTH(H.OrderDate) BETWEEN @OrderDateMonthIni AND COALESCE(@OrderDateMonthFin, MONTH(H.OrderDate))
			AND D.ProductID = COALESCE(@ProductID, D.ProductID)
		GROUP BY D.ProductID, P.NAME, MONTH(H.OrderDate)
	)
	,
	Acumulado AS
	(
		SELECT Orden, ProductID, Name, OrderDateMonth, OrderQty, OrderQty AS OrderQtyAcum 
		FROM Reporte
		WHERE Orden = 1 
		UNION ALL
		SELECT R.Orden, R.ProductID, R.Name, R.OrderDateMonth, R.OrderQty, A.OrderQtyAcum + R.OrderQty
		FROM Acumulado AS A JOIN Reporte AS R
			ON R.Orden = A.Orden + 1
	) SELECT * FROM Acumulado
END


--EXEC uPAnalisis_Ventas_CTE 2014, 1, 6, 999


