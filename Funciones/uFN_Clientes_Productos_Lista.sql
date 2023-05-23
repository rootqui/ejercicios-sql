CREATE FUNCTION uFN_Clientes_Productos_Lista
(
	@CustomerID INT
)
RETURNS VARCHAR(200)
AS
BEGIN
	DECLARE @lista VARCHAR(200) = ''
	DECLARE @i INT = 0
	DECLARE @nro INT = (SELECT COUNT(1) FROM dbo.uIF_Top3_Productos_Clientes(@CustomerID))
	WHILE @i < @nro
	BEGIN
		SELECT @lista = @lista + ', ' + CAST ((
							  SELECT '"'+p.Name+'"'
							  FROM dbo.uIF_Top3_Productos_Clientes(@CustomerID) AS t INNER JOIN Production.Product AS p
								ON p.ProductID = t.ProductID
							  ORDER BY TotalProductos DESC OFFSET @i ROWS FETCH NEXT 1 ROWS ONLY) AS VARCHAR(200))
		SET @i = @i + 1
	END
	
	SET @lista = LTRIM(@lista,',')
	RETURN @lista
END
