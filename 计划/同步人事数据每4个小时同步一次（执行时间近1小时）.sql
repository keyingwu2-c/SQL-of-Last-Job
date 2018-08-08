-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: 人事数据同步  
-- =============================================  
CREATE PROCEDURE  [dbo].[SyncStaff]  
AS  
BEGIN  
 DECLARE @empcode nvarchar(50)  
 DECLARE @job_no nvarchar(50)  
 DECLARE @per_name nvarchar(50)  
 DECLARE @departments_id uniqueidentifier  
 DECLARE @departments_code nvarchar(200)  
 DECLARE @trank tinyint  
 DECLARE @tType tinyint  
 DECLARE @tstatus  tinyint  
 DECLARE @entry_date datetime  
 DECLARE @departure_date datetime  
 DECLARE @DoOffDate datetime  
 DECLARE @InDueDate datetime  
 DECLARE @word_zd bit  
 DECLARE @membership nvarchar(50)  
 --2012-04-16 Add  
 Declare @Email      Nvarchar(50)  
 Declare @DomainAccount nvarchar(20)  
    Declare @Sex nchar(10)  
 DECLARE @deptname  nvarchar(50)  
   
 DECLARE @DataID nvarchar(50)  
 DECLARE @ItemID nvarchar(50)  
 DECLARE @ForwardEmpID nvarchar(50)  
 DECLARE @ModDate datetime  
 DECLARE @Mobile nvarchar(50)  
 DECLARE @EmpID  nvarchar(50)  
 DECLARE @Type nvarchar(50)  
 DECLARE @StartDate datetime  
 DECLARE @EndDate datetime  
    
 DECLARE @parentCode  nvarchar(500)  
 DECLARE @parentID  nvarchar(50)  
 DECLARE @department_id uniqueidentifier  
 DECLARE @department_code  nvarchar(200)  
 DECLARE @department_name  nvarchar(50)  
 DECLARE @department_fname nvarchar(800)  
 DECLARE @department_ndate datetime  
 DECLARE @department_cdate datetime  
 DECLARE @DateBirth datetime  
 DECLARE @department_status  tinyint  
  
 DECLARE @jname nvarchar(50)  
 DECLARE @jobs_id uniqueidentifier  
 DECLARE @positionid uniqueidentifier  
 DECLARE @jobs_name nvarchar(50)  
 DECLARE @dempt_id uniqueidentifier  
 DECLARE @h_positions uniqueidentifier  
 DECLARE @EmID  uniqueidentifier  
 DECLARE @delete_flag bit  
 DECLARE @jobs_code nvarchar(200)  
 DECLARE @PositionName nvarchar(100)  
 DECLARE @leader_flag int  
  
 DECLARE @cname  nvarchar(50)  
 DECLARE @Staffd_id uniqueidentifier  
 DECLARE @cjob_no nvarchar(50),@IDCard nvarchar(50)   
 DECLARE @cjobs_id uniqueidentifier   
 DECLARE @cjobs_name  nvarchar(50)  
    DECLARE @IsPrimary bit  
    DECLARE @MaxCount int  
    DECLARE @branchNo  nvarchar(50)  
       
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;   
   
    --员工数据更新  
    Create Table #TempEmpDataKq(ID Int IDENTITY(1,1),EmpID NVarchar(50),job_no NVarchar(50),per_name NVarchar(50),  
  departments_id NVarchar(50),departments_code NVarchar(200),trank Tinyint,tstatus Tinyint,entry_date datetime,  
  departure_date datetime,word_zd bit,membership NVarchar(50),Email NVarchar(50),DomainAccount NVarchar(20),  
  DoOffDate datetime,tType tinyint,InDueDate datetime,IDCard NVarchar(50),Sex nchar(10),DateBirth datetime,  
  PositionName nvarchar(100),Mobile nvarchar(50),ShortNo nvarchar(50)  )  
  
    --放入临时表#TempIrregularEmp  
 Truncate Table #TempEmpDataKq  
 --创建临时表索引  
 CREATE INDEX idx_TempEmpDataKq  
  ON #TempEmpDataKq(job_no)  
    
    
 --Declare EmpData cursor FOR  
  
       
  
 INSERT INTO #TempEmpDataKq  (EmpID,job_no,per_name,departments_id,departments_code,trank,tstatus,entry_date,departure_date,word_zd,  
  membership,Email,DomainAccount,DoOffDate,tType,InDueDate,IDCard,Sex,DateBirth,PositionName,Mobile)    
  select [t0].EmpID,ltrim(rtrim([t0].empno)),[t0].empname,[t3].[DeptID],[t3].[Path],joblevel=case when  [t0].empno in ('24858','0216') then 5 else [t0].joblevel end ,  
          Status=(case when [t0].empstatus='在职' then 1   
   when [t0].empstatus='离职' then 2 end),[t0].InGroupDate,[t0].DimissionDate,[t0].FlagFiveDays,  
   Region=(CASE WHEN [t2].[FlagDeptKind] =0 THEN '非营业部' ELSE '营业部' END ),[t0].Email,[t0].DomainAccount,[e1].DoOffDate,  
   EMPTYPE=case when [t0].EMPTYPE='正式员工' then 1   
    when [t0].EMPTYPE='试用员工' then 2  
    when [t0].EMPTYPE='见习员工' then 3 end,[t0].InDueDate,[t0].IDCard,[t0].Sex,[t0].DateBirth,[t2].PositionName,[t0].Mobile  
        from [dbcchr].[szcchr].dbo.[employee] AS [t0]  
   left  join [dbcchr].[szcchr].dbo.[EmployeeAdjustApply] AS [e1] on [t0].[EmpID]=[e1].[EmpID] and [e1].DoOffDate is not null and [e1].flagstatus='有效' and [e1].flagdeleted=0 and [e1].AffairType='离职'   
   left  join [dbcchr].[szcchr].dbo.[EmployeeDimissionInfo] AS [e2] on [e1].[RowID]=[e2].[Dimissionapplyid]    
   INNER JOIN  [dbcchr].[szcchr].dbo.[EmployeePositionRole] AS [t1] ON [t0].[EmpID] = [t1].[EmpID] and [t1].FlagPrimary=1   
   INNER JOIN  [dbcchr].[szcchr].dbo.[Position] AS [t2] ON [t2].[PositionID] = [t1].[PositionID]  
   LEFT OUTER JOIN [dbcchr].[szcchr].dbo.[Department] AS [t3] ON [t3].[DeptID] = [t2].[DeptID]  
   where  [t0].empno is not null  and [t0].EMPTYPE is not null order by  [t0].empno   
          
 select @MaxCount =Count(*) From #TempEmpDataKq  
       
 --open EmpData  
   
    --fetch next from EmpData into  
    --  @EmpID,@job_no,@per_name,@departments_id,@departments_code,@trank,@tstatus,@entry_date,@departure_date,@word_zd,@membership,@Email,@DomainAccount,@DoOffDate,@tType,@InDueDate,@IDCard,@Sex,@DateBirth,@PositionName  
    --     while (@@fetch_status<>-1)  
    --     begin  
 while (@MaxCount>0)  
 begin  
  select @EmpID=EmpID,@job_no=ltrim(rtrim(job_no)),@per_name=per_name,@departments_id=departments_id,  
   @departments_code=departments_code,@trank=trank,@tstatus=tstatus,@entry_date=entry_date,@departure_date=departure_date,  
   @word_zd=word_zd,@membership=membership,@Email=Email,@DomainAccount=DomainAccount,@DoOffDate=DoOffDate,  
   @tType=tType,@InDueDate=InDueDate,@IDCard=IDCard,@Sex=Sex,@DateBirth=DateBirth,@PositionName=PositionName,@Mobile=Mobile   
  from #TempEmpDataKq where id=@MaxCount  
   --select @empcode=null  
      
   if NOT(Exists(select FEmpCode from HR_Employee where FEmpCode=ltrim(rtrim(@job_no))))  
    begin   
     insert into  HR_Employee   
      ([FEmpCode],[FEmpName],[FCode],[FDeptID],[FRank],[FStatus]  
      ,[FEntryDate],[FDepartDate],[FWorkDays],[FMembership],[FEmail],[FAccount],[FSex],[FEmpID]) values  
      (ltrim(rtrim(@job_no)),@per_name,@departments_code,@departments_id,  
     @trank,@tstatus,@entry_date,@departure_date,@word_zd,@membership,@Email,@DomainAccount,@Sex,@EmpID)  
       
     --插入HR公共数据库表   
     if not exists(select * from  HRShareDB.dbo.HR_Employee where FEmpCode=ltrim(rtrim(@job_no)))   
     begin  
      insert into HRShareDB.dbo.HR_Employee  ([FEmpCode],[FEmpName]  
       ,[FCode],[FDeptID],[FRank],[FStatus],[FEntryDate],[FDepartDate],[FWorkDays]  
       ,[FMembership],[FEmail],[FAccount],[FSex],[FEmpID],[FPhone]) values  
      (ltrim(rtrim(@job_no)),@per_name,@departments_code,@departments_id,  
             @trank,@tstatus,@entry_date,@departure_date,@word_zd,@membership,@Email,@DomainAccount,@Sex,@EmpID,@Mobile            
      )  
     end  
       
      --select * from HR_Employee where FEmpCode=ltrim(rtrim(@job_no))  
     --if @DomainAccount is not null and @DomainAccount<>''  
     --begin  
     -- INSERT INTO  [A_User]  
     -- ([FAccount],[FName],[FDataVokeType],[FEmpID],[FForbidden],[FRight],[FSafeMode]) values  
     --  (@DomainAccount,@per_name,0,@EmpID,0,1,0)  
     --      end     
              
                
    end  
            else  
    begin  
     update HR_Employee set FEmpID=@EmpID,[FEmpName]=@per_name,[FDeptID]=@departments_id,[FCode]=@departments_code,  
      [FRank]=@trank,[FStatus]=@tstatus,[FEntryDate]=@entry_date,[FDepartDate]=@departure_date,[FWorkDays]=@word_zd,[FMembership]=@membership,          
      FSex=@Sex,FEmail=@Email,FAccount=@DomainAccount      
     where FEmpCode=ltrim(rtrim(@job_no))  
       
     --修改HR公共数据库表   
     update HRShareDB.dbo.HR_Employee set FEmpID=@EmpID,[FEmpName]=@per_name,[FDeptID]=@departments_id,[FCode]=@departments_code,  
      [FRank]=@trank,[FStatus]=@tstatus,[FEntryDate]=@entry_date,[FDepartDate]=@departure_date,[FWorkDays]=@word_zd,[FMembership]=@membership,          
      FSex=@Sex,FEmail=@Email,FAccount=@DomainAccount,FPhone=@Mobile   
     where FEmpCode=ltrim(rtrim(@job_no))  
       
     if @DomainAccount is not null and @DomainAccount<>''  
     begin  
      if @tstatus=1  
       update [A_User] set [FAccount]=@DomainAccount,[FName]=@per_name,FForbidden=0   where FEmpID=@EmpID  
      else if @tstatus=2  
       update [A_User] set [FAccount]=@DomainAccount,[FName]=@per_name,FForbidden=1   where FEmpID=@EmpID  
     end  
    end  
      
  set @MaxCount =@MaxCount-1  
 end  
   
 --update A_User set FForbidden=1    
 --  from HR_Employee as b   
 --where A_User.FEmpID=b.FEmpID and b.FStatus=2   
      
 Drop Index #TempEmpDataKq.idx_TempEmpDataKq  
 Drop Table #TempEmpDataKq  
     
     
    INSERT INTO  [A_User]  
  ([FAccount],[FName],[FDataVokeType],[FEmpID],[FForbidden],[FRight],[FSafeMode])     
 select FAccount,FEmpName,0,FEmpID,0,1,0 from HR_Employee WHERE fstatus=1  
  and fempid not in (select fempid from A_User ) and (FAccount<>''  and FAccount is not null)  
  
 --需过滤删除掉的人员  
 Delete From HR_Employee Where FEmpCode in   
  (select EmpNo from [dbcchr].[szcchr].dbo.[employee] where  flagdeleted = 1)  
    
  
 Create Table #TempDeptDataKq(ID Int IDENTITY(1,1),parentCode NVarchar(500),department_id NVarchar(50),department_code NVarchar(200),  
  department_name NVarchar(50),department_fname NVarchar(800),parentID NVarchar(50),department_ndate datetime,department_cdate datetime,  
  department_status tinyint,branchNo NVarchar(50))  
  
       
 Truncate Table #TempDeptDataKq  
 --创建临时表索引  
 CREATE INDEX idx_TempDeptDataKq  
  ON #TempDeptDataKq(department_id)  
    
  
 --部门数据更新  
 --Declare DeptData cursor FOR   
 Insert Into #TempDeptDataKq (parentCode,department_id,department_code,department_name,department_fname,parentID,department_ndate,  
 department_cdate,department_status,branchNo)   
  select parentCode=(select [path] from [dbcchr].[szcchr].dbo.[Department]  where deptID=a.parentID ),a.DeptID,a.Path,a.DeptName,a.Fullname,a.ParentID,a.DateOpen,a.DateClosed,  
   statusid=(case when a.status='营业' and a.FlagDeleted=0  then 1   
    when a.status='营业' and a.FlagDeleted=1  then 2   
   when a.status='撤销' then 2 end),branchNo from   [dbcchr].[szcchr].dbo.[Department]  as a  
     
   
 select @MaxCount =Count(*) From #TempDeptDataKq  
   
 while (@MaxCount>0)  
 begin    
  select @parentCode=parentCode,@department_id=department_id,@department_code=department_code,  
   @department_name=department_name,@department_fname=department_fname,@parentID=parentID,@department_ndate=department_ndate,  
   @department_cdate=department_cdate,@department_status=department_status,@branchNo=branchNo       
    from #TempDeptDataKq where ID=@MaxCount  
     
  if NOT(Exists(select  DeptName from HR_Department where Department_ID=@department_id))  
   begin  
    insert into HR_Department   
    ([Department_ID],[Code],[DeptName],[DeptFullName],[ParentID],[ParentCode],[FDeleted],[CreateDate],[CloseDate],[BranchNo])values  
    (@department_id,@department_code,@department_name,  
     @department_fname,@parentID,@parentCode,  
     @department_status,@department_ndate,@department_cdate,@branchNo)  
    --插入HR公共数据库表    
    insert into [HRShareDB].dbo.HR_Department  
     select * from HR_Department where  Department_ID=@department_id   
       
    --插入资产存放位置表  
    insert into  AS_FALocation  ([FID],[FNumber],[FShortNumber],[FName],[FFullName]  
     ,[FLevel],[FParentID],[FDetail],[FFromDepartment],[FDeleted])   values  
     (@department_id,@parentCode,@department_code,@department_name,@department_fname,  
     2,@parentID,null,1,@department_status)  
   end  
  else  
   begin  
    update HR_Department set [Code]=@department_code,[DeptName]=@department_name,  
     [DeptFullName]=@department_fname,[ParentID]=@parentID,[ParentCode]=@parentCode,[FDeleted]=@department_status,   
     [CreateDate]=@department_ndate,[CloseDate]=@department_cdate,[BranchNo]=@branchNo  
    where Department_ID=@department_id  
    --修改HR公共数据库表   
    update [HRShareDB].dbo.HR_Department  set [Code]=@department_code,[DeptName]=@department_name,  
     [DeptFullName]=@department_fname,[ParentID]=@parentID,[ParentCode]=@parentCode,[FDeleted]=@department_status,   
     [CreateDate]=@department_ndate,[CloseDate]=@department_cdate,[BranchNo]=@branchNo  
    where Department_ID=@department_id  
    ----插入资产存放位置表  
    update AS_FALocation set   [FNumber]=@parentCode,[FShortNumber]=@department_code,[FName]=@department_name,[FFullName]=@department_fname  
     ,[FParentID]=@parentID,[FDeleted]=@department_status  
    where FID=@department_id  
      
   end   
  set @MaxCount =@MaxCount-1      
    end  
      
      
    Drop Index #TempDeptDataKq.idx_TempDeptDataKq  
 Drop Table #TempDeptDataKq  
      
       
      
    Delete From HR_PositionSys  
 Delete From HRShareDB.dbo.HR_PositionSys  
   
 --职位数据更新  
 insert into HR_PositionSys ([FPosID],[FPosName],[FDeptID],[FParentID],[FDelete],[FPosCode],[FLeaderFlag])   
  select PositionID,PositionName,DeptID,ParentID,FlagDeleted,Path,FlagPrincipal from [dbcchr].[szcchr].dbo.[Position]   
   
 insert into HRShareDB.dbo.HR_PositionSys  select * from HR_PositionSys  
    
 --Declare JobData cursor FOR    
 -- select PositionID,PositionName,DeptID,ParentID,FlagDeleted,Path,FlagPrincipal from [dbcchr].[szcchr].dbo.[Position]   
    
 --open JobData  
   
 --   fetch next from JobData into  
 -- @jobs_id,@jobs_name,@dempt_id,@h_positions,@delete_flag,@jobs_code,@leader_flag  
 -- while (@@fetch_status<>-1)  
 --       begin  
 --  --select @jname=null  
 --  if NOT(Exists(select  FPosName from HR_PositionSys where FPosID=@jobs_id))  
 --   begin  
 --    insert into HR_PositionSys ([FPosID],[FPosName],[FDeptID],[FParentID],[FDelete],[FPosCode],[FLeaderFlag])values  
 --    (@jobs_id,@jobs_name,@dempt_id,@h_positions,@delete_flag,@jobs_code,@leader_flag)  
 --    --插入HR公共数据库表   
 --    insert into  HRShareDB.dbo.HR_PositionSys  
 --    select * from HR_PositionSys where  FPosID=@jobs_id  
 --   end   
 --  else  
 --   begin            
 --    update HR_PositionSys set FPosName=@jobs_name,FDeptID=@dempt_id,FParentID=@h_positions,  
 --     FDelete=@delete_flag,FPosCode=@jobs_code,FLeaderFlag=@leader_flag  
 --    --修改HR公共数据库表   
 --    update HRShareDB.dbo.HR_PositionSys  set FPosName=@jobs_name,FDeptID=@dempt_id,FParentID=@h_positions,  
 --     FDelete=@delete_flag,FPosCode=@jobs_code,FLeaderFlag=@leader_flag  
        
        
 --    where FPosID=@jobs_id  
 --   end  
  
 --  fetch next from JobData into  
 --   @jobs_id,@jobs_name,@dempt_id,@h_positions,@delete_flag,@jobs_code,@leader_flag  
 -- end    
 --   close JobData  
 --   deallocate JobData  
  
   
  
    --职位人员对照表更新  
 Delete from HR_PosStaffInfo where FEmpCode<>'00001'  
 Delete from HRShareDB.dbo.HR_PosStaffInfo  
      
 insert into HR_PosStaffInfo (FEmpID,FEmpCode,FPosID,FPosName,IsPrimary)  
  select   [t0].EmpID,[t0].EmpNo,[t1].[PositionID],[t2].PositionName,[t1].FlagPrimary from [dbcchr].[szcchr].dbo.[employee] AS [t0]  
   INNER JOIN  [dbcchr].[szcchr].dbo.[EmployeePositionRole] AS [t1] ON [t0].[EmpID] = [t1].[EmpID] --and [t1].FlagPrimary=1   
   INNER JOIN  [dbcchr].[szcchr].dbo.[Position] AS [t2] ON [t2].[PositionID] = [t1].[PositionID]  
   LEFT OUTER JOIN [dbcchr].[szcchr].dbo.[Department] AS [t3] ON [t3].[DeptID] = [t2].[DeptID]    
    
   
   
 insert into HRShareDB.dbo.HR_PosStaffInfo select * from HR_PosStaffInfo  
   
 --Declare EAPData cursor FOR     
 -- select   [t0].EmpID,[t0].EmpNo,[t1].[PositionID],[t2].PositionName  from [dbcchr].[szcchr].dbo.[employee] AS [t0]  
 --  INNER JOIN  [dbcchr].[szcchr].dbo.[EmployeePositionRole] AS [t1] ON [t0].[EmpID] = [t1].[EmpID] and [t1].FlagPrimary=1   
 --  INNER JOIN  [dbcchr].[szcchr].dbo.[Position] AS [t2] ON [t2].[PositionID] = [t1].[PositionID]  
 --  LEFT OUTER JOIN [dbcchr].[szcchr].dbo.[Department] AS [t3] ON [t3].[DeptID] = [t2].[DeptID]    
     
 --open EAPData  
     
 --fetch next from EAPData into  
 -- @Staffd_id,@cjob_no,@cjobs_id,@cjobs_name  
 -- while (@@fetch_status<>-1)  
 --       begin  
      
 --  if NOT(Exists(select  FPosName from HR_PosStaffInfo where FEmpCode=@cjob_no ))    
 --   begin   
 --    insert into HR_PosStaffInfo (FEmpID,FEmpCode,FPosID,FPosName,IsPrimary) values  
 --    (@Staffd_id,@cjob_no,@cjobs_id,@cjobs_name,1)  
 --   end  
 --  else  
 --   begin  
 --    update  HR_PosStaffInfo set FEmpCode=@cjob_no,FPosID=@cjobs_id,FPosName=@cjobs_name  
 --     where  FEmpCode=@cjob_no  --Staffd_id=@Staffd_id  
 --   end  
  
 --  fetch next from EAPData into  
 --   @Staffd_id,@cjob_no,@cjobs_id,@cjobs_name   
 -- end    
 --   close EAPData  
 --   deallocate EAPData  
    
   
END  
  
  