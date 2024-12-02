select 
    transaction_date 
  , user_id 
  , count(*) 

from (
  select 
      user_id 
    ,	spend 
    , transaction_date 
    , dense_rank() 
        over(
          partition by 
            user_id 
          order by 
            transaction_date desc 
        ) as ind
  
  from 
    user_transactions
) as t

where 
      1=1
  and ind = 1 

group by 
    transaction_date 
  , user_id

order by 
    transaction_date;
