--�������г�С��ά��������Щ����Ȩ���µ�
use pms;
select * from WF_ApplyInstance where Folio like '%MT180605006%'
select * from WF_ApplyType where ApplyTypeID='1379B5ED-4F0E-4534-9460-0B7523F7CC68'
select * from HR_Employee as e inner join HR_Department as d 
on e.FDeptID=d.Department_ID inner join HR_PosStaffInfo as p
on e.FEmpID=p.FEmpID where e.FEmpName='����'

select * from HR_Employee where FEmpCode='30520'
select * from HR_PosStaffInfo where FEmpCode='30520'
EXEC GetAuditInfo_ByPosName '�����г����鲿����'
EXEC GetThreeRepairApplyRequestEntryByDeptID 'MT180605006','3320D18D-E21A-49B9-8FA5-FE89B6189B61','������'

select distinct FEmpCode,FEmpName from (  
     select  b.* from  dbo.VW_GroupPositionInfo as a   
              inner join VW_EmpJobsInfo_All as b on a.FPosID=b.FPosID  
        where 1=1  and GroupID   
       in(SELECT ID FROM  dbo.A_RightGroup where (Name='����֧Ԯ��������' or Name='��Ա��'or Name='����רԱ'))  
        and a.FPosName like '%������Ա%' or a.FPosName like '%��������%' or a.FPosName like '%����רԱ%'
        ) as  a
		where FDeptID='932EA572-44F5-4117-AEF2-8F31C0F9C392'