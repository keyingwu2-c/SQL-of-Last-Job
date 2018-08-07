--采购申请明细商品重复：改了视图VW_PORequestEntryListCSP第一个子句

select * from  VW_PORequestEntryListCSP where FBizID ='{0}'
select * from  VW_PORequestEntryListCSP where FBillNo='PO180726002'

SELECT   a.FBillNo, a.FDate AS FReDate, a.FRequesterID, a.FBranchNo, a.FContact, a.FContactPhone, a.FAddress, 
                a.FCancellation, a.FNote, b.FIsSendEmail, b.FID, b.FInterID, b.FEntryID, b.FItemID, b.FSupplyID, b.FQty, b.FPrice, 
                b.FAmount, b.FUnitID, b.FStatus, b.FBizID, c.FBrands, c.FSupplyName, c.FItemID AS categoryID, c.FMeasureName, 
                s.FName AS FFinSupName, b.FSupID AS FFinSupID, d .Department_ID, d .Code, d .DeptName, d .DeptFullName, 
                y.FFileName, y.FDesc, c.FModel, c.FUserID, c.FConfig
FROM      dbo.PO_Request AS a INNER JOIN
                dbo.PO_RequestEntry AS b ON a.FBizID = b.FBizID left JOIN
                dbo.PO_Supplier AS s ON b.FSupID = s.FItemID INNER JOIN
                /*dbo.VW_CommodityMaxPricelistCSP AS c ON b.FItemID = c.FCommodityID INNER JOIN*/ dbo.VW_CommodityPriceInfoCSP
                 AS c ON b.FItemID = c.FCommodityID and b.FSupID=c.FSupID INNER JOIN
                dbo.HR_Department AS d ON a.FDeptID = d .Department_ID LEFT OUTER JOIN
                dbo.Base_Accessory AS y ON b.FAID = y.FID
where a.FBillNo='PO180726002'


SELECT a.FBillNo, a.FDate AS FReDate, a.FRequesterID, a.FBranchNo, a.FContact, 
                a.FContactPhone, a.FAddress, a.FCancellation, a.FNote, b.FIsSendEmail, b.FID, b.FInterID, b.FEntryID, b.FItemID, 
                b.FSupplyID, b.FQty, b.FPrice, b.FAmount, b.FUnitID, b.FStatus, b.FBizID, c.FBrands, c.FSupplyName, 
                c.FItemID AS categoryID, c.FMeasureName, c.FFinSupName, c.FFinSupID, d .Department_ID, d .Code, d .DeptName, 
                d .DeptFullName, y.FFileName, y.FDesc, c.FModel, c.FUserID, c.FConfig
FROM      dbo.PO_Request AS a INNER JOIN
                dbo.PO_RequestEntry AS b ON a.FBizID = b.FBizID INNER JOIN
                dbo.VW_Commoditylist AS c ON b.FItemID = c.FCommodityID INNER JOIN
                /*and (c.SupplyNote='没有分离数据备份20161114' or c.SupplyNote is NULL)*/ dbo.HR_Department AS d ON 
                a.FDeptID = d .Department_ID LEFT OUTER JOIN
                dbo.Base_Accessory AS y ON b.FAID = y.FID
where a.FBillNo='PO180726002'

--共同部分：
SELECT a.FBillNo, a.FDate AS FReDate, a.FRequesterID, a.FBranchNo, a.FContact, 
                a.FContactPhone, a.FAddress, a.FCancellation, a.FNote, b.FIsSendEmail, b.FID, b.FInterID, b.FEntryID, b.FItemID, 
                b.FSupplyID, b.FQty, b.FPrice, b.FAmount, b.FUnitID, b.FStatus, b.FBizID, d .Department_ID, d .Code, d .DeptName, 
                d .DeptFullName, y.FFileName, y.FDesc
FROM      dbo.PO_Request AS a INNER JOIN
                dbo.PO_RequestEntry AS b ON a.FBizID = b.FBizID
                INNER JOIN
                dbo.HR_Department AS d ON a.FDeptID = d .Department_ID LEFT OUTER JOIN
                dbo.Base_Accessory AS y ON b.FAID = y.FID
where a.FBillNo='PO180726002'

--检查第一个Union子句：
select * from PO_Supplier where FItemID is null
select * from VW_CommodityPriceInfoCSP where FCommodityID='1007830' 
order by FSupID,FPrice
select * from PO_Supply where FBillNo='CR160511001'

------------------------------------------------------------------------------------------
--下采购订单页面看不到商品信息(relevant)
select top 3 * from VW_CommodityPriceInfoCSP
select top 3 * from VW_Commoditylist


SELECT   a.FBillNo, a.FDate AS FReDate, a.FRequesterID, a.FBranchNo, a.FContact, a.FContactPhone, a.FAddress, 
                a.FCancellation, a.FNote, b.FIsSendEmail, b.FID, b.FInterID, b.FEntryID, b.FItemID, b.FSupplyID, b.FQty, b.FPrice, 
                b.FAmount, b.FUnitID, b.FStatus, b.FBizID, c.FBrands, c.FSupplyName, c.FItemID AS categoryID, c.FMeasureName, 
                 b.FSupID AS FFinSupID, d .Department_ID, d .Code, d .DeptName, d .DeptFullName, 
                y.FFileName, y.FDesc, c.FModel, c.FUserID, c.FConfig
