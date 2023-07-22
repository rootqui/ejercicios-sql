CREATE PROC uP_Producto_InicioVenta
	@ProductLine NCHAR(2),
	@Fabricados INT = 0 OUTPUT,
	@SinFabricar INT = 0 OUTPUT
AS
	SELECT @Fabricados = COUNT(1)
	FROM Production.Product AS pp
	WHERE COALESCE(pp.ProductLine, 'Sin especificar') = COALESCE(@ProductLine, pp.ProductLine,'Sin especificar') 
			AND MakeFlag = 1

	SELECT @SinFabricar=COUNT(1)
	FROM Production.Product AS pp
	WHERE COALESCE(pp.ProductLine, 'Sin especificar') = COALESCE(@ProductLine, pp.ProductLine,'Sin especificar') 
			AND MakeFlag = 0