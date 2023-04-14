USE Northwind
-- Reporte de ventas de todos los paises por mes y año

declare @paises varchar(max), @query varchar(max), @eliminarNulos varchar(max)

with Pais as (
select distinct Country
from Customers)
(Select	@paises = IsNull(@Paises + ',', '') + QuoteName(Country)
		,@eliminarNulos = IsNull(@eliminarNulos+',', '') + 'isnull('+ Country + ',0) as ' + Country
From Pais)

set @query =
'select	Periodo
		,' + @paises +
		', Total
from(
select	ISNULL(
		REPLICATE(''-'',5)+ convert(varchar,NombreMes),ISNULL(''Total '' + convert(varchar,Año),''Total General'')) as Periodo
		,ISNULL(Año,MAX(año*100) over (order by NroMes)) as Año
		,NroMes
		,'+ @eliminarNulos +'
		, Total
from (
	select	YEAR(o.OrderDate) as Año
			,Month(o.OrderDate) as NroMes
			,Datename(Month,o.OrderDate) as NombreMes
			,IsNull(c.Country,''Total'') as Pais 
			,round(sum(st.monto + o.Freight), 2) as Monto
	from 
			(select od.OrderID
					,convert(money,sum(od.Quantity*od.UnitPrice*(1-od.Discount))) as monto
			from [Order Details] as od
			group by od.OrderID) as st join Orders as o
				on st.OrderID = o.OrderID
			join Customers as c
			on c.CustomerID = o.CustomerID
	group by 
		grouping sets (
		(o.OrderID,YEAR(o.OrderDate), Datename(Month,o.OrderDate),Month(o.OrderDate), c.Country),
		(YEAR(o.OrderDate), c.Country),
		(YEAR(o.OrderDate), Datename(Month,o.OrderDate),Month(o.OrderDate)),
		(YEAR(o.OrderDate)),
		(c.Country),
		()
	)
) as td1

	pivot(
			sum(monto)
			for Pais in ('+ @paises +',[Total])			
	) as pvt

) td2
order by Año, NroMes'


exec(@query)


