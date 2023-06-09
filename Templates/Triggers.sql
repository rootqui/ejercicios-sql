-- TRIGGER DML AFTER
CREATE TRIGGER <uTR_NOMBRE>
	ON <TABLA>
	AFTER <instrucciones DML>
AS 
BEGIN
	SET NOCOUNT ON;

END
GO

-- Trigger Table InsteadOf (En vez de)
CREATE TRIGGER <NOMBRE>
	ON <TABLA>
	INSTEAD OF <DML>
AS
BEGIN
	SET NOCOUNT ON;

	<INSTRUCCIONES>
END

-- Trigger Base de Datos
CREATE TRIGGER <NOMBRE>
	ON DATABASE
	FOR <EVENTOS>
AS
BEGIN
	IF IS_MEMBER ('db_owner') = 0
	BEGIN
	  PRINT 'You must ask your DBA to drop or alter tables!' 
	  ROLLBACK TRANSACTION
	END
END

-- Trigger de Servidor
CREATE TRIGGER <nombre>
	ON ALL SERVER
	AFTER <EVENTOS>
AS
BEGIN
	<INSTRUCCIONES>
END

