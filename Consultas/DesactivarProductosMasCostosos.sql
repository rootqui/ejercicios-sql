USE Northwind
-- Desactiva los 3 productos más costosos que estén actualmente activos y que no 
-- se hayan vendido durante abril y mayo de 1998

UPDATE Products
SET Discontinued = 1
WHERE ProductID IN (
	SELECT TOP 3 WITH TIES ProductID
	FROM Products
	WHERE ProductID NOT IN (SELECT DISTINCT od.ProductID
							FROM Orders AS o JOIN [Order Details] AS od
								ON o.OrderID = od.OrderID
							WHERE o.OrderDate BETWEEN '19980401' AND '19980531') 
								AND Discontinued = 0
	ORDER BY UnitPrice DESC)
