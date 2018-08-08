-- =============================================        
-- Author:  <Author,,Name>        
-- Create date: <Create Date,,>        
-- Description: 设置文员，秘书，行政主任权限        
-- 工程类查询：区经（含）级别以上才能查看工程类采购信息(这里增加设置)        
-- =============================================        
CREATE PROCEDURE [dbo].[SynRight_AutoFromAttend]         
AS        
BEGIN        
 -- SET NOCOUNT ON added to prevent extra result sets from        
 -- interfering with SELECT statements.        
 SET NOCOUNT ON;        
        
    -- Insert statements for procedure here        
    --删除工程类查询组职位        
    Delete from  A_RightGroup_Position where GroupID='DF3B9CE1-03CF-4647-9E93-2A0CAC5318C9'        
            
    insert into A_RightGroup_Position (GroupID,PositionID)          
  select  distinct 'DF3B9CE1-03CF-4647-9E93-2A0CAC5318C9',PositionID from VW_PersonnelInfo where (        
  DeptFullName like  '中原/深圳中原/住宅东区%' or DeptFullName like  '中原/深圳中原/住宅环中区%'         
  or DeptFullName like  '中原/深圳中原/住宅西区%' or DeptFullName like  '中原/深圳中原/住宅中心区%'           
  or  DeptFullName like  '中原/深圳中原/三级市场工商铺部%')        
  and FStatus=1 and FRank>4 and PositionName not like '%分行经理%'          
         
         
         
    --职能中心授权（用于故障申报权限）        
    Delete from  A_RightGroup_Position where GroupID='FAF8B57C-159D-4A16-9416-FB51277801A9'        
    and PositionID not  in (select distinct  a.FPosID from HR_PositionSys  as a  inner join  HR_Department as b         
     on a.FDeptID=b.Department_ID where b.DeptFullName like '%中原/深圳中原/职能中心%'        
     and b.FDeleted=1 and a.FDelete=0        
                     )        
                
    insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct 'FAF8B57C-159D-4A16-9416-FB51277801A9', a.FPosID from HR_PositionSys  as a  inner join  HR_Department as b         
     on a.FDeptID=b.Department_ID where b.DeptFullName like '%中原/深圳中原/职能中心%'        
     and b.FDeleted=1 and a.FDelete=0 and         
     a.FPosID not in (select  PositionID from A_RightGroup_Position where GroupID='FAF8B57C-159D-4A16-9416-FB51277801A9' )        
             
            
 --文员组(包括住宅和工商铺文员，二级秘书) （界面已开通该组，并授权相关菜单权限，这里需要开通部门查看范围，需从考勤系统同步）         
 --select * from  A_RightGroup where Name ='文员组'         
 Delete From A_RightGroup_Position where PositionID in         
  (select distinct PositionID from VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%行政文员%'         
  union        
  select distinct PositionID from VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%行政文员%'           
  )        
          
 Delete From A_EmployeeRight_Range Where EmpID in         
    (select distinct  FEmpID  from VW_PersonnelInfo   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%行政文员%'        
  union        
  select distinct  FEmpID  from VW_PersonnelInfo   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%行政文员%'  )        
          
 Delete From AS_FAAssetManager   Where FAAssetManagerID  in         
    (select distinct  b.FUserID  from VW_PersonnelInfo as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%行政文员%'        
  union         
  select distinct  b.FUserID  from VW_PersonnelInfo as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'      
  and PositionName like '%行政文员%'  )        
        
          
 Delete From A_RightGroup_Position where PositionID in         
  (select distinct FPosID from VW_EmpJobsInfo_All   where DeptFullName like         
   (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%行政主任%' union        
  select distinct FPosID from VW_EmpJobsInfo_All   where DeptFullName like         
   (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%行政主任%'  )        
          
 Delete From A_EmployeeRight_Range Where EmpID in         
    (select distinct  FEmpID  from VW_EmpJobsInfo_All   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%行政主任%' union         
  select distinct  FEmpID  from VW_EmpJobsInfo_All   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%行政主任%' )        
          
 Delete From AS_FAAssetManager   Where FAAssetManagerID  in         
    (select distinct  b.FUserID  from VW_EmpJobsInfo_All as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%行政主任%' union        
  select distinct  b.FUserID  from VW_EmpJobsInfo_All as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%行政主任%' )        
        
         
          
 Delete From A_RightGroup_Position where PositionID in         
  (select distinct PositionID from VW_PersonnelInfo   where DeptFullName like        
  (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'        
  and DeptFullName<>'中原/深圳中原/职能中心/行政部'           
  and PositionName like '%秘书%'  )        
          
 Delete From A_EmployeeRight_Range Where EmpID in         
    (select distinct  FEmpID  from VW_PersonnelInfo   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'          
     and DeptFullName<>'中原/深圳中原/职能中心/行政部'         
  and PositionName like '%秘书%')        
          
 Delete From AS_FAAssetManager   Where FAAssetManagerID  in         
    (select distinct  b.FUserID  from VW_PersonnelInfo as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'        
     and a.DeptFullName<>'中原/深圳中原/职能中心/行政部'         
  and PositionName like '%秘书%' and FEmpCode<>'88905' and FEmpCode<>'21277')        
          
 insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',PositionID from  VW_PersonnelInfo           
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
   and PositionName like '%行政文员%'  and FStatus=1 union        
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',PositionID from  VW_PersonnelInfo           
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
   and PositionName like '%行政文员%'  and FStatus=1        
           
           
         
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%行政文员%'  and FStatus=1 union         
  select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%行政文员%' )        
          
 insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
  select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
     inner join A_User as c on b.DomainAccount=c.FAccount        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%行政文员%'  and FStatus=1 union        
  select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%行政文员%' )        
          
 --insert into A_RightGroup_Position (GroupID,PositionID)          
 -- select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',PositionID from  VW_PersonnelInfo           
 --  where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
 --  and PositionName like '%行政主任%'  and FStatus=1        
         
 --insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
 -- select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
 --    inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
 -- where a.Code in         
 -- (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
 -- (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
 -- and PositionName like '%行政主任%'  and FStatus=1 )        
         
 --insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
 -- select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
 --    inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
 --    inner join A_User as c on b.DomainAccount=c.FAccount        
 -- where a.Code in         
 -- (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
 -- (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
 -- and PositionName like '%行政主任%'  and FStatus=1 )        
           
        
 insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
   and FPosName like '%行政主任%'  and FStatus=1 union        
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
   and FPosName like '%行政主任%'  and FStatus=1         
           
 insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct 'B50C0806-9F6D-4685-81FF-6EB6368A048B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
   and FPosName like '%行政主任%'  and FStatus=1 union        
  select distinct 'B50C0806-9F6D-4685-81FF-6EB6368A048B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
   and FPosName like '%行政主任%'  and FStatus=1         
           
         
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
  where a.Code in         
  (select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%行政主任%'  and FStatus=1 union        
  select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%行政主任%'  and FStatus=1        
  )           
 insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
  select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
     inner join A_User as c on b.DomainAccount=c.FAccount        
  where a.Code in         
  (select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%行政主任%'  and FStatus=1 union        
  select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%行政主任%'  and FStatus=1 )        
          
          
         
  insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct 'F8FB9DA9-80D0-4DCD-89F2-4C75E118B803',PositionID from  VW_PersonnelInfo           
   --where DeptFullName like (select DeptFullName from HR_Department where Department_ID='56B521E9-E73A-41E6-A510-8D9EE72BB4EB')+'%'        
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'         
   and DeptFullName<>'中原/深圳中原/职能中心/行政部'             
   and  PositionName like '%秘书%'  and FStatus=1        
           
            
           
         
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'          
  and DeptFullName<>'中原/深圳中原/职能中心/行政部'           
  and  PositionName like '%秘书%'  and FStatus=1 )        
          
 insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
  select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
     inner join A_User as c on b.DomainAccount=c.FAccount        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'         
  and DeptFullName<>'中原/深圳中原/职能中心/行政部'            
  and  PositionName like '%秘书%'  and FStatus=1 )        
          
          
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),FEmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7','FDAB0764-5B18-48AB-B1CA-50D30CAEF5DC' from          
        VW_PersonnelInfo   where  FEmpCode='45663'        
                 
          
END 