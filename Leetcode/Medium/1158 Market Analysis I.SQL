--mysql  &  ms sql server
with cte as (
  select 
      buyer_id 
    , count(*) as cnt 
  
  from 
      orders
  
  where 1=1
    and year(order_date) = '2019' 
  
  group by 
      buyer_id
  )

select 
    u.user_id as buyer_id 
  , u.join_date 
  , coalesce( c.cnt , 0 ) 
      as orders_in_2019

from 
    users u 
    
    left join cte c 
       on u.user_id = c.buyer_id ;



--mysql  &  ms sql server
select 
    u.user_id as buyer_id 
  , u.join_date 
  , count(o.buyer_id) 
      as orders_in_2019

from 
    users u 

    left join orders o
       on u.user_id = o.buyer_id 
      and year(o.order_date) = '2019'

group by 
    u.user_id  
  , u.join_date;



--mysql  &  ms sql server
select 
    user_id as buyer_id 
  , join_date 
  , (
      select 
          count(*) 
      
      from 
          orders o
      
      where
            1=1 
        and u.user_id = o.buyer_id
        and left( order_date , 4) = '2019' 
    ) as orders_in_2019

from 
    users u;
