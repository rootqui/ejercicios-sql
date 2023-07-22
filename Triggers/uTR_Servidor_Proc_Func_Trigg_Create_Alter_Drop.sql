-- Implementar trigger de base de datos que bloquee la creacción/actualización/eliminación de estos objetos: 
-- procedimientos, funciones, funciones, triggers siempre que el usuario no tenga el rol sysadmin dentro de la base 
-- de datos.

CREATE TRIGGER uTR_Servidor_Proc_Func_Trigg_Create_Alter_Drop
	ON DATABASE
	FOR DDL_PROCEDURE_EVENTS, DDL_FUNCTION_EVENTS, DDL_TRIGGER_EVENTS
AS
BEGIN
	-- is el usuario no es miembro de sysadmin
	IF IS_SRVROLEMEMBER('sysadmin') = 0
		ROLLBACK;
END