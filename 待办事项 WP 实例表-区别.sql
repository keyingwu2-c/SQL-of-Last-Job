use pmstest;
--select * from WF_ApplyInstance where Folio like '%ittest3%';--�ɵ�WP��¼�У������ڱ����е�
--select * from WF_ApplyInstance where Folio like '%201832102814%';--�¼ӵģ�WP�У�����Ҳ�У���������û��
select * from WF_ApplyInstance where Folio like '%201827153352393%';--���������еģ�����û�У�����ĳЩWP��

--select * from WF_ApplyInstance where ApplyBy='user';
--update WF_ApplyInstance set ApplyBy='ittest3',Folio='Add folio in database directly' where ApplyID='27860063-FDB0-488A-969A-461D2035F9A1';