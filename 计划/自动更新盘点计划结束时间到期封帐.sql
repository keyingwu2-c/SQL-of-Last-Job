-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  ��ÿ���1:05ִ�У�
-- Description: �̵�ƻ������Զ�����  
-- =============================================  
CREATE PROCEDURE [dbo].[pr_AssetInvProgram_AutoUpdate]  
AS  
BEGIN  
 Declare @fprocessID nvarchar(50)  
 Declare @iday int  
 Declare @fid int  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
  
    -- Insert statements for procedure here  
 if exists(select * from AS_InventoryProgram  where FStatus=1)  
 begin  
  select @fprocessID=FProcessID from AS_InventoryProgram  where FStatus=1  
  Declare CountData cursor FOR   
   select FID,datediff(day,ISNULL(FDelayDate,FEndDate),GETDATE()) as iday 
   from AS_InventoryProgramEntry where FProcessID=@fprocessID and FStatus=1  
  open CountData  
   
  fetch next from CountData into  
   @fid,@iday  
  while (@@fetch_status<>-1)  
        begin  
   if @iday>=1  
    Update AS_InventoryProgramEntry Set  FStatus=2 where FID=@fid  
          
   fetch next from CountData into  
    @fid,@iday  
  end    
  close CountData  
  deallocate CountData  
    
  if not exists(select *  from AS_InventoryProgramEntry where FProcessID=@fprocessID and FStatus=1)  
  begin  
   Update AS_InventoryProgram Set FStatus=2 where FProcessID=@fprocessID  
     
   --2016-09-05 ����ʵ������  ���� ���̵�ԭ����δ��,��δ���и������룬�������̿�  
   --�ѹ��ʲ��̵�ʱ�䣬��û��ȷ���̵㣬�������̿�  
     
   Update AS_InvBackup set FQtyAct=0 
   where FBillInterID=@fprocessID and FAssetNumber in   
   (
	select FAssetNumber from VW_InvBackup  
	where  FProcessID=@fprocessID and FStatusName='����' and  FCheckReason='δ��'  
	and FAssetNumber not in   
	 (
		select c.FAssetNumber from AS_InvReplay as a 
		inner join AS_InvReplayEntry as b on a.FBizID=b.FBizID 
		inner join AS_InvBackup as c on b.FInvBillNo=c.FID  
		where  a.FStatus=2 and c.FBillInterID=@fprocessID
	 ) 
   )  
   
   Update AS_InvBackup set FQtyAct=0 where  FBillInterID=@fprocessID and FAssetNumber in   
   (
		select FAssetNumber from  [VW_InvBackup] where  FProcessID=@fprocessID and FStatusName<>'����'  
   )  
     
     
     
  end  
 end  
   
END  