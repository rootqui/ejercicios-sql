with ListaProductosCategoria
as
(
	select p.ProductID + (select count(1) from Categories) as ProductID, p.ProductName, p.CategoryID
	from Products as p
	union all 
	select c.CategoryID, c.CategoryName, null 
	from Categories as c
),
Reporte
as
(
	select	pc.ProductID as Codigo,
			convert(varchar(1000), pc.ProductID) as CodigoJerarquico, 
			pc.ProductName
	from ListaProductosCategoria as pc
	where pc.CategoryID is null
	union all
	select	pc.ProductID,
			convert(varchar(1000),convert(varchar(1000), r.Codigo) +'.'+convert(varchar(1000),pc.ProductID-8)) as CodigoJerarquico, 
			pc.ProductName
	from Reporte as r join ListaProductosCategoria as pc
		on r.Codigo = pc.CategoryID
)select * from Reporte order by CodigoJerarquico
