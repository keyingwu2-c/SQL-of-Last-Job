--查三级市场小额维修审批哪些人有权限下单
use pms;
select * from WF_ApplyInstance where Folio like '%MT180605006%'
select * from WF_ApplyType where ApplyTypeID='1379B5ED-4F0E-4534-9460-0B7523F7CC68'
select * from HR_Employee as e inner join HR_Department as d 
on e.FDeptID=d.Department_ID inner join HR_PosStaffInfo as p
on e.FEmpID=p.FEmpID where e.FEmpName='龙欢'

select * from HR_Employee where FEmpCode='30520'
select * from HR_PosStaffInfo where FEmpCode='30520'
EXEC GetAuditInfo_ByPosName '二级市场秘书部主任'
EXEC GetThreeRepairApplyRequestEntryByDeptID 'MT180605006','3320D18D-E21A-49B9-8FA5-FE89B6189B61','李淑丽'

select distinct FEmpCode,FEmpName from (  
     select  b.* from  dbo.VW_GroupPositionInfo as a   
              inner join VW_EmpJobsInfo_All as b on a.FPosID=b.FPosID  
        where 1=1  and GroupID   
       in(SELECT ID FROM  dbo.A_RightGroup where (Name='后勤支援部主任组' or Name='文员组'or Name='事务专员'))  
        and a.FPosName like '%行政文员%' or a.FPosName like '%行政主任%' or a.FPosName like '%事务专员%'
        ) as  a
		where FDeptID='932EA572-44F5-4117-AEF2-8F31C0F9C392'