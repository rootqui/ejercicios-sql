-- Implementar script para importar un archivo xml escrito en disco (orders.xml) mediante la instruccion OPENXML, el contenido del archivo 
-- debe ser asignado a una variable de tipo XML.

DECLARE @XML XML
SELECT @XML = BulkColumn FROM OPENROWSET(BULK 'D:\Temp\Orders.xml', SINGLE_CLOB) MiTabla

DECLARE @i INT
EXEC sp_xml_preparedocument @i OUTPUT, @XML;
SELECT *
FROM OPENXML(@i, '/ROOT/Customers/Customer', 1) WITH (
        CustomerID VARCHAR(4) '@CustomerID',
        ContactName VARCHAR(1000) '@CustomerName',
		OrderID INT 'Orders/Order/@OrderID',
		OrderDate DATETIME 'Orders/Order/@OrderDate',
		ProductID INT 'Orders/Order/OrderDetail/@ProductID',
		Quantity DECIMAL(18, 2) 'Orders/Order/OrderDetail/@Quantity',
		[Address] VARCHAR(2000) '(Address)[1]'
    );