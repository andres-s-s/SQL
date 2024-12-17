--mysql  &  ms sql server
select 
    s.name

from 
    students s 

where 
      1=1
  and s.marks >= 76 

order by 
    s.right(name , 3 )
  , s.id asc;
