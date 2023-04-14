USE Pubs
-- Actualiza el campo ytd_sales de la tabla titles. Seg�n la definici�n, YTD 
-- significa "Year to date". Asume que estamos en el a�o 1994 (para adecuarnos 
-- a la data de Pubs) y actualiza el campo ytd_sales al monto monetario CORRECTO 
-- seg�n los datos de la tabla SALES.

UPDATE t
SET t.YTD_Sales = 
		(SELECT SUM(Qty)
		FROM Sales as s
		WHERE s.Title_Id = t.Title_Id 
				AND s.Ord_Date BETWEEN CONVERT(DATETIME, STR(1994)+'0101') AND DATEADD(YEAR,1994-YEAR(GETDATE()),GETDATE())
		)*Price 
FROM Titles AS t