CREATE FUNCTION uFNPalindromo
(
	@texto VARCHAR(1000)
)
RETURNS BIT
AS
BEGIN
	DECLARE @palindromo BIT

	IF (REPLACE(UPPER(@texto),' ', '') = REVERSE(REPLACE(UPPER(@texto),' ', '')))
	BEGIN
		SET @palindromo = 1
	END
	ELSE
	BEGIN 
		SET @palindromo = 0
	END
	RETURN @palindromo
END
