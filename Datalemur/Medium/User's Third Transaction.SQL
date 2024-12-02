with t as (
  select 
      * 
    , row_number()
        over(
          partition by 
              user_id 
          order by 
              transaction_date asc) 
      as ind 
  
  from 
    transactions
)

select 
    user_id 
  , spend 
  , transaction_date 

from 
  t 

where 
      1=1
  and ind = 3;
