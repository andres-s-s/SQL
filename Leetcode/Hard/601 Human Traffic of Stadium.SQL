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






-- +--------------------------------------------------------------------+
-- |  solution 1: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


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
-- records with people larger or equeal to 100



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
      /*
        If the id of the past record is the same as the currect id - 1 they are consecutive
        and in the new tf column there will be a 0
        If they are not consecutive, in the column there will be a 1

        This means every time an id is not consecutive to the previos one there will be a 1
        In the next cte this would be useful
        */
  
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
      /*
        Example of what is happening
        tf    sum(c.tf)
        0     0
        0     0
        1     1
        0     1
        0     1
        0     1
        1     2
        1     3
        1     4

        Remember every time there is a 1 it means that the previous id and the currect one 
        are not consecutive

        So each set of id's that are consecutive will share the same number in the
        sum(c.tf) column
      */

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








-- +--------------------------------------------------------------------+
-- |  solution 2: mysql  &  ms sql server   
-- +--------------------------------------------------------------------+


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
-- records with people larger or equeal to 100



, consecutive_ids_t_or_f as (
  select 
      g.id 
    , g.visit_date 
    , g.people 
    , case 
        when 
              lead(g.id)   over(order by g.id ) - 1 = g.id 
          and lead(g.id,2) over(order by g.id ) - 2 = g.id
          -- Are the current and 2 following ids consecutive?
           
           or lead(g.id)   over(order by g.id ) - 1 = g.id 
          and lag(g.id)    over(order by g.id ) + 1 = g.id
          -- Are the current and the following and the previous ids consecutive?
           
           or lag(g.id)    over(order by g.id ) + 1 = g.id 
          and lag(g.id,2)  over(order by g.id ) + 2 = g.id
          -- Are the current and the 2 previous ids consecutive?
        
        then 1 
        else null 

      end as tf 
    
  from 
      greater_than_99 g       )
/* 
  If that id does not have 2 previous consecutive ids 
  or 2 following consecutive ids 
  or 1 following and 1 following consecutive ids
  it gets a null value in the column created by the case statement 
 */



select 
    c.id 
  , c.visit_date 
  , c.people 

from 
    consecutive_ids_t_or_f c 

where 
      1=1
  and c.tf is not null -- The rows that don't meet the requirements get a null value
  

order by 
    id asc;
