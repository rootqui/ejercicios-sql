-- Implementar procedimiento almacenado uSP_SincronizarHistorialProducto que permita sincronizar los registros de la tabla PRODUCTO hacia la 
-- tabla PRODUCTO_HISTORIAL
-- Utilizar instrucción MERGE
-- La ejecución del procedimiento debe generar tabla de resultados que permita visualizar los registros: 
-- insertados, actualizados y eliminados

CREATE uSP_SincronizarHistorialProducto
AS
BEGIN
	MERGE
	INTO PRODUCTO_HISTORIAL AS T
	USING 
		(select	pd.ID as ID, 
			pd.DESCRIPCION as DESCRIPCION, 
			pv.ID as ID_Proveedor, 
			pv.RAZON_SOCIAL as RAZON_SOCIAL_PROVEEDOR 
		from PRODUCTO as pd inner join PROVEEDOR as pv 
			on pd.ID_PROVEEDOR = pv.ID
		) AS S
	ON S.ID = T.ID 

	WHEN NOT MATCHED 
		THEN 
			INSERT (ID, DESCRIPCION, ID_PROVEEDOR, RAZON_SOCIAL_PROVEEDOR)
			VALUES (S.ID, S.DESCRIPCION, S.ID_PROVEEDOR, S.RAZON_SOCIAL_PROVEEDOR)
		

	WHEN MATCHED 
		AND (T.DESCRIPCION <> S.DESCRIPCION OR T.ID_PROVEEDOR <> S.ID_PROVEEDOR)   
		THEN 
			UPDATE 
			SET 
				DESCRIPCION = S.DESCRIPCION,
				ID_PROVEEDOR = S.ID_PROVEEDOR ,
				RAZON_SOCIAL_PROVEEDOR = S.RAZON_SOCIAL_PROVEEDOR
			
	WHEN NOT MATCHED BY SOURCE 
		THEN 
			DELETE
			
	OUTPUT	$ACTION, 
			INSERTED.ID AS ID_INSERTADO,
			INSERTED.DESCRIPCION AS DESCRIPCION_INSERTADO,
			INSERTED.ID_PROVEEDOR AS PROVEEDOR_INSERTADO,
			INSERTED.RAZON_SOCIAL_PROVEEDOR AS RAZON_SOCIAL_PROVEEDOR_INSERTADO,			
			DELETED.ID AS ID_ELIMINADO,
			DELETED.DESCRIPCION AS DESCRIPCION_ELIMINADO,
			DELETED.ID_PROVEEDOR AS ID_PROVEEDOR_ELIMINADO,
			DELETED.RAZON_SOCIAL_PROVEEDOR AS RAZON_SOCIAL_PROVEEDOR_ELIMINADO
	;
END


