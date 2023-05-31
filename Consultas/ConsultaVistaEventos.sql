WITH
CTE
AS
(
	Select *, 0 AS TAB, 
		CONVERT(VARCHAR(MAX), ROW_NUMBER() OVER (ORDER BY TYPE)) AS ORDEN
	From Sys.trigger_event_types
	where parent_type is null
	UNION ALL 
	SELECT T.*, C.TAB + 1, 
		 C.ORDEN + '.' + CONVERT(VARCHAR(MAX), ROW_NUMBER() OVER (PARTITION BY T.PARENT_TYPE ORDER BY C.TYPE)) AS ORDEN
	FROM CTE C
		INNER JOIN Sys.trigger_event_types T ON T.PARENT_TYPE = C.TYPE
)
SELECT TYPE, PARENT_TYPE,REPLICATE(' ', TAB * 8) + TYPE_NAME
FROM CTE
ORDER BY ORDEN