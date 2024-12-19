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
    hacker_id 
  , name 
  , amount 

from 
    number_of_challenges_per_student n 

where 
      amount = (select max(amount) from number_of_challenges_per_student ) 
   or amount not in(select amount from number_of_challenges_per_student where r = 2)

order by 
    amount desc 
  , hacker_id;



/* mysql  &  ms sql server */
select 
    h.hacker_id 
  , name 
  , count(*) 

from 
    hackers as h 
    
    join challenges c 
       on h.hacker_id = c.hacker_id

group by  
    h.hacker_id 
  , name 

having  
      count(*) =  (select max(co) from (select count(*) as co from challenges group by hacker_id) as t )
   or count(*) in (select coun 
                   
                   from (select count(*) as coun from challenges group by hacker_id) as t
                    group by coun having count(*) = 1)
order by count(*) desc ,  h.hacker_id;



--ms sql server
select hacker_id , name , cnt from (
    select hacker_id , name , cnt , count(*) over(partition by cnt) as s_cnt , 
    max(cnt) over() as ma from (
        select h.hacker_id , name , count(*) as cnt
        from hackers as h join challenges as c on h.hacker_id = c.hacker_id
        group by  h.hacker_id , name  ) as t  ) t2
where cnt = ma or s_cnt = 1 
order by cnt desc , hacker_id
