WITH ListaProductosCategoria
AS
(
	SELECT ROW_NUMBER() OVER(ORDER BY CategoryID) AS Id, *
	FROM
		(SELECT p.ProductID AS Codigo, 
				p.ProductName, 
				p.CategoryID
		FROM Products AS p
		UNION ALL
		SELECT c.CategoryID, c.CategoryName, NULL
		FROM Categories AS c) AS td
),
Reporte
AS
(
	SELECT	pc.Id,
			CAST(pc.Codigo AS VARCHAR) AS CodigoJerarquico, 
			pc.ProductName
	FROM ListaProductosCategoria AS pc
	WHERE pc.CategoryID IS NULL
	UNION ALL
	SELECT	pc.Id,
			CAST(CAST(r.Id AS VARCHAR) + '.' + CAST(pc.Codigo AS VARCHAR) AS VARCHAR) AS CodigoJerarquico, 
			pc.ProductName AS NombreProducto
	FROM Reporte AS r JOIN ListaProductosCategoria AS pc
		ON r.Id = pc.CategoryID
)
SELECT * 
FROM Reporte 
ORDER BY CodigoJerarquico