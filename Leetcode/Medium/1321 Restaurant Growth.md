### ➡️ Solution 1  

**MySQL**  

~~~sql  

with unique_dates as (

    select  
        distinct 
        visited_on

    from 
        Customer
    
    order by 
        visited_on asc
    
    limit 1000
    offset 6
)


select 
    u.visited_on
  , round(
        sum(c.amount)
      , 2
    )
      as amount
  , round(
        sum(c.amount)/7
      , 2
    )
      as average_amount

from 
    unique_dates u

    join customer c
       on c.visited_on between 
                                    date_sub(u.visited_on , interval 6 day) 
                                and u.visited_on

group by 
    u.visited_on
~~~

**MS SQL Server**

~~~sql
with unique_dates as (

    select  
        distinct 
        visited_on

    from 
        Customer
    
    order by 
        visited_on asc
    
    offset 6 rows
)


select 
    u.visited_on
  , round(
        sum(c.amount)
      , 2
    )
      as amount
  , round(
        sum(c.amount)/7.0
      , 2
    )
      as average_amount

from 
    unique_dates u

    join customer c
       on c.visited_on between 
                                    dateadd(day, -6, u.visited_on ) 
                                and u.visited_on

group by 
    u.visited_on
~~~

### ➡️ Solution 2  

**MySQL**, **PostgreSQL**

~~~sql
/* Add limit 1000 along offset for MySQL to run this code 
   This number is big and arbitrary since it cannot work with only offset */

with weekly_avg as (

    select  
        distinct 
        visited_on
      , sum(amount)
            over( order by 
                      visited_on asc
                  range between interval
                      '6' day preceding and current row
                 )

        as amount
    
      , sum(amount)
          over( order by 
                    visited_on asc
                range between interval
                    '6' day preceding and current row
        )
        /
        7.0
        as average_amount
    
    from 
        Customer
    
    order by 
        visited_on asc

    offset 6
)


select 
    visited_on
  , round( amount , 2)
      as amount
  , round( average_amount , 2)
      as average_amount

from 
    weekly_avg
~~~

**MS SQL Server**  

~~~sql
/* This could work if there were not missing dates as the description of the problem suggest by stating that 
   "There will be at least one customer every day" 
*/
with cte as (
  select 
      visited_on 
    , sum(amount) 
        as amount
  
  from 
      customer
  
  group by 
      visited_on

)

select 
    distinct visited_on 
  , amount 
  , round( amount/7.0 , 2 ) 
      as average_amount

from (
        select 
            visited_on 
          , sum( amount )
              over( 
                order by 
                    visited_on 
                rows between  
                      6 preceding 
                  and current row )
              as amount
          
          from 
              cte
     ) as t

where 
      1=1
  and visited_on 
    > ( 
        select 
            dateadd(day , 5 , min(visited_on) )  
        
        from 
            customer )

order by 
    visited_on asc;
~~~


