CREATE FUNCTION uFNListaNumerosAsc
(
	@Num1 INT,
	@Num2 INT,
	@Num3 INT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @Lista VARCHAR(100) = ''
	DECLARE @Temp TABLE(N INT, Numero INT)
	DECLARE @i INT = 0
	DECLARE @Num VARCHAR(100)

	INSERT INTO @temp
	SELECT	ROW_NUMBER() OVER(ORDER BY Numero DESC),
			Numero
	FROM 
		(SELECT @Num1 AS Numero
		UNION ALL
		SELECT @Num2
		UNION ALL
		SELECT @Num3) AS Numeros
	
	WHILE(@i < 3)
	BEGIN
		SET @Num = CAST((SELECT Numero FROM @Temp WHERE N = @i + 1) AS VARCHAR(100))
		SET @Lista = CONCAT(@Lista,',' + @Num)
		SET @i = @i + 1
	END

	SET @Lista = SUBSTRING(@Lista, 2, LEN(@Lista))
	RETURN @Lista
END