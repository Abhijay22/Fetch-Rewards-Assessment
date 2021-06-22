SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'receipts_master'

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'users_table'

update receipts_master
set dateScanned = DATEADD(SECOND, cast(dateScanned as bigint)/1000 ,'1970/1/1')

select dateScanned from receipts_master

select id from receipts_master where YEAR(convert(datetime, cast(dateScanned as varchar),126)) = 2021 and MONTH(convert(datetime, cast(dateScanned as varchar),126)) = 3

update receipts_master
set dateScanned = convert(datetime, cast(dateScanned as varchar),126) 

select * from receipts_item where barcode is NULL and userFlaggedBarcode is null 

/*Question-1*/
select * from receipts_master rm, brands_table b, receipts_item ri where rm.id = ri.oid and ri.barcode = b.barcode and (YEAR(convert(datetime, cast(dateScanned as varchar),126)) = 2021) and (MONTH(convert(datetime, cast(dateScanned as varchar),126)) = 3)
select * from receipts_master
select distinct(b.name), count(rm.id) from brands_table b,receipts_master rm,receipts_item ri where rm.id = ri.oid and ri.barcode = b.barcode and (YEAR(convert(datetime, cast(dateScanned as varchar),126)) = 2021) group by b.name order by count(rm.id) desc

/*Question-3*/
select rewardsReceiptStatus, avg(totalSpent) Average from receipts_master group by rewardsReceiptStatus
/*Question-4*/
select rewardsReceiptStatus, count(purchasedItemCount) 'Purchase Count' from receipts_master group by rewardsReceiptStatus

select * from receipts_master where rewardsReceiptStatus = 'Rejected'

select count(*), count(rewardsProductPartnerId) rewardsProductPartnerId, count(barcode) Barcode, count(userFlaggedBarcode) userFlaggedBarcode, count(originalMetaBriteBarcode) originalMetaBriteBarcode, count(partnerItemId) partnerItemId from receipts_item

select count(id) ID, count(barcode) barcode, count(cpgId) cpgId from brands_table

select count(distinct b.cpgId) from receipts_item ri, brands_table b where ri.rewardsProductPartnerId = b.cpgId

select count(distinct b.cpgId) from brands_table b

select distinct name from brands_table