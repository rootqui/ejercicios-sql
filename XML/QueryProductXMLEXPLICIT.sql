-- Implementar script para exportar mediante una estructura XML los registros de la tabla PRODUCTO haciendo uso de la instrucción 
-- FOR XML EXPLICIT

SELECT  1 AS Tag,
        0 AS Parent,
        ID  AS [Producto!1!ID],
        DESCRIPCION AS [Producto!1!DESCRIPCION],
        ID_PROVEEDOR AS [Producto!1!ID_PROVEEDOR]
FROM PRODUCTO
FOR XML EXPLICIT;
