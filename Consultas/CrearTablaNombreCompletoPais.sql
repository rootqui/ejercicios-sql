USE Northwind
-- Crea una tabla llamada Personas y ponla en la base Northwind, dicha tabla 
-- debe contener dos campos: Nombre Completo y País. Utiliza las sentencias 
-- necesarias para llenar en esa tabla los datos de todos los clientes, 
-- proveedores y trabajadores de Northwind y además los datos de los autores 
-- y los empleados de Pubs. Como los datos de Pubs no tienen país, los registros 
-- procedentes de esta base de datos deberán cargarse con el país en blanco.


SELECT FirstName + ' ' + LastName AS [Nombre Completo], Country AS País 
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