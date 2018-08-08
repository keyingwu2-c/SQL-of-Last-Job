begin transaction CanBack
  insert into WF_ApplyType values ('hello','hello','hello','hello');
   
rollback transaction CanBack2
commit transaction CanBack
begin transaction CanBack2
  update WF_ApplyType set ApplyTypeID='110'

rollback transaction CanBack
select * from WF_ApplyType