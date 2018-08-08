select 
 [name]
 ,create_date
 ,modify_date 
FROM 
 sys.all_objects 
where 
 type_desc = N'SQL_STORED_PROCEDURE' 
 and name = 'GetHouseAuditorInfo_NoRepeat'
 and modify_date >='2013-08-05 00:00:00'

 select name,modify_date from sys.all_objects where type='P' and name='GetHouseAuditorInfo_NoRepeat' 
 order by modify_date desc