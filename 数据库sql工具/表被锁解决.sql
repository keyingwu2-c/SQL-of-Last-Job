--在mster下执行
--查看被锁表 
select   request_session_id   spid,OBJECT_NAME(resource_associated_entity_id) tableName   
from   sys.dm_tran_locks where resource_type='OBJECT'
 
--spid   锁表进程 
--tableName   被锁表名
 
--解锁

declare @spid  int 
Set @spid -- = 71--锁表进程
declare @sql varchar(1000)
set @sql='kill '+cast(@spid  as varchar)
exec(@sql)