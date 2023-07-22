-- 1. Implementar trigger que cancele la inserción/actualización de uno/varios registros de la tabla Calendario_PC5 
-- si CALE_CODIGO(int)  es diferente de la columna CALE_FECHA(date) convertida en int.

CREATE TRIGGER uTR_Calendario_Pc5_Insert_Update
	ON CALENDARIO_PC5
	AFTER INSERT, UPDATE
AS
BEGIN
	
	IF UPDATE(Cale_Codigo)
	BEGIN
		IF (SELECT COUNT(1) FROM Deleted) = 0 -- solo inserta registros
		BEGIN 
			DELETE c
			FROM Calendario_Pc5 AS c
			WHERE EXISTS(
				SELECT i.Cale_Codigo 
				FROM Inserted as i
				WHERE i.Cale_Codigo = c.Cale_Codigo 
					AND i.Cale_Codigo <> CONVERT(INT, CONVERT(SMALLDATETIME, i.Cale_Fecha))
			)
		END
		
		IF (SELECT COUNT(1) FROM Deleted) > 0 AND (SELECT COUNT(1) FROM Inserted) > 0   -- solo cuando actualiza registros
		BEGIN
			UPDATE c 
			SET c.Cale_Codigo = (SELECT d.Cale_Codigo 
								FROM Inserted AS i RIGHT JOIN Deleted AS d 
									ON i.Cale_Codigo = d.Cale_Codigo
								WHERE d.Cale_Fecha= c.Cale_Fecha)
			FROM Calendario_Pc5 AS c INNER JOIN Inserted AS i
				ON c.Cale_Codigo = i.Cale_Codigo 
			WHERE c.Cale_Codigo  <> CONVERT(INT, CONVERT(SMALLDATETIME, c.Cale_Fecha))
		END
	END

	IF UPDATE(Cale_Fecha)
	BEGIN
		UPDATE c
		SET c.Cale_Fecha = (SELECT d.Cale_Fecha
							FROM Deleted AS d 
							WHERE d.Cale_Codigo = c.Cale_Codigo)
		FROM Calendario_Pc5 AS c 
		WHERE c.Cale_Codigo  <> CONVERT(INT, CONVERT(SMALLDATETIME, c.Cale_Fecha))
	END
END