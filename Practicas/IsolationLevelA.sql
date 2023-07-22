-- CONEXION A
/*
Type
	RID = Bloqueo en una �nica fila de una tabla identificada por un identificador de fila (RID).
	KEY = Bloqueo en un �ndice que protege un intervalo de claves en transacciones serializables.
	PAG = Bloqueo en una p�gina de datos o de �ndices.
	EXT = Bloqueo en una extensi�n.
	TAB = Bloqueo en toda una tabla, incluidos todos los datos y los �ndices.
	DB = Bloqueo en una base de datos.
	FIL = Bloqueo en un archivo de base de datos.
	APP = Bloqueo en un recurso especificado por la aplicaci�n.
	MD = Bloqueos de metadatos o informaci�n de cat�logo.
	HBT = Bloqueo en un mont�n o �rbol B (HoBT). Esta informaci�n est� incompleta en SQL Server.
	AU = Bloqueo en una unidad de asignaci�n. Esta informaci�n est� incompleta en SQL Server.
Mode
	NULL = No se concede acceso al recurso. Sirve como marcador de posici�n.
	Sch-S = Estabilidad del esquema. Garantiza que un elemento de un esquema, como una tabla o un �ndice, no se quite mientras una sesi�n mantenga un bloqueo de estabilidad del esquema sobre �l.
	Sch-M = Modificaci�n del esquema. Debe mantenerlo cualquier sesi�n que desee cambiar el esquema del recurso especificado. Garantiza que ninguna otra sesi�n se refiera al objeto indicado.
	S = Compartido. La sesi�n que lo mantiene recibe acceso compartido al recurso.
	U = Actualizar. Indica que se ha obtenido un bloqueo de actualizaci�n sobre recursos que finalmente se pueden actualizar. Se utiliza para evitar una forma com�n de interbloqueo que tiene lugar cuando varias sesiones bloquean recursos para una posible actualizaci�n m�s adelante.
	X = Exclusivo. La sesi�n que lo mantiene recibe acceso exclusivo al recurso.
	IS = Intenci�n compartida. Indica la intenci�n de establecer bloqueos S en alg�n recurso subordinado de la jerarqu�a de bloqueos.
	IU = Actualizar intenci�n. Indica la intenci�n de establecer bloqueos U en alg�n recurso subordinado de la jerarqu�a de bloqueos.
	IX = Intenci�n exclusiva. Indica la intenci�n de colocar bloqueos X en algunos recursos subordinados en la jerarqu�a de bloqueos.
	SIU = Actualizar intenci�n compartida. Indica el acceso compartido a un recurso con la intenci�n de obtener bloqueos de actualizaci�n sobre recursos subordinados en la jerarqu�a de bloqueos.
	SIX = Intenci�n compartida exclusiva. Indica acceso compartido a un recurso con la intenci�n de obtener bloqueos exclusivos sobre recursos subordinados de la jerarqu�a de bloqueos.
	UIX = Actualizar intenci�n exclusiva. Indica un bloqueo de actualizaci�n en un recurso con la intenci�n de adquirir bloqueos exclusivos sobre recursos subordinados en la jerarqu�a de bloqueos.
	BU = Actualizaci�n masiva. Utilizado en las operaciones masivas.
	RangeS_S = Intervalo de claves compartido y bloqueo de recurso compartido. Indica recorrido de intervalo serializable.
	RangeS_U = Intervalo de claves compartido y bloqueo de recurso de actualizaci�n. Indica recorrido de actualizaci�n serializable.
	RangeI_N = Insertar intervalo de claves y bloqueo de recurso Null. Se utiliza para probar los intervalos antes de insertar una clave nueva en un �ndice.
	RangeI_S = Bloqueo de conversi�n de intervalo de claves. Creado por una superposici�n de bloqueos RangeI_N y S.
	RangeI_U = Bloqueo de conversi�n de intervalo de claves creado por una superposici�n de bloqueos RangeI_N y U.
	RangeI_X = Bloqueo de conversi�n de intervalo de claves creado por una superposici�n de bloqueos RangeI_N y X.
	RangeX_S = Bloqueo de conversi�n de rango de claves creado por una superposici�n de bloqueos RangeI_N y RangeS_S Cerraduras.
	RangeX_U = Bloqueo de conversi�n de intervalo de claves creado por una superposici�n de bloqueos RangeI_N y RangeS_U.
	RangeX_X = Intervalo de claves exclusivo y bloqueo de recurso exclusivo. Es un bloqueo de conversi�n que se utiliza cuando se actualiza una clave de un intervalo.	
*/
EXEC SP_LOCK

-- TEST 1 - BLOQUEOS
SELECT * FROM PRODUCT 

BEGIN TRANSACTION A
	SELECT * FROM PRODUCT
	--10	PRODUCTO 10
	--11	PRODUCTO 11
	--42	PRODUCTO 42
	--72	PRODUCTO 72
	INSERT INTO PRODUCT VALUES (100, 'PRODUCTO 100')
	SELECT * FROM PRODUCT
	--10	PRODUCTO 10
	--11	PRODUCTO 11
	--42	PRODUCTO 42
	--72	PRODUCTO 72
	--100	PRODUCTO 100

ROLLBACK TRANSACTION A

SELECT @@TRANCOUNT

--TEST 2 - ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRANSACTION A
	SELECT * FROM PRODUCT
	DELETE PRODUCT WHERE ID = 101
	SELECT * FROM PRODUCT
ROLLBACK TRANSACTION A
SELECT * FROM PRODUCT

BEGIN TRANSACTION B
	SELECT * FROM ORDER_DETAIL 
	UPDATE ORDER_DETAIL SET QUANTITY = 50 WHERE ID_ORDER = 1 AND ID = 1
	SELECT * FROM ORDER_DETAIL WHERE ID_ORDER = 1 AND ID = 1
ROLLBACK TRANSACTION B

-- TEST 3 - ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
	SELECT * FROM PRODUCT WHERE ID = 10

ROLLBACK TRANSACTION
	
SET TRANSACTION ISOLATION LEVEL 
REPEATABLE READ

BEGIN TRANSACTION
	SELECT * FROM PRODUCT WHERE ID = 10
ROLLBACK TRANSACTION


-- TEST 4 - ISOLATION LEVEL SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL 
SERIALIZABLE

SELECT * FROM PRODUCT ORDER BY ID

BEGIN TRANSACTION
	SELECT * FROM PRODUCT WHERE ID < 20

ROLLBACK TRANSACTION

-- TEST 5 - ISOLATION LEVEL SNAPSHOT
SET TRANSACTION ISOLATION LEVEL 
READ COMMITTED

BEGIN TRANSACTION
	SELECT * FROM PRODUCT WHERE ID = 10
	UPDATE PRODUCT SET NAME = NAME + ' UPDATE' WHERE ID = 10
	SELECT * FROM PRODUCT WHERE ID = 10
COMMIT TRANSACTION
ROLLBACK TRANSACTION

SELECT * FROM PRODUCT WHERE ID = 10

-------
BEGIN TRANSACTION
	SELECT * FROM PRODUCT WHERE ID = 10
	UPDATE PRODUCT SET NAME = NAME + ' UPDATE' WHERE ID = 10
	SELECT * FROM PRODUCT WHERE ID = 10
COMMIT TRANSACTION

SELECT * FROM PRODUCT WHERE ID = 10