USE Northwind
-- El ID del Cliente, nombre de la compañia y nombre de contacto, aquellos 
-- clientes que tienen la ciudad de la empresa diferente a la ciudad a donde 
-- se va a enviar la orden.


SELECT c.CustomerID, c.CompanyName, c.ContactName
FROM Customers AS c
WHERE EXISTS (SELECT 1
			  FROM Orders AS o
			  WHERE c.CustomerID = o.CustomerID 
					AND o.ShipCity != c.City)