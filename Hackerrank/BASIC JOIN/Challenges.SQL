/* mysql  &  ms sql server */
with number_of_challenges_per_student as (
  select 
      h.hacker_id 
    , h.name 
    , count(*) as amount 
    , row_number() 
        over(
          partition by 
              count(*) 
            ) 
        as r

  from 
      hackers as h 
      
      join challenges as c 
         on h.hacker_id = c.hacker_id 

  group by  
      h.hacker_id 
    , h.name                             )
/*Close cte*/

          
select 
    n.hacker_id 
  , n.name 
  , n.amount 

from 
    number_of_challenges_per_student n 

where 
      1=1
  and n.amount = (  
                      select 
                          max(amount) 
                      from 
                          number_of_challenges_per_student 
                 ) 
   or n.amount not in(
                      select 
                          amount 
                      from 
                          number_of_challenges_per_student 
                      where 
                            r = 2
                     )

order by 
    n.amount desc 
  , n.hacker_id;




/* mysql  &  ms sql server */
select 
    h.hacker_id 
  , h.name 
  , count(*) 

from 
    hackers as h 
    
    join challenges c 
       on h.hacker_id = c.hacker_id

group by  
    h.hacker_id 
  , h.name 

having  
      count(*) =  (
                    select 
                        max(t.co) 
                    from (
                          select 
                              count(*) as co 
                          from 
                              challenges 
                          group by 
                              hacker_id
                         ) as t 
                  )
   or count(*) in (
                    select 
                        t.coun 
                    from (
                          select 
                              count(*) as coun 
                          from 
                              challenges 
                          group by 
                              hacker_id
                        ) as t
                    group by 
                        t.coun 
                    having 
                        count(*) = 1)

order by 
    count(*) desc 
  , h.hacker_id;




/* ms sql server */
select 
    t2.hacker_id 
  , t2.name 
  , t2.cnt 

from (
      select 
          t.hacker_id 
        , t.name 
        , t.cnt 
        , count(*) 
            over(
              partition by 
                  t.cnt) 
            as s_cnt 
        , max(t.cnt) 
            over() 
            as ma 
        
        from (
              select 
                  h.hacker_id 
                , h.name 
                , count(*) as cnt
              
              from 
                  hackers as h 
                  
                  join challenges as c 
                     on h.hacker_id = c.hacker_id
              
              group by  
                  h.hacker_id 
                , h.name  
              ) as t  
      
      ) t2

where 
      1=1
  and t2.cnt = ma 
   or t2.s_cnt = 1 

order by 
    t2.cnt desc 
  , t2.hacker_id