CREATE VIEW uV_Customer_Products_ListaTop3
AS
SELECT	COALESCE(p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName
		, CONCAT('ClienteNro - ',c.CustomerID)) AS [Nombre Completo],
		dbo.uFN_Clientes_Productos_Lista(c.CustomerID) AS Lista
FROM Sales.Customer AS c LEFT JOIN Person.Person AS p
		ON p.BusinessEntityID = c.PersonID


SELECT * FROM uV_Customer_Products_ListaTop3
