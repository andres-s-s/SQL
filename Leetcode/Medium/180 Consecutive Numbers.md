### ➡️ Solution 1  

**MySQL**,  **PostgreSQL**, **MS SQL Server**  

~~~sql 
with change_points as (

    select 
        l.num 
      , l.id 
      , case 
          when lag(l.num) 
                 over( order by l.id asc ) 
               = num 
          then 0 
          else 1 
        end 
        as tf

    from 
        logs l
)

, n_groups as (
    select 
        num 
      , sum(tf) 
          over( order by id asc ) 
        as  ind 
    
    from 
        change_points
) 


select  
    distinct 
    num 
    as consecutivenums 
  
from 
    n_groups

group by 
    num 
  , ind

having 
    count(*) >= 3 ;
~~~


### ➡️ Solution 2  

**MySQL**,  **PostgreSQL**, **MS SQL Server**  
~~~sql
select 
    distinct l.num 
      as consecutivenums 
      
from 
    logs l 

    join logs l2 
       on l.id = l2.id + 1 
      and l.num = l2.num 

    join logs l3 
       on l.id = l3.id + 2 
      and l.num = l3.num ;   
      /*You can replace + with -, but do it in both lines*/
~~~

### ➡️ Solution 3  

**MySQL**

~~~sql 
with consecutive as (

    select 
        l.num
      , @var :=
            if(num = @prev , @var , @var + 1 )
        as grp
      , @prev := num

    from 
        Logs l
    , (
        select 
            @var := 0
          , @prev = null
    ) as t
)


select 
    distinct 
    c.num 
    as ConsecutiveNums

from 
    consecutive c

group by 
    c.num
  , c.grp

having 
    count(*) >= 3  
~~~


### ➡️ Solution 4  

**MySQL**,  **PostgreSQL**, **MS SQL Server**

~~~sql

with numbers(n2 , n1 , n) as (
  select 
      lead( num , 2)  
        over(order by id asc ) 
    , lead( num ) 
        over(order by id asc ) /*You can replace lead with lag but do it in both lines*/
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
~~~


### ➡️ Solution 5  


~~~sql
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
~~~