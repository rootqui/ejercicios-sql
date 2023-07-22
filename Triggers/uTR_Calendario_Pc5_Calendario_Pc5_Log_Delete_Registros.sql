-- Implementar trigger que almacene en la tabla Calendario_PC5_Log el o los registros eliminados de la tabla 
-- Calendario_PC5

CREATE TRIGGER uTR_Calendario_Pc5_Calendario_Pc5_Log_Delete_Registros
ON Calendario_Pc5
	AFTER DELETE
AS
BEGIN
	INSERT INTO Calendario_Pc5_Log(Cale_Codigo, Cale_Fecha, Cale_Fecha_Log)
	SELECT Cale_Codigo, Cale_Fecha, CAST (GETDATE() AS SMALLDATETIME)
	FROM Deleted
END
