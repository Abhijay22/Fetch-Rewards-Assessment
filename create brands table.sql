
Declare @JSON varchar(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\mishr\Desktop\brands_data_v2.json', SINGLE_CLOB) as users_test


SELECT * INTO brands_table FROM OPENJSON (@JSON) 
With (id nvarchar(max) '$._id.oid',
barcode nvarchar(max) '$.barcode',
category nvarchar(max) '$.category',
categoryCode nvarchar(max) '$.categoryCode',
cpgId nvarchar(max) '$.cpg.id.oid',
cpgRef nvarchar(max) '$.cpg.ref',
name nvarchar(max) '$.name',
topBrand nvarchar(max) '$.topBrand'
) 

select * from brands_table
 

