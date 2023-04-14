USE Northwind
-- En una sola sentencia, crea una tabla que contenga los datos de los 
-- clientes que no han realizado compras.

SELECT *
INTO [Clientes Sin Compras]
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)