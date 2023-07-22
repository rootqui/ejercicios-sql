-- Implementar trigger que cancele la inserción/actualización de valores duplicados en la columna CALE_FECHA de 
-- la tabla Calendario_PC5, esta columna sólo debe contener valores únicos.

CREATE TRIGGER uTR_Calendario_Pc5_Fecha_Duplicados_Insert_Update
	ON Calendario_Pc5
	AFTER INSERT, UPDATE
AS
BEGIN
	IF UPDATE(Cale_Fecha)
	BEGIN 
		DECLARE @nReg INT = (SELECT COUNT(1) FROM Deleted)

		IF (@nReg = 0)
		BEGIN  
			DELETE FROM Calendario_Pc5
			WHERE Cale_Codigo IN (
				SELECT i.Cale_Codigo
				FROM Inserted AS i 
				WHERE EXISTS (SELECT 1
							  FROM Calendario_Pc5 AS c 
							  WHERE i.Cale_Fecha = c.Cale_Fecha AND i.Cale_Codigo <> c.Cale_Codigo)
			)
		END
		ELSE 
		BEGIN 
			IF EXISTS (SELECT 1
					   FROM Inserted AS i 
						WHERE EXISTS (SELECT 1
									 FROM Calendario_Pc5 AS c 
									 WHERE i.Cale_Fecha = c.Cale_Fecha AND 
										   i.Cale_Codigo <> c.Cale_Codigo))
			BEGIN 
				UPDATE c
				SET c.Cale_Fecha = d.Cale_Fecha
				FROM Calendario_Pc5 AS c INNER JOIN Deleted AS d
					ON c.Cale_Codigo = d.Cale_Codigo 
			END 
		END 
	END
END


