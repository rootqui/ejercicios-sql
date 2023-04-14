USE Northwind
-- Actualiza el precio por envio a aquellas órdenes donde se haya vendido 
-- algún producto discontinuado. 

UPDATE o
SET o.Freight = 0
FROM Orders AS o JOIN [Order Details] AS od 
		ON o.OrderID = od.OrderID
	JOIN Products AS p
		ON p.ProductID = od.ProductID
WHERE p.Discontinued = 1
