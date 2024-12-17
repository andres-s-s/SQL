--mysql  &  ms sql server
select 
    e.name 

from 
    employee e

where 
      1=1
  and e.salary > 2000 
  and e.months < 10 
  
order by 
    e.employee_id asc;
