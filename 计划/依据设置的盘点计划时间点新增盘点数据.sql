-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  (每天的1:01执行)
-- Description: 依据设置的盘点计划时间点新增盘点数据（设置作业计划当天凌晨执行）  
-- =============================================  
CREATE PROCEDURE [dbo].[pr_AssetInvProgram_TimeToProData]  
AS  
BEGIN  
 Declare @fdeptID  NVarChar(50)  
 Declare @fProcessID   NVarChar(50)  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Insert statements for procedure here  
    Declare InvPData cursor FOR   
  select   a.FDeptID,a.FProcessID from AS_InventoryProgramEntry as a inner join HR_Department as b on a.FDeptID=b.Department_ID    
   where  datediff(day,a.FStartDate,GETDATE()) =0 AND FSTATUS=1  
 open InvPData  
  
 fetch next from InvPData into  
  @fdeptID,@fProcessID  
 while (@@fetch_status<>-1)  
    begin  
  INSERT INTO  [dbo].[AS_InvBackup]  
           ([FBillInterID] ,[FItemID],[FUnitID],[FKFDate]  
           ,[FKFPeriod],[FWarrantyDate],[FAssetNumber],[FUserDeptID],[FLocationID]  
           ,[FAssetStatus],[FQty],[FQtyAct],[FDateBackup]  
           ,[FDateCheck],[FCheckReason],[FStatus],[FModel])  
   SELECT FAlterID,FUnit,FBuyDate,  
    FLifePeriods,FWarrantyDate,FAssetNumber,FUserDeptID,FLocationID,  
      FStatusID,1,1,GETDATE(),null,'未盘',1,FModel FROM VW_AssetAllList  
   WHERE FStatusNumber like '001%'  and Code like (select Code from HR_Department where Department_ID='EAEC3086-6310-4BF8-868E-CA77B35BEE2F' )+'%'  
  
   INSERT INTO [dbo].[Base_Log]  
           ([FDate],[FUserID],[FFunctionID],[FStatement],[FDescription]) VALUES  
           (GETDATE(),65209,'',null,'盘点数据新增成功，部门ID-'+@fdeptID)  
   
      
  fetch next from InvPData into  
   @fdeptID,@fProcessID  
 end    
 close InvPData  
 deallocate InvPData  
      
     
  
END  

select * from HR_Department where Department_ID in
(
  select   a.FDeptID  from AS_InventoryProgramEntry as a inner join HR_Department as b on a.FDeptID=b.Department_ID    
   where  datediff(day,a.FStartDate,GETDATE()) =0 AND FSTATUS=1  
   )
   
   
   select * from AS_InvBackup where FBillInterID='IV18030701' and FDateBackup > '2018-03-07'
   
   
   select * from 
   AS_AssetCard a
   left join AS_FAStatus b on a.FStatusID=b.FID 
   inner JOIN dbo.AS_FAAssetMulAlter AS r with(nolock) on a.FAssetNumber=r.FAssetNumber AND r.IsCurStatus=1
   where b.FNumber like '001%'
   
   select * from VW_AssetAllList b where b.FStatusNumber like '001%'
   select * from AS_InvBackup where FBillInterID='IV18030701'
   
      SELECT FAlterID,FUnit,FBuyDate,  
    FLifePeriods,FWarrantyDate,FAssetNumber,FUserDeptID,FLocationID,  
      FStatusID,1,1,GETDATE(),null,'未盘',1,FModel FROM VW_AssetAllList  
   WHERE FStatusNumber like '001%' 