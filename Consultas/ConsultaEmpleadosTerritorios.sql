USE Northwind
-- Los empleados que vivan en algun territorio

SELECT e.FirstName, e.LastName, e.City
FROM Employees AS e
WHERE e.City IN (SELECT t.TerritoryDescription
				 FROM Territories AS t)

-- Los empleados que coincidan su ciudad con algunos territorios
SELECT e.FirstName, e.LastName, e.City
FROM Employees AS e
WHERE EXISTS (SELECT 1
			  FROM Territories AS t JOIN EmployeeTerritories AS et
					ON et.TerritoryID = t.TerritoryID
			  WHERE t.TerritoryDescription = e.City
					AND e.EmployeeID = et.EmployeeID)

-- Los empleados que vivan en London, Seattle y Redmond
SELECT e.FirstName, e.LastName, e.City
FROM Employees AS e
WHERE e.City IN ('London', 'Seattle', 'Redmond')