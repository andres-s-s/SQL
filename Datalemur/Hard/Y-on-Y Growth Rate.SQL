select 
    extract(year from transaction_date) as yr
  , product_id
  , spend as curr_year_spend 
  , pys   as prev_year_spend
  , round( ( ( spend - pys ) *100.0 )/pys 
             , 2 ) as yoy_rate

from (
    select
        *
      , lag(spend) 
      , over(partition by product_id 
      , order by transaction_date) as pys
    
    from user_transactions
) as T

order by 
    product_id
  , transaction_date asc;
