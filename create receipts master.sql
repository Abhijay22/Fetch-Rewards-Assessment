
Declare @JSON varchar(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\mishr\Desktop\receipts_data_v2.json', SINGLE_CLOB) as j_test


SELECT * INTO receipts_master FROM OPENJSON (@JSON) 
With (id nvarchar(max) '$._id.oid',
bonusPointsEarned float '$.bonusPointsEarned', 
bonusPointsEarnedReason nvarchar(max) '$.bonusPointsEarnedReason',
createDate nvarchar(max) '$.createDate.date', 
dateScanned nvarchar(max) '$.dateScanned.date', 
finishedDate nvarchar(max) '$.finishedDate.date', 
modifyDate nvarchar(max) '$.modifyDate.date', 
pointsAwardedDate nvarchar(max) '$.pointsAwardedDate.date',
pointsEarned float '$.pointsEarned',
purchaseDate nvarchar(max) '$.purchaseDate.date',
purchasedItemCount int '$.purchasedItemCount',
rewardsReceiptStatus nvarchar(max) '$.rewardsReceiptStatus',
totalSpent float '$.totalSpent',
userId nvarchar(max) '$.userId'
) 

select * from test_table

select * from receipts_master
 
select * from test_table t,test_table_2 t2 where t.id = t2.oid

