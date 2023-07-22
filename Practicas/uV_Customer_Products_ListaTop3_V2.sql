use AdventureWorks2022
CREATE VIEW uV_Customer_Products_ListaTop3_V2
AS 
	select FullName, STRING_AGG(CONVERT(NVARCHAR(max), ISNULL(td1.Name,'N/A')), ', ') as Lista
	from (
		select	distinct td.*, pr.Name,
				coalesce(p.FirstName + ' ' + coalesce(p.MiddleName,'') + ' ' + p.LastName, cast(td.CustomerID as varchar)) as FullName
		from 
			(SELECT	ROW_NUMBER() over (partition by h.CustomerID order by sum(d.OrderQty) desc) as Nro,  
					h.CustomerID, 
					d.ProductID, 
					sum(d.OrderQty) AS TotalProductos
			FROM Sales.SalesOrderHeader AS h INNER JOIN Sales.SalesOrderDetail AS d
					ON d.SalesOrderID = h.SalesOrderID
			GROUP BY h.CustomerID, d.ProductID) as td
			inner join sales.Customer as c
				on c.CustomerID = td.CustomerID
			left join Person.Person as p
				on p.BusinessEntityID = c.CustomerID
			inner join sales.SpecialOfferProduct  as s
				on td.ProductID = s.ProductID 
			inner join Production.Product as pr
				on pr.ProductID = s.ProductID
		where Nro <= 3
		) as td1
	group by FullName


--select * from uV_Customer_Products_ListaTop3_V2