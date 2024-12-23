--mysql
select 
    id 
  , count(*) as num

from (
        select 
            accepter_id  as id 
        
        from 
            requestaccepted
        
        union all
    
        select 
            requester_id as id 
        
        from 
            requestaccepted
     ) as t 

group by 
    id 

order by 
    count(*) desc 

limit 1 ;



--mysql
with cte  as (
  select 
      requester_id as id 
    , count(*) as cnt

  from 
      requestaccepted 
  
  group by 
      requester_id ) 



, cte2 as (
  select 
      accepter_id  as id 
    , count(*) as cnt

  from 
      requestaccepted 
  
  group by 
      accepter_id )



select 
    id 
  , num 
  
from (
        select 
            id 
          , sum( cnt ) as num 
        
        from (
                select 
                    id 
                  , cnt   
                
                from 
                    cte  
                
                union all 
                
                select 
                    id 
                  , cnt   
                
                from 
                    cte2 
    ) as t
    group by id
) as t2 

order by 
    num desc 

limit 1 ;



---ms sql server
select 
    top 1 id 
  , count(*) as num

from (
        select 
            accepter_id  as id 
        
        from 
            requestaccepted
        
        union all
        
        select 
            requester_id as id 
        
        from 
            requestaccepted
) as t 

group by 
    id 

order by 
    count(*) desc;



---ms sql server
with cte  as (
  select 
      requester_id as id 
    , count(*) as cnt

  from 
      requestaccepted 
  
  group by 
      requester_id ) 


, cte2 as (
            select 
                accepter_id  as id 
              , count(*) as cnt
         
            from 
                requestaccepted 
            
            group by 
                accepter_id )



select 
    top 1 id 
  , num 

from (
        select 
            id 
          , sum( cnt ) as num 
        
        from (
                select 
                    id 
                  , cnt   
                
                from cte  
                
                union all 
                
                select 
                    id 
                  , cnt   
                
                from 
                    cte2 
    ) as t
    group by id
) as t2 

order by 
    num desc ;
