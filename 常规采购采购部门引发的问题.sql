insert into WF_ApplyInstance(ApplyID,BizDataID,CurState,ApplyBy,
ApplicantName,ApplyDeptID,IsWFSubmit,SourceType,IsFinished) values
('06D98D98-BAF6-4DEE-954A-E164EC58B298','CC27EBC4-B339-4178-B339-4178-B3E0-08CCE0',
'审批中','szliuhong','刘虹',
'46CA1D39-7991-47DB-8DFA-407403E78873','1',
'SZCentaline','0')

select * from HR_Department where Department_ID='46CA1D39-7991-47DB-8DFA-407403E78873'

use pmstest
select * from A_User where FName='刘虹'
select * from A_User where FName='袁喜燕'
select * from HR_Employee where FEmpName='刘虹'
select * from HR_Department where Department_ID='46CA1D39-7991-47DB-8DFA-407403E78873'

select * from HR_Department where DeptFullName like '中原/深圳中原/渠道营销部%'
--insert into HR_DepartmentWL 
select Department_ID,Code,DeptName,DeptFullName,ParentID,
ParentCode,FDeleted,CreateDate,CloseDate,null from HR_Department
where DeptFullName like '中原/深圳中原/渠道营销部/%'

--update HR_DepartmentWL set DeptBelongto='2' where DeptFullName like '中原/深圳中原/渠道营销部/%'

exec GetApplyDept_Pointing 'C6E87CCE-5AEB-43F8-8957-BA8BFF37AFA6'
--改了这个存储过程
select Department_ID,Code,DeptName,DeptFullName,ParentCode,ParentID,FDeleted,CreateDate,DeptBelongto,DeptBelongtoName,ParentName,ParentFullName from VW_DepartmentListSpc 
where DeptFullName like '中原/深圳中原/%工商铺部%'

--GetDeptBelongTo过程有用
select * from HR_DepartmentWL where DeptFullName like '中原/深圳中原/渠道营销部%'
--设置渠道营销部所有部门的HR_DepartmentWL.DeptBelongto为2


--insert into HR_DepartmentWL 
--(Department_ID,Code,DeptName,DeptFullName,ParentID,
--ParentCode,FDeleted,CreateDate,CloseDate,DeptBelongto)
--values
--(''),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--(),
--()