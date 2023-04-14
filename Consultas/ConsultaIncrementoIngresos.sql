USE Pubs
-- Consulta los ingresos de cada editorial por año y su incremento

SELECT	*
		,Monto - LAG(Monto,1) OVER (PARTITION BY Editorial ORDER BY Año) AS Incremento
FROM (SELECT DISTINCT p.Pub_Name AS Editorial ,YEAR(s.Ord_Date) AS Año,
	    	 SUM(s.Qty * t.Price) OVER (PARTITION BY p.Pub_Name, YEAR(s.Ord_Date) ORDER BY YEAR(s.Ord_Date) ) AS Monto
	 FROM Titles AS t JOIN Sales AS s
			ON t.Title_Id = s.Title_Id
		JOIN Publishers AS p
			ON p.Pub_id = t.Pub_id) AS td
