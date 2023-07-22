CREATE FUNCTION uTF_Todos_Clientes
(
)
RETURNS @Clientes TABLE 
(
	CustomerID INT,
	Nombre VARCHAR(400)
)
AS
BEGIN
	INSERT INTO @Clientes(CustomerID, Nombre)
	SELECT C.CustomerID, CONCAT(P.FirstName, ' ', coalesce(P.MiddleName, ' '), ' ', P.LastName) as Nombre
	FROM Person.Person AS P RIGHT JOIN Sales.Customer AS C
		ON P.BusinessEntityID = C.PersonID

	RETURN
END
