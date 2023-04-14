USE AdventureWorks2019
-- Implementar un SP para concultar la tabla product, debe recibir 
-- 2 parametros: uno obligatorio para filtrar por el nombre del producto 
-- con busqueda aproximada, el segundo de tipo opcional para filtrar por 
-- color. 

CREATE PROC uP_Product_ConsultaPorNombreYColor
	@Name VARCHAR(100), 
	@Color VARCHAR(30) = NULL 
AS
BEGIN
	SELECT * 
	FROM Production.Product AS p
	WHERE p.Name LIKE '%' + @Name + '%'
		AND COALESCE(p.Color, '') = COALESCE(@Color, COALESCE(p.Color, ''))
END
GO