--mysql  &  ms sql server
select 
    distinct num 
      as consecutivenums 
  
from (
        select 
            num 
          , sum(tf) 
              over(
                order by 
                    id asc 
                  ) 
              as  ind 
        
        from (
                select 
                    num 
                  , id 
                  , case 
                        when lag(num) 
                             over(
                               order by 
                                   id asc
                                 ) = num 
                        then 0 
                        
                        else 1 
                    end 
                      as tf
                
                from 
                    logs
             ) as t
     ) as t2 

group by 
    num 
  , ind

having 
    count(*) >= 3 ;
  
  
  
  --mysql  &  ms sql server
select 
    distinct l.num 
      as consecutivenums 
      
from 
    logs l 

    join logs l2 
       on l.id = l2.id + /*-*/ 1 
      and l.num = l2.num 

    join logs l3 
       on l.id = l3.id + /*-*/ 2 
      and l.num = l3.num ;  
  
  
  
  --mysql  &  ms sql server
select 
    distinct l.num 
      as consecutivenums 

from 
    logs l 

    join logs l2 
       on l.id = l2.id - /*+*/ 1 
      and l.num = l2.num 
    
    join logs l3 
       on l2.id = l3.id - /*+*/ 1 
      and l2.num = l3.num ;  
  
  

--mysql  &  ms sql server
with numbers(n2 , n1 , n) as (
  select 
      lead( num , 2)  
        over(
          order by 
              id asc
            ) /*lag*/
    , lead( num ) 
        over(
          order by 
              id asc
            ) /*lag*/
    , num 
  
  from 
      logs
)


select 
    distinct n consecutivenums 

from 
    numbers 

where 
      1=1
  and n=n1 
  and n=n2



--mysql  &  ms sql server
select 
    distinct num 
      as consecutivenums 

from 
    logs l

where 
      1=1
  and ( id + 1 , num ) in 
                          (
                            select 
                                id 
                              , num 
                            from 
                                logs 
                          )       
  and exists (
              select 
                  * 
              from 
                  logs 
              where 
                    1=1
                and num = l.num 
                and id = l.id - 1  )  
