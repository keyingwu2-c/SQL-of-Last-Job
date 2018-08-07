use pmstest;
--select * from WF_ApplyInstance where Folio like '%ittest3%';--旧的WP记录中，两条在表里有的
--select * from WF_ApplyInstance where Folio like '%201832102814%';--新加的，WP有，表里也有，待办事项没有
select * from WF_ApplyInstance where Folio like '%201827153352393%';--待办事项有的，表里没有，其中某些WP有

--select * from WF_ApplyInstance where ApplyBy='user';
--update WF_ApplyInstance set ApplyBy='ittest3',Folio='Add folio in database directly' where ApplyID='27860063-FDB0-488A-969A-461D2035F9A1';