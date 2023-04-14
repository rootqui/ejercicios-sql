USE Northwind
-- Los empleados con la fecha de contrato del a�o 1990 hasta 1993(excluido)
SELECT e.FirstName, e.LastName, e.HireDate
FROM Employees as e
WHERE HireDate BETWEEN '19900131' AND '19921231'

-- Los empleados que iniciaron su contrato en los tres primeros meses del a�o 1994
SELECT e.FirstName, e.LastName, e.HireDate
FROM Employees as e
WHERE HireDate BETWEEN '19940101' AND '19940331'