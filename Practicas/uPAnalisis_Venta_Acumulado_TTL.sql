CREATE PROC uPAnalisis_Venta_Acumulado_TTL
	@OrderDateYear SMALLINT,
	@OrderDateMonthIni TINYINT,
	@OrderDateMonthFin TINYINT,
	@ProductID INT
AS
BEGIN
	CREATE TABLE #TEMP (
		Orden INT,
		ProductID INT, 
		NAME VARCHAR(200), 
		OrderDateMonth TINYINT, 
		OrderQty INT, 
		OrderQtyAcum INT, 
	)

	INSERT INTO #TEMP
	SELECT
		ROW_NUMBER() OVER (ORDER BY D.ProductID, MONTH(H.OrderDate)) AS Orden,
		D.ProductID, 
		P.NAME, 
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

	DECLARE @REG_MAX INT = (SELECT MAX(ORDEN) FROM #TEMP), @REG INT = 1 

	WHILE @REG <= @REG_MAX
	BEGIN
		UPDATE #TEMP
		SET OrderQtyAcum = (SELECT SUM(OrderQty) FROM #TEMP WHERE Orden <= @REG)
		FROM #TEMP
		WHERE Orden = @REG 
		SET @REG = @REG + 1
	END

	SELECT * FROM #TEMP
END


--EXEC uPAnalisis_Venta_Acumulado_TTL 2014, 1, 6, 999

