--mysql  
select 
    c1.visited_on 
  , sum(c2.amount) 
      as amount 
  , round( 
            sum(c2.amount)/7 
          , 2 
         ) 
      as average_amount 

from (
      select 
          distinct visited_on 
      
      from 
          customer 
      
      where
            1=1 
        and str_to_date( visited_on , '%y-%m-%d')  
          > (
              select 
                  adddate( min(visited_on), interval 5 day)  
              
              from 
                  customer 
            ) 
     ) as c1 

    join customer c2
       on str_to_date( c2.visited_on , '%y-%m-%d') 
          between subdate(     c1.visited_on , interval 6 day)  
              and str_to_date( c1.visited_on , '%y-%m-%d')   

group by 
    c1.visited_on  

order by 
    c1.visited_on asc ;



--ms sql server
with cte as (
  select 
      distinct visited_on 
  
  from 
      customer 
  
  where 
        1=1
    and cast( visited_on as date ) 
      > (
          select 
              dateadd( 
                          day 
                        , 5 
                        , min(visited_on) 
                     )
          
          from 
              customer 
        ) 
            )



select 
    c1.visited_on 
  , sum(c2.amount) 
      as amount 
  , round( 
            sum(c2.amount)/7.0 
          , 2 
         ) 
      as average_amount 

from 
    cte as c1 

    join customer c2
       on cast( c2.visited_on as date ) 
          between dateadd(
                              day 
                            , -6 
                            , c1.visited_on 
                         )  

      and cast( c1.visited_on as date )   

group by 
    c1.visited_on 

order by 
    c1.visited_on asc ;




--mysql  
with cte as (
  select 
      distinct visited_on 
  
  from 
      customer 
  
  where 
        1=1
    and str_to_date( visited_on , '%y-%m-%d')
      > (
          select 
              adddate( min(visited_on), interval 5 day)  
          from customer 
        ) 
            ) 


, cte2 as (
  select 
      visited_on 
    , (
        select 
            sum(amount)  
        
        from 
            customer
      
        where
              1=1 
          and str_to_date( visited_on , '%y-%m-%d') 
              between subdate( c.visited_on, interval 6 day)  
                  and str_to_date( c.visited_on , '%y-%m-%d')   
      ) as amount
  
  from 
      cte c
          )



select 
    visited_on 
  , amount 
  , round( amount/7 , 2 ) 
      as average_amount

from 
    cte2;




--ms sql server
with cte as (
  select 
      distinct visited_on 
  
  from 
      customer 
  
  where 
        1=1
    and cast( visited_on as date )  
      > (
          select 
              dateadd(
                        day 
                      , 5 
                      , min(visited_on) 
                     )  

  from 
      customer 
        ) 
            ) 


, cte2 as (
  select 
      visited_on 
    , (
        select 
            sum(amount)  
        
        from 
            customer
      
        where 
              cast( visited_on as date ) 
                between dateadd(day , -6 , c.visited_on ) 
                    and cast(  c.visited_on  as date )   
      ) as amount
  
  from 
      cte c
          )



select 
    visited_on 
  , amount 
  , round( amount/7.0 , 2 ) 
      as average_amount

from 
    cte2;



--mysql
select 
    distinct visited_on 
  , amount 
  , round( amount/7 , 2 ) 
      as average_amount

from (
        select 
            visited_on 
          , sum( amount )
              over( 
                order by 
                    visited_on 
                range between 
                      interval 6 day preceding 
                  and current row 
                  )
              as amount
        
        from 
            customer
     ) as t

where 
      1=1
  and visited_on 
    > (
        select 
            adddate( min(visited_on) , interval 5 day)  
        
        from 
            customer )

order by 
    visited_on asc;




--ms sql server
--this could work if there were not missing dates as the description of the problem suggest by stating that 
--(there will be at least one customer every day).
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
