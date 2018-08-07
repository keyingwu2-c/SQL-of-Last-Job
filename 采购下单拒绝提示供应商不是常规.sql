--采购下单拒绝提示供应商不是常规 BUG在代码文件，本地已改
use pms; use pmstest;
select * from HR_Employee where FEmpName='杨梦鸿'
select * from  VW_PORequestEntryListCSP where FBizID ='8AAAE5D0-C8FA-4D44-B954-413B86BA1EE7'
select * from  VW_PORequestEntryListCSP where FID ='303454'
EXEC GetSupplierInfoByFItemIDCSP  '1008028','8AAAE5D0-C8FA-4D44-B954-413B86BA1EE7'
exec Check_SupplierForOrder '337','27362.00'

select * from PO_Supplier where FItemID='337'
select top 1 * from PO_Order
select * from PO_Order where FPOOrderBillNo='OR1806010003'
--delete from PO_Order where FPOOrderBillNo='OR1806010003'
select top 5 * from PO_OrderEntry order by FDate desc
select * from PO_OrderEntry where FBizID='c1b74665-19b0-4ee7-8056-ff2fc6eca5e9'
delete from PO_OrderEntry where FBizID='c1b74665-19b0-4ee7-8056-ff2fc6eca5e9'
select top 5 * from PO_RequestEntry
select * from PO_RequestEntry where FBizID='D4B46D0A-04A0-45D9-AD23-A2DB9559217D'
 
select top 5 * from PO_Request order by FDate desc