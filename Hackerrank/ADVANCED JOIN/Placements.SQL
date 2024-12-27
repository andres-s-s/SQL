/*
You are given three tables: Students, Friends and Packages. 

Students contains two columns: ID and Name. 

Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 

Packages contains two columns: ID and Salary (offered salary in $ thousands per month)..

Write a query to output the names of those students whose best friends got offered a 
higher salary than them. Names must be ordered by the salary amount offered to the best friends. 
It is guaranteed that no two students got same salary offer.

  */

-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


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




-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


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
