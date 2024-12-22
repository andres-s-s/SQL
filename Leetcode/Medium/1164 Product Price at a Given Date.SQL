--mysql 
select 
    t.product_id 
  , coalesce( p.new_price , 10 ) 
      as price 

from (
      select 
          product_id 
        , max(
              case 
                  when str_to_date( change_date, '%y-%m-%d') 
                    <= str_to_date('2019-08-16', '%y-%m-%d')
              then change_date 
              
              end
             ) 
            as dt
    
      from 
          products
    
      group by 
          product_id
     ) as t 

    left join products p
       on p.product_id = t.product_id 
      and t.dt = p.change_date;



--mysql 
with cte as (
  select 
      distinct product_id 
    , first_value(new_price) 
        over(
          partition by 
              product_id 
          
          order by 
              change_date desc 
            ) 
        as price 
  
  from 
      products
  
  where 
        1=1
    and str_to_date( change_date, '%y-%m-%d') 
     <= str_to_date('2019-08-16', '%y-%m-%d')
            )


select 
    * 

from 
    cte 

union all 

select 
    distinct product_id 
  , 10 
      as price 

from 
    products

where 
    product_id not in (select product_id from cte );



--ms sql server
select 
    t.product_id 
  , coalesce( p.new_price , 10 ) 
      as price 

from (
      select 
          product_id 
        , max(
              case 
                  when cast( change_date  as date) 
                    <= cast('2019-08-16'  as date )
                  then change_date 
              
              end
             ) 
            as dt
    
      from 
          products
    
      group by 
          product_id
     ) as t 

    left join products p
       on p.product_id = t.product_id 
      and t.dt = p.change_date;



--ms sql server
with cte as (
  select 
      distinct product_id 
    , first_value(new_price) 
        over(
          partition by 
              product_id 
          order by 
              change_date desc 
            ) 
        as price 
  
  from 
      products

  where 
        1=1
    and cast( change_date  as date) 
     <= cast('2019-08-16'  as date )
            )


select 
    * 

from 
    cte 

union all 

select 
    distinct product_id 
  , 10 
      as price 

from 
    products

where 
    product_id not in (select product_id from cte );
