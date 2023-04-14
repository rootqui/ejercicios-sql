USE AdventureWorks2019
-- Implementar un procedimiento almacenado que filtre por nombre y color 
-- del producto, ademas que retorne el numero de registros de la consulta.

CREATE PROC uP_Product_Filtrar_Nombre_Color
	@Name VARCHAR(100), 
	@Color VARCHAR(30) = NULL, 
	@Registros INT = 0 OUTPUT
AS
BEGIN
	SELECT * 
	FROM Production.Product AS p
	WHERE p.Name LIKE '%' + @Name + '%'
		AND COALESCE(p.Color, '') = COALESCE(@Color, COALESCE(p.Color, ''))

	SET @Registros = @@ROWCOUNT 
END
GO