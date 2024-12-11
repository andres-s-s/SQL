--mysql  &  ms sql server
select 
    s.name 

from 
  students s

  join packages p 
     on s.id = p.id 

  join friends f 
     on f.id = s.id 

  join packages pf 
     on pf.id = f.friend_id 

where 
    p.salary < pf.salary 

order by 
    pf.salary;



--mysql  &  ms sql server
select 
    s.name 

from 
    students s 
  , packages p 
  , friends  f 
  , packages pf  

where 
      p.salary < pf.salary 
  and s.id = p.id 
  and f.id = s.id 
  and pf.id = f.friend_id 

order by 
    pf.salary;
