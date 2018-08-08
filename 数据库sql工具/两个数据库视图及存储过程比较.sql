/*--调用示例 
exec p_compdb 'DBNAME1','DBNAME2' 
exec p_compdb 'DBNAME2','DBNAME3' 
--*/
  
alter proc p_compdb2 
@db1 sysname, --第一个库 
@db2 sysname --第二个库 
as
exec(' 
select 类型=case isnull(a.xtype,b.xtype) when ''V'' then ''视图'' else ''存储过程'' end 
,匹配情况=case 
when a.name is null then ''库 [PMS] 中无'' 
when b.name is null then ''库 [PMS] 中无'' 
else ''结构不同'' end 
,对象名称=isnull(a.name,b.name),a.text as atext, b.text as btext
from( 
select a.name,a.xtype,b.colid,b.text 
from [PMS]..sysobjects a,[PMS]..syscomments b 
where a.id=b.id and a.xtype in(''V'',''P'') and a.status>=0 
)a full join( 
select a.name,a.xtype,b.colid,b.text 
from [PMSTest]..sysobjects a,[PMSTest]..syscomments b 
where a.id=b.id and a.xtype in(''V'',''P'') and a.status>=0 
)b on a.name=b.name and a.xtype=b.xtype and a.colid=b.colid 
where a.name is null 
or b.name is null 
or isnull(a.text,'''') <>isnull(b.text,'''') 
 
--group by a.name,b.name,a.xtype,b.xtype 
 
--order by 类型,匹配情况,对象名称')


exec p_compdb2 'PMSTest','PMS'