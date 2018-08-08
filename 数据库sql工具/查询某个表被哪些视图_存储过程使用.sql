--查询某个表被哪些视图/存储过程使用（type='P':表示存储过程，type='V':表示视图）
SELECT OBJECT_NAME(id) FROM syscomments 
WHERE id IN(SELECT object_id FROM sys.objects WHERE type='p')
AND text LIKE '%VW_DelDeptAssetAlertRight%' 
 
--查询各个表的记录数
SELECT A.name AS '表名',MAX(B.rows) AS '记录数' 
FROM sysobjects A  
INNER JOIN sysindexes B ON A.id=B.id 
WHERE A.xtype='u'
GROUP BY A.name
ORDER BY MAX(B.rows) DESC
--VW_POSpecialSupDeliveryEntryInfo2


select * from A_EmployeeRight_Table
select * from A_DataRightScheme_Table

--GetUserMenuOprate



CREATE proc [dbo].[GetUserMenuOprate]  
@empId varchar(100),  
@menuId varchar(100)  
as  
  
declare @countRecord int,@positionId varchar(50), @groupId varchar(50)  
  
select @countRecord=count(*) from A_EmployeeRight_Table  
where EM_ID=@empId  
--print @menuId  
if @empId='4617D9BA-A04B-42E2-A864-4A1723D95E00' and @menuId='CC9C8374-37FC-4C1F-8EA7-5209EAEC77C7'  
begin  
 select MenuID,RightType from A_EmployeeRight_Table where 1=2  
end  
else if(@menuId<>'' or @menuId <>null)  
begin  
 select MenuID,RightType from A_EmployeeRight_Table where EM_ID=@empId and MenuID=@menuId  
 union  
 (select a.FMenuID as MenuID,a.FRightType as RightType   from A_DataRightScheme_Table as a inner join      
   (select GroupID from dbo.A_RightGroup_Position where   
    PositionID=(select PositionId from dbo.VW_UserList where FEmpID=@empId)) as b on a.FGroupID=b.GroupID and a.FMenuID=@menuId  
 )  
 union  
 select FMenuID as MenuID,FRightType as RightType   from A_DataRightScheme_Table where FGroupID='B730BB32-8044-4D08-B9E2-199380B27EA8' and FMenuID=@menuId  
end  
else  
begin  
 select MenuID,RightType from A_EmployeeRight_Table where EM_ID=@empId  
 union  
 (select a.FMenuID as MenuID,a.FRightType as RightType from A_DataRightScheme_Table  as a inner join      
   (select GroupID from dbo.A_RightGroup_Position where   
  PositionID=(select PositionId from dbo.VW_UserList where FEmpID=@empId)) as b on  a.FGroupID=b.GroupID)  
 union  
 select FMenuID as MenuID,FRightType as RightType from A_DataRightScheme_Table where FGroupID='B730BB32-8044-4D08-B9E2-199380B27EA8'  
end  
  
  
--if(@countRecord>0)  
-- begin   
--  if(@menuId<>'' or @menuId <>null)  
--   begin  
--    select MenuID,RightType from A_EmployeeRight_Table where EM_ID=@empId and MenuID=@menuId  
--   end   
--  ELSE  
--   BEGIN  
--    select MenuID,RightType from A_EmployeeRight_Table where EM_ID=@empId  
--   END  
-- end  
--else  
-- begin  
--  select @positionId=PositionId from dbo.VW_UserList where FEmpID=@empId  
--  if(@positionId is not null)  
--   begin  
--    select @groupId=GroupID from dbo.A_RightGroup_Position where PositionID=@positionId  
--    if(@groupId is not null)  
--    begin  
--     if(@menuId<>'' or @menuId<>null)  
--      begin  
--       select FMenuID as MenuID,FRightType as RightType   from A_DataRightScheme_Table where FGroupID=@groupId and FMenuID=@menuId  
--      end   
--     ELSE  
--      BEGIN  
--       select FMenuID as MenuID,FRightType as RightType from A_DataRightScheme_Table where FGroupID=@groupId  
--      END  
--    end  
--    else  --普通用户的情况  
--    begin  
--     if(@menuId<>'' or @menuId<>null)  
--      begin  
--       select FMenuID as MenuID,FRightType as RightType   from A_DataRightScheme_Table where FGroupID='B730BB32-8044-4D08-B9E2-199380B27EA8' and FMenuID=@menuId  
--      end   
--     ELSE  
--      BEGIN  
--       select FMenuID as MenuID,FRightType as RightType from A_DataRightScheme_Table where FGroupID='B730BB32-8044-4D08-B9E2-199380B27EA8'  
--      END      
--    end  
--   end  
   
-- end  