FROM      dbo.PO_Request AS a INNER JOIN
                dbo.PO_RequestEntry AS b ON a.FBizID = b.FBizID INNER JOIN
                /*dbo.VW_CommodityMaxPricelistCSP AS c ON b.FItemID = c.FCommodityID INNER JOIN*/ dbo.VW_CommodityPriceInfoCSP
                 AS c ON b.FItemID = c.FCommodityID and 
				  INNER JOIN
                dbo.HR_Department AS d ON a.FDeptID = d .Department_ID LEFT OUTER JOIN
                dbo.Base_Accessory AS y ON b.FAID = y.FID
where a.FBillNo='PO180726002'

select * from VW_CommodityPriceInfoCSP where FCommodityID='1007830'
select * from VW_Commoditylist where FCommodityID='1007830'


SELECT   a.FInterID, a.FBillNo, a.FDate, a.FDeptID, a.FRequesterID, a.FBillerID, a.FCancellation, b.FStatus, 
                CASE WHEN b.FStatus = 1 THEN '审核中' WHEN b.FStatus = 2 THEN '通过' WHEN b.FStatus = 3 THEN '拒绝' ELSE '其他'
                 END AS FStatusName, a.FBizID, b.FID AS FCommodityID, 
                CASE WHEN b.FCategoryID1 = 1 THEN '是' ELSE '否' END AS FITType, 
                CASE WHEN b.FCategoryID2 = 1 THEN '是' ELSE '否' END AS FFXType, b.FSupplyName, b.FItemID, b.FModel, 
                b.FBrands, b.FConfig, b.FEntryID, b.FFinPrice, b.FNote, b.FFinSupID, b.FLastModifiedDate, b.FLastModifiedBy, 
                b.FSupID1, b.FPrice1, b.FSupID2, b.FPrice2, b.FSupID3, b.FPrice3, b.FMeasureUnitID, 
                CASE WHEN b.FZC = 1 THEN '是' ELSE '否' END AS FZC,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier
                     WHERE   (FItemID = b.FSupID1)) AS FSupName1,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier AS PO_Supplier_3
                     WHERE   (FItemID = b.FSupID2)) AS FSupName2,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier AS PO_Supplier_2
                     WHERE   (FItemID = b.FSupID3)) AS FSupName3,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier AS PO_Supplier_1
                     WHERE   (FItemID = b.FFinSupID)) AS FFinSupName,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier
                     WHERE   (FItemID = b.FSupID1)) + '/' + CAST(b.FPrice1 AS NVARCHAR(20)) AS FSupNamePrice1,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier AS PO_Supplier_3
                     WHERE   (FItemID = b.FSupID2)) + '/' + CAST(b.FPrice2 AS NVARCHAR(20)) AS FSupNamePrice2,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier AS PO_Supplier_2
                     WHERE   (FItemID = b.FSupID3)) + '/' + CAST(b.FPrice3 AS NVARCHAR(20)) AS FSupNamePrice3,
                    (SELECT   FName
                     FROM      dbo.PO_Supplier AS PO_Supplier_1
                     WHERE   (FItemID = b.FFinSupID)) + '/' + CAST(b.FFinPrice AS NVARCHAR(20)) AS FFinSupNamePrice, 
                ISNULL(b.FWarrantyPeriod, 0) AS FWarrantyPeriod, p.FServiceArea, cy.FCategoryName, cy.FType, b.FCategoryID1, 
                b.FCategoryID2, u.FName, cy.FUserID, cy.FIsProject, 
                CASE WHEN cy.FIsProject = 1 THEN '是' ELSE '否' END AS FProjectName, m.FName AS FMeasureName, 
                a.FNote AS SupplyNote
FROM      (SELECT   FInterID, FBillNo, FDate, FDeptID, FRequesterID, FBillerID, FCancellation, FNote, FStatus, FITClass, 
                                 FBizID
                 FROM      dbo.PO_Supply
                 WHERE   (FNote = '没有分离数据备份20161114' OR
                                 FNote IS NULL) AND (FStatus = 4)) AS a INNER JOIN
                    (SELECT   FID, FInterID, FSupplyName, FItemID, FCategoryID1, FCategoryID2, FModel, FBrands, FConfig, FEntryID, 
                                     FStatus, FNote, FFinSupID, FFinPrice, FSupID1, FPrice1, FSupID2, FPrice2, FSupID3, FPrice3, 
                                     FLastModifiedDate, FLastModifiedBy, FMeasureUnitID, FBizID, FZC, FWarrantyPeriod
                     FROM      dbo.PO_SupplyEntry
                     WHERE   (FStatus = 4)) AS b ON a.FBizID = b.FBizID LEFT OUTER JOIN
                dbo.VW_SupplierInfo AS p ON b.FFinSupID = p.FItemID LEFT OUTER JOIN
                dbo.Base_Category AS cy ON b.FItemID = cy.FCategoryID LEFT OUTER JOIN
                dbo.A_User AS u ON cy.FUserID = u.FUserID LEFT OUTER JOIN
                dbo.Base_MeasureUnit AS m ON b.FMeasureUnitID = m.FMeasureUnitID

select top 4 * from PO_Supply
select * from PO_SupplyEntry where FID='1007830'
select * from PO_SupplierDeliveryEntry where FItemID='1007830'


