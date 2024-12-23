--mysql  &  ms sql server
select  
    e.name 

from 
    employee e 
    
    join employee e2
       on e.id = e2.managerid 

group by 
    e.name 
  , e.id

having 
    count(*) >= 5;



--mysql  &  ms sql server
select 
    name 

from 
    employee 

where 
      1=1
  and id in (
              select 
                  managerid 
              
              from 
                  employee 
              
              group by 
                  managerid 
             
              having 
                  count(*) >= 5  
            );
