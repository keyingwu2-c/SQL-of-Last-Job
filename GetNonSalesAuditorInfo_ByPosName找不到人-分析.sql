use pms;
exec GetNonSalesAuditorInfo_ByPosName '05680B30-87AB-42FA-AE35-3E1BB5FB5703','资产总账员'

select * from HR_PosStaffInfo where FPosID='0f0d3f0f-a370-4af6-b06e-7ecca8528af4'
select * from HR_PositionSys where FPosID='0f0d3f0f-a370-4af6-b06e-7ecca8528af4'
select top 5 * from VW_GroupPositionInfo
select * from VW_GroupPositionInfo where GroupID='182B31A1-C5DD-4851-9272-951310D01465'
select top 5 * from VW_EmpJobsInfo_All
select * from VW_EmpJobsInfo_All where FPosID='0f0d3f0f-a370-4af6-b06e-7ecca8528af4'
SELECT * FROM  dbo.A_RightGroup where Name like '%资产总账员%'
--GroupID=182B31A1-C5DD-4851-9272-951310D01465
select top 1 b.* from  dbo.VW_GroupPositionInfo as a inner join VW_EmpJobsInfo_All as b 
			on a.FPosID=b.FPosID
			where 1=1  and GroupID=(SELECT ID FROM  dbo.A_RightGroup where Name like '%资产总账员%')