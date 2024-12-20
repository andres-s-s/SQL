-- mysql  &  ms sql server
select 
    id 
  , visit_date 
  , people 

from (
        select 
            id 
          , visit_date 
          , people 
          , count(*) 
              over(
                partition by 
                    ind 
                  ) 
              as cnt 
            --  count(*) over(partition by ind ) >= 3 as cnt --mysql alternative
        from (    
                select 
                    id 
                  , visit_date 
                  , people 
                  , sum(tf) 
                      over(
                        order by 
                            id asc
                          ) 
                      as ind
                from (
                        select 
                            * 
                          , case 
                            
                              when lag(id) 
                                     over(
                                       order by 
                                           id asc
                                         ) = id - 1 
                              then 0 
                              
                              else 1 
                            
                            end as tf 
                        from (
                                select 
                                    * 
                                from 
                                    stadium 
                                where 
                                      people >= 100
                             ) as t 
                     ) as t2
             ) as t3  
     ) as t4

where 
      1=1
  and cnt >= 3 
--where cnt = 1  --mysql alternative

order by 
    visit_date asc;




--mysql  &  ms sql server
with cte as (
  select 
      id 
    , visit_date 
    , people 
    , case 
        when 
              lead(id)   over(order by id ) - 1 = id 
          and lead(id,2) over(order by id ) - 2 = id
           
           or lead(id)   over(order by id ) - 1 = id 
          and lag(id)    over(order by id ) + 1 = id
           
           or lag(id)    over(order by id ) + 1 = id 
          and lag(id,2)  over(order by id ) + 2 = id
        
        then 1 
        else null 
      end as tf 
    
  from (
        select 
            * 
        from 
            stadium 
        where 
            people >= 100 
       ) as t
            )
-- close cte



select 
    id 
  , visit_date 
  , people 

from 
    cte 

where 
      1=1
  and tf is not null 

order by 
    id asc;
