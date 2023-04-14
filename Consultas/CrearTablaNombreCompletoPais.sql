USE Northwind
-- Crea una tabla llamada Personas y ponla en la base Northwind, dicha tabla 
-- debe contener dos campos: Nombre Completo y Pa�s. Utiliza las sentencias 
-- necesarias para llenar en esa tabla los datos de todos los clientes, 
-- proveedores y trabajadores de Northwind y adem�s los datos de los autores 
-- y los empleados de Pubs. Como los datos de Pubs no tienen pa�s, los registros 
-- procedentes de esta base de datos deber�n cargarse con el pa�s en blanco.


SELECT FirstName + ' ' + LastName AS [Nombre Completo], Country AS Pa�s 
INTO Personas
FROM Employees
UNION ALL
SELECT ContactName, Country
FROM Customers
UNION ALL
SELECT ContactName, Country
FROM Suppliers
UNION ALL
SELECT fname + ' ' + lname, ' ' 
FROM pubs.dbo.employee
UNION ALL
SELECT au_fname + ' ' + au_lname, ' '
FROM pubs.dbo.authors