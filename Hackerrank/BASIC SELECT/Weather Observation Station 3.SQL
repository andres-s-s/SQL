/* mysql  &  ms sql server */
select 
    distinct s.city 

from 
    station s 

where 
      1=1
  and s.id % 2 = 0;

/* mysql */
select 
    distinct s.city 

from 
    station s

where 
      1=1
  and mod(s.id , 2 ) = 0;
