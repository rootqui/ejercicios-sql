CREATE PROC uPAnalisis_Ventas 
	@OrderDateYear SMALLINT,
	@OrderDateMonthIni TINYINT,
	@OrderDateMonthFin TINYINT,
	@ProductID INT,
	@Reg INT = NULL
AS
BEGIN
	DECLARE @TEMP TABLE(
		Orden INT,
		ProductID INT, 
		NAME VARCHAR(200), 
		OrderDateMonth TINYINT, 
		OrderQty INT, 
		OrderQtyAcum INT
	)

	INSERT INTO @TEMP
	SELECT
		ROW_NUMBER() OVER (ORDER BY D.ProductID, MONTH(H.OrderDate)) AS Orden,
		D.ProductID, 
		P.NAME, 
		MONTH(H.OrderDate) AS OrderDateMonth, 
		SUM(D.OrderQty) AS OrderQty, 
		0 AS OrderQtyAcum
	
	FROM SALES.SalesOrderHeader H
		INNER JOIN SALES.SalesOrderDetail D ON H.SalesOrderID = D.SalesOrderID
		INNER JOIN SALES.SpecialOfferProduct O ON O.SpecialOfferID = D.SpecialOfferID AND O.ProductID = D.ProductID
		INNER JOIN Production.Product P ON P.ProductID = O.ProductID
	WHERE YEAR(H.OrderDate) = @OrderDateYear
		AND MONTH(H.OrderDate) BETWEEN @OrderDateMonthIni AND COALESCE(@OrderDateMonthFin, MONTH(H.OrderDate))
		AND D.ProductID = COALESCE(@ProductID, D.ProductID)
	GROUP BY D.ProductID, P.NAME, MONTH(H.OrderDate)

	
	SET @Reg = COALESCE(@reg, (SELECT MAX(Orden) FROM @TEMP))

	IF (@Reg = 1)
		BEGIN
			UPDATE @TEMP
			SET OrderQtyAcum = (SELECT OrderQty FROM @TEMP WHERE Orden = 1)
			FROM @TEMP
			WHERE Orden = 1
			SELECT * FROM @TEMP WHERE Orden = 1
		END
	ELSE
		BEGIN
			SET @Reg = @Reg - 1
			EXEC uPAnalisis_Ventas @OrderDateYear, @OrderDateMonthIni, @OrderDateMonthFin, @ProductID, @Reg
			
			UPDATE @TEMP
			SET OrderQtyAcum = (SELECT SUM(OrderQty) FROM @TEMP WHERE Orden <= @Reg + 1)
			FROM @TEMP
			WHERE Orden = @Reg + 1

			SELECT * FROM @TEMP WHERE Orden = @Reg + 1
		
		END
END
GO

CREATE PROC uPReporte_Ventas 
	@OrderDateYear SMALLINT,
	@OrderDateMonthIni TINYINT,
	@OrderDateMonthFin TINYINT,
	@ProductID INT
AS
BEGIN
	DECLARE @ReporteVentas TABLE(
		Orden INT,
		ProductID INT, 
		NAME VARCHAR(200), 
		OrderDateMonth TINYINT, 
		OrderQty INT, 
		OrderQtyAcum INT
	)
	INSERT @ReporteVentas
	EXEC uPAnalisis_Ventas @OrderDateYear, @OrderDateMonthIni, @OrderDateMonthFin , @ProductID 
	SELECT * FROM @ReporteVentas
END
GO

EXEC uPReporte_Ventas 2014, 1, 6, 999

