CREATE PROC uSP_SincronizarProducto_XML 
	@XML XML
AS
BEGIN 
	-- Se agrega una linea porque el SP no devuelve el xml con una etiqueta ROOT
	set @XML = CAST(('<ROOT>' + CAST(@XML AS VARCHAR(MAX)) + '</ROOT>') AS XML)

	;WITH
	CTE_XML
	AS
	(
		SELECT 
			ID  = T.Item.value('ID[1]', 'INT'),
			DESCRIPCION = T.Item.value('DESCRIPCION[1]', 'VARCHAR(50)'),
			ID_PROVEEDOR = T.Item.value('ID_PROVEEDOR[1]', 'INT')
		FROM @XML.nodes('/ROOT/row') AS T(Item)	
	)
	MERGE
		INTO PRODUCTO AS P
		USING CTE_XML AS S
		ON S.ID = P.ID

		WHEN NOT MATCHED 
			THEN 
				INSERT (ID, DESCRIPCION, ID_PROVEEDOR)
				VALUES (S.ID, S.DESCRIPCION, S.ID_PROVEEDOR)
		;
END
			
-- Ejecutar las siguientes instrucciones para realizar pruebas 
DECLARE @XML XML
EXEC uSP_PRODUCTO_ALEATORIO_XML @XML OUTPUT

EXEC uSP_SincronizarProducto_XML @XML

SELECT @XML
SELECT * FROM PRODUCTO
