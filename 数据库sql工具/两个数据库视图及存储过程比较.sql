/*--����ʾ�� 
exec p_compdb 'DBNAME1','DBNAME2' 
exec p_compdb 'DBNAME2','DBNAME3' 
--*/
  
alter proc p_compdb2 
@db1 sysname, --��һ���� 
@db2 sysname --�ڶ����� 
as
exec(' 
select ����=case isnull(a.xtype,b.xtype) when ''V'' then ''��ͼ'' else ''�洢����'' end 
,ƥ�����=case 
when a.name is null then ''�� [PMS] ����'' 
when b.name is null then ''�� [PMS] ����'' 
else ''�ṹ��ͬ'' end 
,��������=isnull(a.name,b.name),a.text as atext, b.text as btext
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
 
--order by ����,ƥ�����,��������')


exec p_compdb2 'PMSTest','PMS'