CREATE PROC uP_Product_Consulta
		@Name VARCHAR(100),
		@StartDate DATE = NULL,
		@EndDate DATE = NULL
AS	
	SELECT	COALESCE(pc.Name, 'Sin especificar') AS NombreCategoria,
			COALESCE(ps.Name, 'Sin especificar') AS NombreSubcategoria,
			p.ProductID AS CodigoProducto,
			p.Name AS NombreProducto,
			p.SellStartDate AS FechaInicioVenta,
			COALESCE(p.Color, 'De Fabrica') AS ColorProducto,
			COALESCE(pm.Name, 'Sin especificar') AS NombreModelo,
			p.StandardCost AS CostoEstandar,
			p.ReorderPoint AS PuntoReorden
	FROM Production.Product AS p LEFT JOIN Production.ProductSubcategory AS ps
			ON p.ProductSubcategoryID = ps.ProductSubcategoryID
		LEFT JOIN Production.ProductCategory AS pc
			ON pc.ProductCategoryID = ps.ProductCategoryID
		LEFT JOIN Production.ProductModel AS pm
			ON pm.ProductModelID = p.ProductModelID
	WHERE	p.Name LIKE CAST('%'+ @Name +'%' AS varchar(100))  AND
			p.SellStartDate BETWEEN COALESCE(@StartDate, (SELECT MIN(pp.SellStartDate) FROM Production.Product as pp))  AND COALESCE(@EndDate,(SELECT MAX(pp.SellStartDate) FROM Production.Product as pp))
	ORDER BY NombreCategoria, NombreSubcategoria, CodigoProducto

		


