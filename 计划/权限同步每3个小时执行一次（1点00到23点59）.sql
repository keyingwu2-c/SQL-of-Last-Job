-- =============================================        
-- Author:  <Author,,Name>        
-- Create date: <Create Date,,>        
-- Description: ������Ա�����飬��������Ȩ��        
-- �������ѯ�������������������ϲ��ܲ鿴������ɹ���Ϣ(������������)        
-- =============================================        
CREATE PROCEDURE [dbo].[SynRight_AutoFromAttend]         
AS        
BEGIN        
 -- SET NOCOUNT ON added to prevent extra result sets from        
 -- interfering with SELECT statements.        
 SET NOCOUNT ON;        
        
    -- Insert statements for procedure here        
    --ɾ���������ѯ��ְλ        
    Delete from  A_RightGroup_Position where GroupID='DF3B9CE1-03CF-4647-9E93-2A0CAC5318C9'        
            
    insert into A_RightGroup_Position (GroupID,PositionID)          
  select  distinct 'DF3B9CE1-03CF-4647-9E93-2A0CAC5318C9',PositionID from VW_PersonnelInfo where (        
  DeptFullName like  '��ԭ/������ԭ/סլ����%' or DeptFullName like  '��ԭ/������ԭ/סլ������%'         
  or DeptFullName like  '��ԭ/������ԭ/סլ����%' or DeptFullName like  '��ԭ/������ԭ/סլ������%'           
  or  DeptFullName like  '��ԭ/������ԭ/�����г������̲�%')        
  and FStatus=1 and FRank>4 and PositionName not like '%���о���%'          
         
         
         
    --ְ��������Ȩ�����ڹ����걨Ȩ�ޣ�        
    Delete from  A_RightGroup_Position where GroupID='FAF8B57C-159D-4A16-9416-FB51277801A9'        
    and PositionID not  in (select distinct  a.FPosID from HR_PositionSys  as a  inner join  HR_Department as b         
     on a.FDeptID=b.Department_ID where b.DeptFullName like '%��ԭ/������ԭ/ְ������%'        
     and b.FDeleted=1 and a.FDelete=0        
                     )        
                
    insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct 'FAF8B57C-159D-4A16-9416-FB51277801A9', a.FPosID from HR_PositionSys  as a  inner join  HR_Department as b         
     on a.FDeptID=b.Department_ID where b.DeptFullName like '%��ԭ/������ԭ/ְ������%'        
     and b.FDeleted=1 and a.FDelete=0 and         
     a.FPosID not in (select  PositionID from A_RightGroup_Position where GroupID='FAF8B57C-159D-4A16-9416-FB51277801A9' )        
             
            
 --��Ա��(����סլ�͹�������Ա����������) �������ѿ�ͨ���飬����Ȩ��ز˵�Ȩ�ޣ�������Ҫ��ͨ���Ų鿴��Χ����ӿ���ϵͳͬ����         
 --select * from  A_RightGroup where Name ='��Ա��'         
 Delete From A_RightGroup_Position where PositionID in         
  (select distinct PositionID from VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%������Ա%'         
  union        
  select distinct PositionID from VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%������Ա%'           
  )        
          
 Delete From A_EmployeeRight_Range Where EmpID in         
    (select distinct  FEmpID  from VW_PersonnelInfo   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%������Ա%'        
  union        
  select distinct  FEmpID  from VW_PersonnelInfo   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%������Ա%'  )        
          
 Delete From AS_FAAssetManager   Where FAAssetManagerID  in         
    (select distinct  b.FUserID  from VW_PersonnelInfo as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%������Ա%'        
  union         
  select distinct  b.FUserID  from VW_PersonnelInfo as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'      
  and PositionName like '%������Ա%'  )        
        
          
 Delete From A_RightGroup_Position where PositionID in         
  (select distinct FPosID from VW_EmpJobsInfo_All   where DeptFullName like         
   (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%��������%' union        
  select distinct FPosID from VW_EmpJobsInfo_All   where DeptFullName like         
   (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%��������%'  )        
          
 Delete From A_EmployeeRight_Range Where EmpID in         
    (select distinct  FEmpID  from VW_EmpJobsInfo_All   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%��������%' union         
  select distinct  FEmpID  from VW_EmpJobsInfo_All   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%��������%' )        
          
 Delete From AS_FAAssetManager   Where FAAssetManagerID  in         
    (select distinct  b.FUserID  from VW_EmpJobsInfo_All as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%��������%' union        
  select distinct  b.FUserID  from VW_EmpJobsInfo_All as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%��������%' )        
        
         
          
 Delete From A_RightGroup_Position where PositionID in         
  (select distinct PositionID from VW_PersonnelInfo   where DeptFullName like        
  (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'        
  and DeptFullName<>'��ԭ/������ԭ/ְ������/������'           
  and PositionName like '%����%'  )        
          
 Delete From A_EmployeeRight_Range Where EmpID in         
    (select distinct  FEmpID  from VW_PersonnelInfo   where DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'          
     and DeptFullName<>'��ԭ/������ԭ/ְ������/������'         
  and PositionName like '%����%')        
          
 Delete From AS_FAAssetManager   Where FAAssetManagerID  in         
    (select distinct  b.FUserID  from VW_PersonnelInfo as a inner join A_User as b on a.FAccount=b.FAccount  where a.DeptFullName like         
    (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'        
     and a.DeptFullName<>'��ԭ/������ԭ/ְ������/������'         
  and PositionName like '%����%' and FEmpCode<>'88905' and FEmpCode<>'21277')        
          
 insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',PositionID from  VW_PersonnelInfo           
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
   and PositionName like '%������Ա%'  and FStatus=1 union        
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',PositionID from  VW_PersonnelInfo           
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
   and PositionName like '%������Ա%'  and FStatus=1        
           
           
         
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%������Ա%'  and FStatus=1 union         
  select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%������Ա%' )        
          
 insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
  select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
     inner join A_User as c on b.DomainAccount=c.FAccount        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and PositionName like '%������Ա%'  and FStatus=1 union        
  select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and PositionName like '%������Ա%' )        
          
 --insert into A_RightGroup_Position (GroupID,PositionID)          
 -- select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',PositionID from  VW_PersonnelInfo           
 --  where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
 --  and PositionName like '%��������%'  and FStatus=1        
         
 --insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
 -- select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
 --    inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
 -- where a.Code in         
 -- (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
 -- (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
 -- and PositionName like '%��������%'  and FStatus=1 )        
         
 --insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
 -- select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
 --    inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
 --    inner join A_User as c on b.DomainAccount=c.FAccount        
 -- where a.Code in         
 -- (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
 -- (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
 -- and PositionName like '%��������%'  and FStatus=1 )        
           
        
 insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
   and FPosName like '%��������%'  and FStatus=1 union        
  select distinct '2AA0ACF3-8C05-4681-803A-688D6B2C646B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
   and FPosName like '%��������%'  and FStatus=1         
           
 insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct 'B50C0806-9F6D-4685-81FF-6EB6368A048B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
   and FPosName like '%��������%'  and FStatus=1 union        
  select distinct 'B50C0806-9F6D-4685-81FF-6EB6368A048B',FPosID from  VW_EmpJobsInfo_All             
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
   and FPosName like '%��������%'  and FStatus=1         
           
         
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
  where a.Code in         
  (select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%��������%'  and FStatus=1 union        
  select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%��������%'  and FStatus=1        
  )           
 insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
  select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
     inner join A_User as c on b.DomainAccount=c.FAccount        
  where a.Code in         
  (select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='928CBDA8-490B-4F2F-8B2C-DD27C75AD8FE')+'%'        
  and FPosName like '%��������%'  and FStatus=1 union        
  select distinct  fempcode from  VW_EmpJobsInfo_All   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='A13F2F60-EB13-49E8-90FC-2EF86F2F926C')+'%'        
  and FPosName like '%��������%'  and FStatus=1 )        
          
          
         
  insert into A_RightGroup_Position (GroupID,PositionID)          
  select distinct 'F8FB9DA9-80D0-4DCD-89F2-4C75E118B803',PositionID from  VW_PersonnelInfo           
   --where DeptFullName like (select DeptFullName from HR_Department where Department_ID='56B521E9-E73A-41E6-A510-8D9EE72BB4EB')+'%'        
   where DeptFullName like (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'         
   and DeptFullName<>'��ԭ/������ԭ/ְ������/������'             
   and  PositionName like '%����%'  and FStatus=1        
           
            
           
         
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),b.EmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7', a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'          
  and DeptFullName<>'��ԭ/������ԭ/ְ������/������'           
  and  PositionName like '%����%'  and FStatus=1 )        
          
 insert into AS_FAAssetManager(FAAssetManagerID,FDeptID)          
  select   c.FUserID,a.Range from  [DBATTEND].[Wireless_KQ].[dbo].[Right_Range] as a         
     inner join [DBATTEND].[Wireless_KQ].[dbo].[Personnel_Info] as b on a.Code=b.Job_No        
     inner join A_User as c on b.DomainAccount=c.FAccount        
  where a.Code in         
  (select distinct  fempcode from  VW_PersonnelInfo   where DeptFullName like         
  (select DeptFullName from HR_Department where Department_ID='61A27FE2-238C-4F67-AEAF-CE8B5B77A349')+'%'         
  and DeptFullName<>'��ԭ/������ԭ/ְ������/������'            
  and  PositionName like '%����%'  and FStatus=1 )        
          
          
 insert into A_EmployeeRight_Range (ID,EmpID,MenuID,Range)          
  select NEWID(),FEmpID,'BFC8CD52-3C04-4758-BBC5-46C42EBEC9C7','FDAB0764-5B18-48AB-B1CA-50D30CAEF5DC' from          
        VW_PersonnelInfo   where  FEmpCode='45663'        
                 
          
END 