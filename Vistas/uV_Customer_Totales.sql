CREATE VIEW uV_Customer_Totales
AS
SELECT COALESCE(p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName, CAST(c.CustomerID AS VARCHAR(300))) AS [Nombre Completo], 
		COALESCE(SUM(Total), 0) AS Total
FROM
	(SELECT h.CustomerID, SUM(d.UnitPrice*d.OrderQty*(1 - d.UnitPriceDiscount)) + h.TaxAmt + h.Freight AS Total
	FROM Sales.SalesOrderDetail AS d JOIN Sales.SalesOrderHeader AS h
		ON d.SalesOrderID = h.SalesOrderID
	GROUP BY h.SalesOrderID, h.TaxAmt, h.Freight, h.CustomerID) AS totales
	RIGHT JOIN Sales.Customer AS c 
		ON c.CustomerID = totales.CustomerID
	LEFT JOIN Person.Person AS p
		ON p.BusinessEntityID = c.PersonID
GROUP BY c.CustomerID, p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName