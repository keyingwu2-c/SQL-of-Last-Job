﻿select * from HR_Employee as e inner join HR_Department as d
on e.FDeptID=d.Department_ID where e.FEmpName='罗雪梅'   --FDeptID=D31EFA15-73A5-4856-8690-D3FAE873A1E3
select * from HR_Employee as e inner join HR_Department as d
on e.FDeptID=d.Department_ID where e.FEmpName='吴可莹'



select * from HR_Employee as e inner join HR_PosStaffInfo p
on e.FEmpID=p.FEmpID 
where e.FAccount='heml' and e.FEmpName='贺美玲'
--FPosID=C58E9ABB-F517-48D8-A57B-EFD5788906B2
--lxm 罗雪梅 FPosID=3a3f3ec7-5b5d-4a56-8626-badc65571bef 
--FITpye="0" and FUserDeptID=''D31EFA15-73A5-4856-8690-D3FAE873A1E3''   FUserDeptID 

exec GetAssetlistForAlterByCondition 'lxm','3a3f3ec7-5b5d-4a56-8626-badc65571bef','where 1=1 and FITType=''0'' and FUserDeptID<>''C59B8C06-31A0-46DB-8F0E-8FE87D999839'' ','*','FAssetNumber',50,1,0
--检查这些资产的部门是不是都撤销了：

exec GetAssetlistForAlterByCondition 'lxm','3a3f3ec7-5b5d-4a56-8626-badc65571bef','where 1=1 and FITType=''0''','*','FUserDeptID',50,1,0

select * from HR_Department where Department_ID='C59B8C06-31A0-46DB-8F0E-8FE87D999839'--撤销了
select * from HR_Department where Department_ID='CCED3F6D-C3DA-4D85-A495-D98A357CC199'


--贺美玲‎ 
select * from HR_Employee where FEmpName='贺美玲'
exec GetAssetlistForAlterByCondition 'heml','C58E9ABB-F517-48D8-A57B-EFD5788906B2','where 1=1 and FITType=''0'' and FUserDeptID=''39DB9765-6011-4324-ABA4-DA9BA4786E4D''','*','FAssetNumber',50,1,0
exec GetAssetlistForAlterByCondition 'heml','C58E9ABB-F517-48D8-A57B-EFD5788906B2','where 1=1 and FITType=''0'' and FAssetNumber=''F201506000511''','*','FAssetNumber',50,1,0

