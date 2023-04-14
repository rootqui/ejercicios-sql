USE Northwind
-- Crea una tabla con los siguientes campos: ID (int), Nombre (nvarchar de 40), 
-- Precio anterior (money) y Precio nuevo (money). 
-- Luego haz una sentencia (otra distinta) que actualice el precio de los 
-- 5 productos más baratos (de la tabla products) y les aumente 3 dólares a 
-- cada uno de ellos. Los datos que se hayan modificado deberán pasar 
-- automáticamente a la tabla creada al principio.

CREATE TABLE ProductosBaratos(
	ID INT,
	Nombre NVARCHAR(40),
	[Precio Anterior] MONEY,
	[Precio Nuevo] MONEY
)

UPDATE Products
SET UnitPrice = UnitPrice + 3
OUTPUT inserted.ProductID, inserted.ProductName,deleted.UnitPrice, inserted.UnitPrice
	INTO ProductosBaratos
FROM Products
WHERE ProductID IN (SELECT TOP 5 WITH TIES ProductID
					FROM Products
					ORDER BY UnitPrice)
