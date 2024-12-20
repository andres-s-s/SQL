/*
  Instructions:

  Write a solution to display the records with three or more rows with consecutive id's, 
  and the number of people is greater than or equal to 100 for each.

  Return the result table ordered by visit_date in ascending order.

  +---------------+---------+
  | Column Name   | Type    |
  +---------------+---------+
  | id            | int     |
  | visit_date    | date    |
  | people        | int     |
  +---------------+---------+
*/
--  count(*) over(partition by ind ) >= 3 as cnt --mysql alternative
--where cnt = 1  --mysql alternative


-- mysql  &  ms sql server
with greater_than_99 as (                               
  select 
      s.id
    , s.visit_date
    , s.people
  from 
      stadium s
  where 
        s.people >= 100
                        )
-- close cte 



, consecutive_ids_t_or_f as (
  select 
      g.id
    , g.visit_date
    , g.people
    , case 
      
        when lag(g.id) 
               over(
                 order by 
                     g.id asc
                   ) = g.id - 1 
        then 0 
        
        else 1 
      
      end as tf 
  
  from 
      greater_than_99 g
                     )
-- close cte 



, consecutive_ids as (    
  select 
      c.id 
    , c.visit_date 
    , c.people 
    , sum(c.tf) 
        over(
          order by 
              c.id asc
            ) 
        as ind

  from 
      consecutive_ids_t_or_f c
                     )
-- close cte



, amount_of_consecutive_ids as (
  select 
      c.id 
    , c.visit_date 
    , c.people 
    , count(*) 
        over(
          partition by 
              c.ind 
            ) 
        as cnt
   -- count(*) over(partition by ind ) >= 3 as cnt --mysql alternative


  from 
      consecutive_ids c
     )



select 
    a.id 
  , a.visit_date 
  , a.people 

from
    amount_of_consecutive_ids a

where 
      1=1
  and a.cnt >= 3 
   -- cnt = 1  --mysql alternative



order by 
    a.visit_date asc;




--mysql  &  ms sql server
with greater_than_99 as (                               
  select 
      s.id
    , s.visit_date
    , s.people
  from 
      stadium s
  where 
        s.people >= 100
                        )
-- close cte 



, consecutive_ids_t_or_f as (
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
    
  from 
      greater_than_99  )
-- close cte



select 
    c.id 
  , c.visit_date 
  , c.people 

from 
    consecutive_ids_t_or_f c 

where 
      1=1
  and c.tf is not null 
  

order by 
    id asc;
