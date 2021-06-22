Declare @JSON varchar(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\mishr\Desktop\receipts_data_v2.json', SINGLE_CLOB) as j_test

Select
    _id.oid, rewardsReceiptItemList.barcode, rewardsReceiptItemList.originalMetaBriteBarcode, rewardsReceiptItemList.itemdescription,
	rewardsReceiptItemList.finalprice,rewardsReceiptItemList.itemprice,rewardsReceiptItemList.needsFetchReview,rewardsReceiptItemList.needsFetchReviewReason,
	rewardsReceiptItemList.partnerItemId,rewardsReceiptItemList.preventTargetGapPoints,rewardsReceiptItemList.quantityPurchased,rewardsReceiptItemList.userFlaggedBarcode,
	rewardsReceiptItemList.userFlaggedDescription,rewardsReceiptItemList.userFlaggedNewItem,rewardsReceiptItemList.userFlaggedPrice,rewardsReceiptItemList.userFlaggedQuantity,
	rewardsReceiptItemList.pointsNotAwardedReason,rewardsReceiptItemList.pointsPayerId,rewardsReceiptItemList.rewardsGroup,
	rewardsReceiptItemList.rewardsProductPartnerId,rewardsReceiptItemList.targetPrice,rewardsReceiptItemList.competitiveProduct

into receipts_item_withoutid from openjson (@json)
with
(
	_id nvarchar(max) as json,
	rewardsReceiptItemList nvarchar(max) as json
)
as Receipts
cross apply openjson (Receipts.rewardsReceiptItemList)
with
(
    barcode nvarchar(max),
	originalMetaBriteBarcode nvarchar(max),
	itemDescription nvarchar(max),
	finalPrice nvarchar(max),
	itemPrice nvarchar(max),
	needsFetchReview nvarchar(max),
	needsFetchReviewReason nvarchar(max),
	partnerItemId nvarchar(max),
	preventTargetGapPoints nvarchar(max),
	quantityPurchased nvarchar(max),
	userFlaggedBarcode nvarchar(max),
	userFlaggedDescription nvarchar(max),
	userFlaggedNewItem nvarchar(max),
	userFlaggedPrice nvarchar(max),
	userFlaggedQuantity nvarchar(max),
	pointsNotAwardedReason nvarchar(max),
	pointsPayerId nvarchar(max),
	rewardsGroup nvarchar(max),
	rewardsProductPartnerId nvarchar(max),
	targetPrice nvarchar(max),
	competitiveProduct nvarchar(max)

) as rewardsReceiptItemList
cross apply openjson (Receipts._id)
with
(
    oid nvarchar(max)
) as _id


SELECT *, ROW_NUMBER() OVER (PARTITION BY oid ORDER BY oid) itemID into receipts_item FROM receipts_item_withoutid

