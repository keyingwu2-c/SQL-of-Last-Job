USE [PMS]
GO
/****** Object:  StoredProcedure [dbo].[GetReport_MonthlyMT]    Script Date: 2018/3/22 15:25:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetReport_MonthlyMT]
	@account  nvarchar(50),
	@positionID nvarchar(50),
	@sqlWhere nvarchar(1000),
	@sqlWhere2 nvarchar(1000)
	as 
	
	Begin Tran
	
	Declare @Sql nvarchar(max)

	begin
	  --组织拼接查询语句
		set @sql=''+@sqlWhere2
	end

	print @Sql
    Exec(@Sql)
    
    If @@Error <> 0
       Begin
           RollBack Tran
           Return -1
       End
    Else
       Begin
           Commit Tran
       End    