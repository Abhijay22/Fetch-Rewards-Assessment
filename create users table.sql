
Declare @JSON varchar(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\mishr\Desktop\users_data_v2.json', SINGLE_CLOB) as users_test


SELECT * INTO users_table FROM OPENJSON (@JSON) 
With (id nvarchar(max) '$._id.oid',
active nvarchar(max) '$.active',
createdDate nvarchar(max) '$.createdDate.date',
lastLogin nvarchar(max) '$.lastLogin.date',
role nvarchar(max) '$.role',
signUpSource nvarchar(max) '$.signUpSource',
state nvarchar(max) '$.state'
) 

select * from users_table
 

